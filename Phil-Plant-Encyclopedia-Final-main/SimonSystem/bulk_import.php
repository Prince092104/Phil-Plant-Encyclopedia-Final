<?php
require_once __DIR__ . '/config.php';

if (PHP_SAPI !== 'cli') {
    echo "Run this script from the command line: php bulk_import.php path/to/plants.csv\n";
    exit(1);
}

if ($argc < 2) {
    echo "Usage: php bulk_import.php path/to/plants.csv [upload-directory]\n";
    exit(1);
}

$csvPath = $argv[1];
$uploadDir = isset($argv[2]) ? $argv[2] : __DIR__ . '/assets/uploads';

if (!file_exists($csvPath) || !is_readable($csvPath)) {
    echo "CSV file not found or not readable: $csvPath\n";
    exit(1);
}

if (!is_dir($uploadDir)) {
    if (!mkdir($uploadDir, 0755, true)) {
        echo "Unable to create upload directory: $uploadDir\n";
        exit(1);
    }
}

$conn = connect_db();
$handle = fopen($csvPath, 'r');
$headers = fgetcsv($handle);
if (!$headers) {
    echo "CSV file is empty or invalid.\n";
    exit(1);
}

$required = ['common_name', 'scientific_name', 'description', 'habitat', 'uses', 'conservation', 'municipalities'];
$normalized = array_map('trim', $headers);
$map = array_flip($normalized);
foreach ($required as $field) {
    if (!isset($map[$field])) {
        echo "Missing required CSV column: $field\n";
        echo "Required columns: " . implode(', ', $required) . "\n";
        exit(1);
    }
}

function normalizeLocation($value)
{
    return trim(preg_replace('/\s+/', ' ', $value));
}

function resolveMunicipalityIds($conn, $rawString)
{
    $ids = [];
    $items = array_map('trim', explode('|', $rawString));
    foreach ($items as $item) {
        if ($item === '') {
            continue;
        }
        if (ctype_digit($item)) {
            $ids[] = (int)$item;
            continue;
        }

        // allow region>province>municipality, province>municipality, or municipality only
        $parts = array_map('normalizeLocation', explode('>', $item));
        $params = [];
        $wheres = [];

        if (count($parts) === 3) {
            $region = $parts[0];
            $province = $parts[1];
            $municipality = $parts[2];
            $sql = "SELECT m.id FROM municipalities m JOIN provinces p ON m.province_id = p.id JOIN regions r ON p.region_id = r.id WHERE r.name = ? AND p.name = ? AND m.name = ? LIMIT 1";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param('sss', $region, $province, $municipality);
        } elseif (count($parts) === 2) {
            $province = $parts[0];
            $municipality = $parts[1];
            $sql = "SELECT m.id FROM municipalities m JOIN provinces p ON m.province_id = p.id WHERE p.name = ? AND m.name = ? LIMIT 1";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param('ss', $province, $municipality);
        } else {
            $municipality = $parts[0];
            $sql = "SELECT id FROM municipalities WHERE name = ? LIMIT 1";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param('s', $municipality);
        }

        if (!$stmt) {
            continue;
        }

        $stmt->execute();
        $res = $stmt->get_result();
        $row = $res ? $res->fetch_assoc() : null;
        if ($row && isset($row['id'])) {
            $ids[] = (int)$row['id'];
        }
    }

    return array_values(array_unique($ids));
}

function insertPlant($conn, $plantData)
{
    $stmt = $conn->prepare('INSERT INTO plants (common_name, scientific_name, description, habitat, uses, conservation) VALUES (?, ?, ?, ?, ?, ?)');
    $stmt->bind_param('ssssss', $plantData['common_name'], $plantData['scientific_name'], $plantData['description'], $plantData['habitat'], $plantData['uses'], $plantData['conservation']);
    if (!$stmt->execute()) {
        return false;
    }
    return $conn->insert_id;
}

function insertPlantMunicipalities($conn, $plantId, $municipalityIds)
{
    $stmt = $conn->prepare('INSERT INTO plant_municipalities (plant_id, municipality_id) VALUES (?, ?)');
    foreach ($municipalityIds as $mid) {
        $stmt->bind_param('ii', $plantId, $mid);
        $stmt->execute();
    }
}

function insertPlantPhotos($conn, $plantId, array $photoPaths, $uploadDir)
{
    $stmt = $conn->prepare('INSERT INTO plant_photos (plant_id, filename) VALUES (?, ?)');
    foreach ($photoPaths as $photoPath) {
        $photoPath = trim($photoPath);
        if ($photoPath === '') {
            continue;
        }

        $filename = basename($photoPath);
        $target = rtrim($uploadDir, DIRECTORY_SEPARATOR) . DIRECTORY_SEPARATOR . $filename;

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

$line = 1;
$imported = 0;
$skipped = 0;

while (($data = fgetcsv($handle)) !== false) {
    $line++;
    if (count($data) < count($headers)) {
        echo "Skipping line $line: not enough columns\n";
        $skipped++;
        continue;
    }

    $row = array_combine($normalized, $data);
    $municipalityIds = resolveMunicipalityIds($conn, $row['municipalities']);
    if (empty($municipalityIds)) {
        echo "Skipping line $line: could not resolve municipalities -> {$row['municipalities']}\n";
        $skipped++;
        continue;
    }

    $plantId = insertPlant($conn, $row);
    if (!$plantId) {
        echo "Failed to insert plant on line $line\n";
        $skipped++;
        continue;
    }

    insertPlantMunicipalities($conn, $plantId, $municipalityIds);

    if (!empty($row['photos'])) {
        $photos = array_filter(array_map('trim', explode('|', $row['photos'])));
        insertPlantPhotos($conn, $plantId, $photos, $uploadDir);
    }

    $imported++;
}

fclose($handle);

echo "Import complete: $imported imported, $skipped skipped.\n";
