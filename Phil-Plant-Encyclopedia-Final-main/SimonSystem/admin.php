<?php
require_once 'config.php';
require_admin();
$conn = connect_db();

$message = '';
$error = '';
$plantId = isset($_GET['id']) && is_numeric($_GET['id']) ? (int)$_GET['id'] : null;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $plantId = isset($_POST['id']) && is_numeric($_POST['id']) ? (int)$_POST['id'] : null;
    $municipalityIds = [];
    if (!empty($_POST['municipality'])) {
        $municipalityIds = is_array($_POST['municipality']) ? $_POST['municipality'] : [$_POST['municipality']];
    }
    $removePhotoIds = [];
    if (!empty($_POST['remove_photo_ids'])) {
        $removePhotoIds = is_array($_POST['remove_photo_ids']) ? $_POST['remove_photo_ids'] : [$_POST['remove_photo_ids']];
    }
    $commonName = trim($_POST['common_name'] ?? '');
    $scientificName = trim($_POST['scientific_name'] ?? '');
    $description = trim($_POST['description'] ?? '');
    $habitat = trim($_POST['habitat'] ?? '');
    $uses = trim($_POST['uses'] ?? '');
    $conservation = trim($_POST['conservation'] ?? '');

    if (!empty($_POST['delete_plant'])) {
        if ($plantId && delete_plant($conn, $plantId)) {
            $message = 'Plant deleted successfully.';
            $plantId = null;
            $editingPlant = null;
        } else {
            $error = 'Unable to delete the plant. Please try again.';
        }
    } else {
        $validationErrors = validate_plant_details([
            'municipality' => $municipalityIds,
            'common_name' => $commonName,
            'scientific_name' => $scientificName,
            'description' => $description,
            'habitat' => $habitat,
            'uses' => $uses,
            'conservation' => $conservation,
        ]);

        if (!empty($validationErrors)) {
            $error = implode(' ', $validationErrors);
        } else {
            $duplicatePlant = find_similar_plant_by_common_name($conn, $commonName, $plantId);
            if ($duplicatePlant) {
                $error = 'Plant already exists. Please update the existing record instead.';
            } else {
                $savedId = save_plant($conn, $plantId, $municipalityIds, $commonName, $scientificName, $description, $habitat, $uses, $conservation);
                if ($savedId) {
                    foreach ($removePhotoIds as $photoId) {
                        $photoId = (int)$photoId;
                        if ($photoId) {
                            delete_plant_photo($conn, $photoId);
                        }
                    }

                    if (!empty($_FILES['photos']) && !empty($_FILES['photos']['name'][0])) {
                        $uploadDir = __DIR__ . '/assets/uploads/';
                        for ($i = 0; $i < count($_FILES['photos']['name']); $i++) {
                            $tmpName = $_FILES['photos']['tmp_name'][$i] ?? null;
                            $origName = basename($_FILES['photos']['name'][$i] ?? '');
                            if ($tmpName && $origName) {
                                $ext = pathinfo($origName, PATHINFO_EXTENSION);
                                $safe = preg_replace('/[^a-zA-Z0-9-_\.]/', '_', pathinfo($origName, PATHINFO_FILENAME));
                                $filename = $safe . '_' . time() . '_' . $i . ($ext ? '.' . $ext : '');
                                if (move_uploaded_file($tmpName, $uploadDir . $filename)) {
                                    $stmt = $conn->prepare('INSERT INTO plant_photos (plant_id, filename) VALUES (?, ?)');
                                    $stmt->bind_param('is', $savedId, $filename);
                                    $stmt->execute();
                                }
                            }
                        }
                    }

                    $message = $plantId ? 'Plant updated successfully.' : 'Plant added successfully.';
                    $plantId = $savedId;
                } else {
                    $error = 'Unable to save the plant. Please try again.';
                }
            }
        }
    }
}

$editingPlant = null;
if ($plantId) {
    $editingPlant = fetch_plant($conn, $plantId);
}

$regions = fetch_regions($conn);
$provinces = fetch_provinces($conn);
$municipalities = fetch_municipalities($conn);
$searchQuery = isset($_GET['search']) ? trim((string)$_GET['search']) : '';
$plants = fetch_plants($conn, null, null, null, $searchQuery);


$selectedMunicipalities = $editingPlant['municipality_ids'] ?? [];
$selectedProvinceIds = [];
$selectedRegion = null;
if (!empty($selectedMunicipalities)) {
    $in = implode(',', array_map('intval', $selectedMunicipalities));
    $res = $conn->query("SELECT DISTINCT province_id FROM municipalities WHERE id IN ($in)");
    if ($res) {
        while ($row = $res->fetch_assoc()) {
            $selectedProvinceIds[] = (int)$row['province_id'];
        }
    }
    // derive a selected region if possible (first province -> region)
    if (!empty($selectedProvinceIds)) {
        $p = (int)$selectedProvinceIds[0];
        $rres = $conn->query("SELECT region_id FROM provinces WHERE id = $p LIMIT 1");
        if ($rres && $rr = $rres->fetch_assoc()) {
            $selectedRegion = (int)$rr['region_id'];
        }
    }
}


function escape($value)
{
    return htmlspecialchars($value, ENT_QUOTES, 'UTF-8');
}

/**
 * Validate required plant details before saving.
 * Expects keys: municipality (array), common_name, scientific_name, description, habitat, uses, conservation
 * Returns array of error messages (empty if valid).
 */
function validate_plant_details($data)
{
    $errors = [];
    $municipalities = $data['municipality'] ?? [];
    if (!is_array($municipalities) || count($municipalities) === 0) {
        $errors[] = 'At least one municipality is required.';
    }

    $fields = [
        'common_name' => 'Common name',
        'scientific_name' => 'Scientific name',
        'description' => 'Description',
        'habitat' => 'Habitat',
        'uses' => 'Uses',
        'conservation' => 'Conservation',
    ];

    foreach ($fields as $key => $label) {
        if (trim($data[$key] ?? '') === '') {
            $errors[] = "$label is required.";
        }
    }

    return $errors;
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin - Philippine Plants Encyclopedia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="assets/css/style.css" />
</head>

<body>
    <header class="hero py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="display-5 fw-bold text-white">Encyclopedia Admin</h1>
                    <p class="lead text-white-75 mb-4">Manage plant documentation for regions, provinces, and municipalities.</p>
                </div>
                <div class="col-lg-4 text-lg-end">
                </div>
            </div>
        </div>
    </header>

    <main class="container my-5">
        <section class="admin-actions mb-4">
            <div class="d-flex flex-column flex-lg-row justify-content-between align-items-start gap-3">
                <div>
                    <h2 class="h4 mb-1">Manage plant entries</h2>
                    <p class="text-muted mb-0">Add, edit, or remove plant records in the encyclopedia.</p>
                </div>
                <div class="d-flex flex-wrap gap-2">
                    <a class="btn btn-outline-primary" href="index.php">View public encyclopedia</a>
                    <a class="btn btn-outline-secondary" href="logout.php">Logout</a>
                </div>
            </div>
        </section>

        <section class="controls admin-controls card shadow-sm p-4 mb-5">
            <?php if ($message): ?>
                <div class="alert alert-success mb-4"><?= escape($message) ?></div>
            <?php endif; ?>
            <?php if ($error): ?>
                <div class="alert alert-danger mb-4"><?= escape($error) ?></div>
            <?php endif; ?>
            <form method="post" class="admin-form" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<?= escape($editingPlant['id'] ?? '') ?>" />

                <div class="row g-4 mb-4">
                    <div class="col-md-4">
                        <label for="region" class="form-label">Region</label>
                        <select id="region" name="region" class="form-select">
                            <option value="">Select region</option>
                            <?php foreach ($regions as $region): ?>
                                <option value="<?= escape($region['id']) ?>" <?= $selectedRegion === (int)$region['id'] ? 'selected' : '' ?>>
                                    <?= escape($region['name']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="province" class="form-label">Province (multi-select)</label>
                        <select id="province" name="province[]" multiple size="6" class="form-select">
                            <?php foreach ($provinces as $province): ?>
                                <option value="<?= escape($province['id']) ?>" data-region="<?= escape($province['region_id']) ?>" <?= in_array((int)$province['id'], $selectedProvinceIds, true) ? 'selected' : '' ?> >
                                    <?= escape($province['name']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="municipality" class="form-label">Municipality (multi-select)</label>
                        <select id="municipality" name="municipality[]" multiple size="8" class="form-select">
                            <?php foreach ($municipalities as $municipality): ?>
                                <option value="<?= escape($municipality['id']) ?>" data-province="<?= escape($municipality['province_id']) ?>" <?= in_array((int)$municipality['id'], $selectedMunicipalities, true) ? 'selected' : '' ?> >
                                    <?= escape($municipality['name']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                </div>

                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <label for="common_name" class="form-label">Common name</label>
                        <input id="common_name" name="common_name" type="text" class="form-control" value="<?= escape($editingPlant['common_name'] ?? '') ?>" required />
                    </div>
                    <div class="col-md-6">
                        <label for="scientific_name" class="form-label">Scientific name</label>
                        <input id="scientific_name" name="scientific_name" type="text" class="form-control" value="<?= escape($editingPlant['scientific_name'] ?? '') ?>" required />
                    </div>
                </div>

                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <label for="description" class="form-label">Description</label>
                        <textarea id="description" name="description" rows="4" class="form-control"><?= escape($editingPlant['description'] ?? '') ?></textarea>
                    </div>
                    <div class="col-md-6">
                        <label for="habitat" class="form-label">Habitat</label>
                        <textarea id="habitat" name="habitat" rows="4" class="form-control"><?= escape($editingPlant['habitat'] ?? '') ?></textarea>
                    </div>
                </div>

                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <label for="uses" class="form-label">Uses</label>
                        <textarea id="uses" name="uses" rows="4" class="form-control"><?= escape($editingPlant['uses'] ?? '') ?></textarea>
                    </div>
                    <div class="col-md-6">
                        <label for="conservation" class="form-label">Conservation</label>
                        <textarea id="conservation" name="conservation" rows="4" class="form-control"><?= escape($editingPlant['conservation'] ?? '') ?></textarea>
                    </div>
                </div>

                <?php if (!empty($editingPlant['photos'])): ?>
                    <div class="field-group existing-photos mb-4">
                        <label class="form-label">Existing photos</label>
                        <div class="photo-grid">
                            <?php foreach ($editingPlant['photos'] as $photo): ?>
                                <label class="photo-thumb">
                                    <img src="assets/uploads/<?= escape($photo['filename']) ?>" alt="<?= escape($editingPlant['common_name'] ?? 'Plant photo') ?>" />
                                    <span><input type="checkbox" name="remove_photo_ids[]" value="<?= escape($photo['id']) ?>"> Remove</span>
                                </label>
                            <?php endforeach; ?>
                        </div>
                    </div>
                <?php endif; ?>

                <div class="row g-4 mb-4">
                    <div class="col-12">
                        <label for="photos" class="form-label">Upload photos</label>
                        <input id="photos" name="photos[]" type="file" accept="image/*" multiple class="form-control" />
                    </div>
                </div>

                <div class="d-flex flex-wrap gap-2">
                    <button type="submit" class="btn btn-primary"><?= $editingPlant ? 'Update Plant' : 'Add Plant' ?></button>
                    <?php if ($editingPlant): ?>
                        <button type="submit" name="delete_plant" value="1" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this plant?');">Delete Plant</button>
                        <a class="btn btn-outline-secondary" href="admin.php">Create new plant</a>
                    <?php endif; ?>
                </div>
            </form>
        </section>

        <section class="plants admin-plants">
            <div class="card shadow-sm border-0">
                <div class="card-body">
                    <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4 gap-3">
                        <div>
                            <h2 class="h5 mb-1">Existing plants</h2>
                            <p class="text-muted mb-0"><?= count($plants) ?> plant<?= count($plants) === 1 ? '' : 's' ?> currently stored.</p>
                        </div>

                        <div class="w-100 w-md-auto" style="max-width: 420px;">
                            <form method="get" class="d-flex gap-2" role="search">
                                <input name="search" type="search" class="form-control" placeholder="Search plants" value="<?= escape($searchQuery ?? '') ?>" aria-label="Search plants" />
                                <button class="btn btn-primary" type="submit">Search</button>
                                <?php if (!empty($searchQuery ?? '')): ?>
                                    <a class="btn btn-outline-secondary" href="admin.php">Reset</a>
                                <?php endif; ?>
                            </form>
                        </div>
                    </div>


                    <div class="table-responsive">
                        <table class="plant-table table table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>Common name</th>
                                    <th>Scientific name</th>
                                    <th>Location</th>
                                    <th>Edit</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($plants as $plant): ?>
                                    <tr>
                                        <td><?= escape($plant['common_name']) ?></td>
                                        <td><?= escape($plant['scientific_name']) ?></td>
                                        <td><?= escape($plant['regions'] ?? '') ?> / <?= escape($plant['provinces'] ?? '') ?> / <?= escape($plant['municipalities'] ?? '') ?></td>
                                        <td>
                                            <a class="btn btn-sm btn-outline-primary" href="admin.php?id=<?= escape($plant['id']) ?>">Edit</a>
                                            <form method="post" class="d-inline" onsubmit="return confirm('Delete this plant?');">
                                                <input type="hidden" name="id" value="<?= escape($plant['id']) ?>" />
                                                <button type="submit" name="delete_plant" value="1" class="btn btn-sm btn-outline-danger">Delete</button>
                                            </form>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <footer class="footer">
        <p>Admin panel for Philippine Plants Encyclopedia</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const regionInput = document.getElementById('region');
        const provinceInput = document.getElementById('province');
        const municipalityInput = document.getElementById('municipality');

        if (provinceInput && municipalityInput) {
            const initialProvinceValues = Array.from(provinceInput.selectedOptions).map(o => o.value);
            const initialMunicipalityValues = Array.from(municipalityInput.selectedOptions).map(o => o.value);

            const provinces = Array.from(provinceInput.querySelectorAll('option')).map(o => ({
                value: o.value,
                text: o.textContent,
                region: o.dataset.region || '',
                wasSelected: o.selected
            }));

            const municipalities = Array.from(municipalityInput.querySelectorAll('option')).map(o => ({
                value: o.value,
                text: o.textContent,
                province: o.dataset.province || '',
                wasSelected: o.selected
            }));

            function rebuildProvinces() {
                const regionValue = regionInput ? regionInput.value : '';
                provinceInput.innerHTML = '';
                provinces.forEach(p => {
                    if (!p.region || String(p.region) === String(regionValue)) {
                        const opt = document.createElement('option');
                        opt.value = p.value;
                        opt.textContent = p.text;
                        if (p.wasSelected || initialProvinceValues.indexOf(p.value) !== -1) opt.selected = true;
                        provinceInput.appendChild(opt);
                    }
                });
            }

            function rebuildMunicipalities() {
                const selectedProvinceValues = Array.from(provinceInput.selectedOptions).map(o => o.value);
                municipalityInput.innerHTML = '';
                municipalities.forEach(m => {
                    if (!m.province || selectedProvinceValues.indexOf(String(m.province)) !== -1) {
                        const opt = document.createElement('option');
                        opt.value = m.value;
                        opt.textContent = m.text;
                        if (m.wasSelected || initialMunicipalityValues.indexOf(m.value) !== -1) opt.selected = true;
                        municipalityInput.appendChild(opt);
                    }
                });
            }

            if (regionInput) regionInput.addEventListener('change', function() { rebuildProvinces(); rebuildMunicipalities(); });
            provinceInput.addEventListener('change', rebuildMunicipalities);

            document.addEventListener('DOMContentLoaded', function() {
                rebuildProvinces();
                rebuildMunicipalities();
            });
        }
    </script>
</body>

</html>