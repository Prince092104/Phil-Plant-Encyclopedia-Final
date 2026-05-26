<?php
require_once __DIR__ . '/config.php';

if (PHP_SAPI !== 'cli') {
    echo "This script must be run from the command line.\n";
    exit(1);
}

$options = getopt('', [
    'source:',
    'format::',
    'photos-dir::',
    'mapping::',
    'skip-existing',
    'dry-run',
    'help',
]);

if (isset($options['help']) || empty($options['source'])) {
    echo "Usage: php migrate_dataset.php --source=path/to/dataset.csv [--format=csv|json] [--photos-dir=assets/uploads] [--mapping=field-map.json] [--skip-existing] [--dry-run]\n";
    echo "\n";
    echo "Options:\n";
    echo "  --source       Path to CSV or JSON dataset file.\n";
    echo "  --format       Optional input format if extension is not csv or json.\n";
    echo "  --photos-dir   Directory to copy/import photo files into. Default: assets/uploads.\n";
    echo "  --mapping      Optional JSON file that maps dataset column names to app fields.\n";
    echo "  --skip-existing  Skip plants that already exist by scientific name.\n";
    echo "  --dry-run      Validate and print import actions without writing to the database.\n";
    echo "\n";
    echo "Supported app fields: common_name, scientific_name, description, habitat, uses, conservation, municipalities, photos\n";
    exit(0);
}

$source = $options['source'];
$format = isset($options['format']) ? strtolower($options['format']) : strtolower(pathinfo($source, PATHINFO_EXTENSION));
$photosDir = isset($options['photos-dir']) ? $options['photos-dir'] : __DIR__ . '/assets/uploads';
$mappingFile = isset($options['mapping']) ? $options['mapping'] : null;
$skipExisting = isset($options['skip-existing']);
$dryRun = isset($options['dry-run']);

if (!file_exists($source) || !is_readable($source)) {
    echo "Source file not found or not readable: $source\n";
    exit(1);
}

if (!in_array($format, ['csv', 'json'], true)) {
    echo "Unsupported format: $format. Supported formats are csv and json.\n";
    exit(1);
}

$fieldMap = loadFieldMap($mappingFile);
$data = loadDataFile($source, $format);
if ($data === false) {
    echo "Unable to load dataset from $source\n";
    exit(1);
}

$conn = connect_db();
if (!is_dir($photosDir)) {
    if (!mkdir($photosDir, 0755, true)) {
        echo "Unable to create photo directory: $photosDir\n";
        exit(1);
    }
}

$summary = [
    'rows' => count($data),
    'imported' => 0,
    'skipped' => 0,
    'errors' => 0,
];

foreach ($data as $index => $row) {
    $lineNumber = $index + 1;
    $plant = mapDatasetRow($row, $fieldMap);

    if (empty($plant['common_name']) && empty($plant['scientific_name'])) {
        echo "Skipping line $lineNumber: missing common_name or scientific_name.\n";
        $summary['skipped']++;
        continue;
    }

    $municipalityIds = resolveMunicipalityIds($conn, $plant['municipalities'] ?? '');
    if (empty($municipalityIds)) {
        echo "Skipping line $lineNumber: could not resolve municipalities for '{$plant['municipalities']}'.\n";
        $summary['skipped']++;
        continue;
    }

    if ($skipExisting && plantExists($conn, $plant['scientific_name'] ?? '', $plant['common_name'] ?? '')) {
        echo "Skipping line $lineNumber: plant already exists ({$plant['scientific_name']}).\n";
        $summary['skipped']++;
        continue;
    }

    if ($dryRun) {
        echo "Dry run: would import '{$plant['scientific_name']}' with municipalities " . implode(', ', $municipalityIds) . ".\n";
        $summary['imported']++;
        continue;
    }

    $plantId = insertPlant($conn, $plant);
    if (!$plantId) {
        echo "Error inserting plant on line $lineNumber.\n";
        $summary['errors']++;
        continue;
    }

    insertPlantMunicipalities($conn, $plantId, $municipalityIds);
    insertPlantPhotos($conn, $plantId, $plant['photos'] ?? [], $photosDir);

    $summary['imported']++;
}

echo "Import complete: {$summary['imported']} imported, {$summary['skipped']} skipped, {$summary['errors']} errors.\n";

function loadFieldMap($mappingFile)
{
    $default = [
        'common_name' => ['common_name', 'vernacular_name', 'english_name', 'name', 'plant_name'],
        'scientific_name' => ['scientific_name', 'latin_name', 'botanical_name', 'sci_name'],
        'description' => ['description', 'notes', 'detail'],
        'habitat' => ['habitat', 'environment', 'growth_habitat'],
        'uses' => ['uses', 'utility', 'medicinal_uses', 'traditional_uses'],
        'conservation' => ['conservation', 'status', 'threat_status'],
        'municipalities' => ['municipalities', 'location', 'locations', 'region_province_municipality', 'place'],
        'photos' => ['photos', 'photo_paths', 'photo_urls', 'images'],
    ];

    if ($mappingFile === null) {
        return $default;
    }

    if (!file_exists($mappingFile) || !is_readable($mappingFile)) {
        echo "Mapping file not readable: $mappingFile\n";
        exit(1);
    }

    $json = file_get_contents($mappingFile);
    $map = json_decode($json, true);
    if (!is_array($map)) {
        echo "Invalid JSON mapping file: $mappingFile\n";
        exit(1);
    }

    foreach ($default as $key => $candidates) {
        if (!isset($map[$key])) {
            $map[$key] = $candidates;
        }
    }

    return $map;
}

function loadDataFile($source, $format)
{
    if ($format === 'csv') {
        return loadCsv($source);
    }

    if ($format === 'json') {
        return loadJson($source);
    }

    return false;
}

function loadCsv($path)
{
    $handle = fopen($path, 'r');
    if (!$handle) {
        return false;
    }

    $headers = fgetcsv($handle);
    if ($headers === false) {
        fclose($handle);
        return false;
    }

    $headers = array_map('trim', $headers);
    $data = [];
    while (($row = fgetcsv($handle)) !== false) {
        if (count($row) === 0) {
            continue;
        }
        $row = array_map('trim', $row);
        $data[] = array_combine($headers, $row);
    }
    fclose($handle);
    return $data;
}

function loadJson($path)
{
    $json = file_get_contents($path);
    if ($json === false) {
        return false;
    }
    $data = json_decode($json, true);
    if (is_array($data)) {
        if (array_keys($data) === range(0, count($data) - 1)) {
            return $data;
        }
        return [$data];
    }
    return false;
}

function mapDatasetRow(array $row, array $fieldMap)
{
    $mapped = [];
    $normalized = [];
    foreach ($row as $key => $value) {
        $normalized[strtolower(trim($key))] = $value;
    }

    foreach ($fieldMap as $target => $candidates) {
        foreach ((array) $candidates as $candidate) {
            $candidateKey = strtolower(trim($candidate));
            if (isset($normalized[$candidateKey]) && $normalized[$candidateKey] !== '') {
                $mapped[$target] = $normalized[$candidateKey];
                break;
            }
        }
    }

    if (isset($mapped['photos']) && is_string($mapped['photos'])) {
        $mapped['photos'] = preg_split('/\||,|;/', $mapped['photos']);
    }

    return $mapped;
}

function normalizeText($value)
{
    return trim(preg_replace('/\s+/', ' ', mb_strtolower($value, 'UTF-8')));
}

function resolveMunicipalityIds($conn, $locations)
{
    if (empty($locations)) {
        return [];
    }

    if (!is_array($locations)) {
        $locations = preg_split('/\||;|,/u', $locations);
    }

    $municipalityIds = [];
    foreach ($locations as $location) {
        $location = trim($location);
        if ($location === '') {
            continue;
        }

        if (ctype_digit($location)) {
            $id = (int) $location;
            if (municipalityExists($conn, $id)) {
                $municipalityIds[] = $id;
            }
            continue;
        }

        $parts = preg_split('/\s*>\s*|\s*\/\s*/u', $location);
        $parts = array_map('normalizeText', $parts);
        $parts = array_filter($parts, fn($p) => $p !== '');
        if (count($parts) === 3) {
            [$region, $province, $municipality] = $parts;
            $found = findMunicipality($conn, $municipality, $province, $region);
        } elseif (count($parts) === 2) {
            [$province, $municipality] = $parts;
            $found = findMunicipality($conn, $municipality, $province, null);
        } else {
            $found = findMunicipality($conn, $parts[0], null, null);
        }

        if ($found !== null) {
            $municipalityIds[] = $found;
        }
    }

    return array_values(array_unique($municipalityIds));
}

function municipalityExists($conn, $id)
{
    $stmt = $conn->prepare('SELECT id FROM municipalities WHERE id = ? LIMIT 1');
    $stmt->bind_param('i', $id);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result && $result->num_rows === 1;
}

function findMunicipality($conn, $municipality, $province = null, $region = null)
{
    $municipality = normalizeText($municipality);
    if ($province !== null) {
        $province = normalizeText($province);
    }
    if ($region !== null) {
        $region = normalizeText($region);
    }

    if ($region !== null && $province !== null) {
        $sql = 'SELECT m.id FROM municipalities m JOIN provinces p ON m.province_id = p.id JOIN regions r ON p.region_id = r.id WHERE LOWER(m.name) = ? AND LOWER(p.name) = ? AND LOWER(r.name) = ? LIMIT 1';
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('sss', $municipality, $province, $region);
    } elseif ($province !== null) {
        $sql = 'SELECT m.id FROM municipalities m JOIN provinces p ON m.province_id = p.id WHERE LOWER(m.name) = ? AND LOWER(p.name) = ? LIMIT 1';
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('ss', $municipality, $province);
    } else {
        $sql = 'SELECT id FROM municipalities WHERE LOWER(name) = ? LIMIT 1';
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('s', $municipality);
    }

    if (!$stmt) {
        return null;
    }

    $stmt->execute();
    $result = $stmt->get_result();
    if ($result && $row = $result->fetch_assoc()) {
        return (int) $row['id'];
    }

    return null;
}

function plantExists($conn, $scientificName, $commonName)
{
    if ($scientificName !== '') {
        $stmt = $conn->prepare('SELECT id FROM plants WHERE LOWER(scientific_name) = ? LIMIT 1');
        $lower = normalizeText($scientificName);
        $stmt->bind_param('s', $lower);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($result && $result->num_rows === 1) {
            return true;
        }
    }

    if ($commonName !== '') {
        $stmt = $conn->prepare('SELECT id FROM plants WHERE LOWER(common_name) = ? LIMIT 1');
        $lower = normalizeText($commonName);
        $stmt->bind_param('s', $lower);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result && $result->num_rows === 1;
    }

    return false;
}

function insertPlant($conn, array $plant)
{
    $stmt = $conn->prepare('INSERT INTO plants (common_name, scientific_name, description, habitat, uses, conservation) VALUES (?, ?, ?, ?, ?, ?)');
    if (!$stmt) {
        return false;
    }

    $commonName = $plant['common_name'] ?? '';
    $scientificName = $plant['scientific_name'] ?? '';
    $description = $plant['description'] ?? '';
    $habitat = $plant['habitat'] ?? '';
    $uses = $plant['uses'] ?? '';
    $conservation = $plant['conservation'] ?? '';

    $stmt->bind_param('ssssss', $commonName, $scientificName, $description, $habitat, $uses, $conservation);
    return $stmt->execute() ? $conn->insert_id : false;
}

function insertPlantMunicipalities($conn, $plantId, array $municipalityIds)
{
    $stmt = $conn->prepare('INSERT INTO plant_municipalities (plant_id, municipality_id) VALUES (?, ?)');
    if (!$stmt) {
        return;
    }
    foreach ($municipalityIds as $mid) {
        $mid = (int) $mid;
        $stmt->bind_param('ii', $plantId, $mid);
        $stmt->execute();
    }
}

function insertPlantPhotos($conn, $plantId, array $photoPaths, $photosDir)
{
    if (empty($photoPaths)) {
        return;
    }

    $stmt = $conn->prepare('INSERT INTO plant_photos (plant_id, filename) VALUES (?, ?)');
    if (!$stmt) {
        return;
    }

    foreach ($photoPaths as $photoPath) {
        $photoPath = trim($photoPath);
        if ($photoPath === '') {
            continue;
        }

        $filename = basename($photoPath);
        $target = rtrim($photosDir, DIRECTORY_SEPARATOR) . DIRECTORY_SEPARATOR . $filename;

        if (!file_exists($target)) {
            if (file_exists($photoPath)) {
                copy($photoPath, $target);
            } else {
                continue;
            }
        }

        $stmt->bind_param('is', $plantId, $filename);
        $stmt->execute();
    }
}
