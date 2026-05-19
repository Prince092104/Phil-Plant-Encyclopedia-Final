<?php
require_once 'config.php';
require_admin();
$conn = connect_db();

$message = '';
$error = '';
$plantId = isset($_GET['id']) && is_numeric($_GET['id']) ? (int)$_GET['id'] : null;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $plantId = isset($_POST['id']) && is_numeric($_POST['id']) ? (int)$_POST['id'] : null;
    $municipalityId = isset($_POST['municipality']) && is_numeric($_POST['municipality']) ? (int)$_POST['municipality'] : null;
    $commonName = trim($_POST['common_name'] ?? '');
    $scientificName = trim($_POST['scientific_name'] ?? '');
    $description = trim($_POST['description'] ?? '');
    $habitat = trim($_POST['habitat'] ?? '');
    $uses = trim($_POST['uses'] ?? '');
    $conservation = trim($_POST['conservation'] ?? '');

    if (!$municipalityId || $commonName === '' || $scientificName === '') {
        $error = 'Municipality, common name, and scientific name are required.';
    } else {
        $savedId = save_plant($conn, $plantId, $municipalityId, $commonName, $scientificName, $description, $habitat, $uses, $conservation);
        if ($savedId) {
            $message = $plantId ? 'Plant updated successfully.' : 'Plant added successfully.';
            $plantId = $savedId;
        } else {
            $error = 'Unable to save the plant. Please try again.';
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
$plants = fetch_plants($conn);

$selectedMunicipality = $editingPlant['municipality_id'] ?? null;
$selectedProvince = $editingPlant['province_id'] ?? null;
$selectedRegion = $editingPlant['region_id'] ?? null;

function escape($value)
{
    return htmlspecialchars($value, ENT_QUOTES, 'UTF-8');
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin - Philippine Plants Encyclopedia</title>
    <link rel="stylesheet" href="assets/css/style.css" />
</head>

<body>
    <header class="hero">
        <div class="container">
            <h1>Encyclopedia Admin</h1>
            <p>Manage plant documentation for regions, provinces, and municipalities.</p>
            <a class="hero-link" href="index.php">View public encyclopedia</a>
            <a class="hero-link" href="logout.php">Logout</a>
        </div>
    </header>

    <main class="container">
        <section class="controls admin-controls">
            <?php if ($message): ?>
                <div class="status success"><?= escape($message) ?></div>
            <?php endif; ?>
            <?php if ($error): ?>
                <div class="status error"><?= escape($error) ?></div>
            <?php endif; ?>
            <form method="post" class="admin-form">
                <input type="hidden" name="id" value="<?= escape($editingPlant['id'] ?? '') ?>" />

                <div class="form-grid">
                    <div class="field-group">
                        <label for="region">Region</label>
                        <select id="region" name="region">
                            <option value="">Select region</option>
                            <?php foreach ($regions as $region): ?>
                                <option value="<?= escape($region['id']) ?>" <?= $selectedRegion === (int)$region['id'] ? 'selected' : '' ?>>
                                    <?= escape($region['name']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <div class="field-group">
                        <label for="province">Province</label>
                        <select id="province" name="province">
                            <option value="">Select province</option>
                            <?php foreach ($provinces as $province): ?>
                                <option value="<?= escape($province['id']) ?>" data-region="<?= escape($province['region_id']) ?>" <?= $selectedProvince === (int)$province['id'] ? 'selected' : '' ?>>
                                    <?= escape($province['name']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <div class="field-group">
                        <label for="municipality">Municipality</label>
                        <select id="municipality" name="municipality">
                            <option value="">Select municipality</option>
                            <?php foreach ($municipalities as $municipality): ?>
                                <option value="<?= escape($municipality['id']) ?>" data-province="<?= escape($municipality['province_id']) ?>" <?= $selectedMunicipality === (int)$municipality['id'] ? 'selected' : '' ?>>
                                    <?= escape($municipality['name']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                </div>

                <div class="field-group">
                    <label for="common_name">Common name</label>
                    <input id="common_name" name="common_name" type="text" value="<?= escape($editingPlant['common_name'] ?? '') ?>" required />
                </div>

                <div class="field-group">
                    <label for="scientific_name">Scientific name</label>
                    <input id="scientific_name" name="scientific_name" type="text" value="<?= escape($editingPlant['scientific_name'] ?? '') ?>" required />
                </div>

                <div class="field-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" rows="4"><?= escape($editingPlant['description'] ?? '') ?></textarea>
                </div>

                <div class="field-group">
                    <label for="habitat">Habitat</label>
                    <textarea id="habitat" name="habitat" rows="3"><?= escape($editingPlant['habitat'] ?? '') ?></textarea>
                </div>

                <div class="field-group">
                    <label for="uses">Uses</label>
                    <textarea id="uses" name="uses" rows="3"><?= escape($editingPlant['uses'] ?? '') ?></textarea>
                </div>

                <div class="field-group">
                    <label for="conservation">Conservation</label>
                    <textarea id="conservation" name="conservation" rows="3"><?= escape($editingPlant['conservation'] ?? '') ?></textarea>
                </div>

                <div class="actions admin-actions">
                    <button type="submit"><?= $editingPlant ? 'Update Plant' : 'Add Plant' ?></button>
                    <?php if ($editingPlant): ?>
                        <a class="reset-link" href="admin.php">Create new plant</a>
                    <?php endif; ?>
                </div>
            </form>
        </section>

        <section class="plants admin-plants">
            <div class="summary">
                <h2>Existing plants</h2>
                <p><?= count($plants) ?> plant<?= count($plants) === 1 ? '' : 's' ?> in the encyclopedia</p>
            </div>

            <div class="plant-table-wrapper">
                <table class="plant-table">
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
                                <td><?= escape($plant['region']) ?> / <?= escape($plant['province']) ?> / <?= escape($plant['municipality']) ?></td>
                                <td><a class="edit-link" href="admin.php?id=<?= escape($plant['id']) ?>">Edit</a></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </section>
    </main>

    <footer class="footer">
        <p>Admin panel for Philippine Plants Encyclopedia</p>
    </footer>

    <script>
        const regionInput = document.getElementById('region');
        const provinceInput = document.getElementById('province');
        const municipalityInput = document.getElementById('municipality');

        function filterProvinces() {
            const regionValue = regionInput.value;
            const provinceOptions = provinceInput.querySelectorAll('option');
            let hasSelected = false;
            provinceOptions.forEach(option => {
                const isDefault = option.value === '';
                const matches = isDefault || option.dataset.region === regionValue;
                option.style.display = matches ? 'block' : 'none';
                if (!matches && option.selected) {
                    option.selected = false;
                }
                if (matches && option.selected) {
                    hasSelected = true;
                }
            });
            if (!hasSelected) {
                provinceInput.value = '';
            }
            filterMunicipalities();
        }

        function filterMunicipalities() {
            const provinceValue = provinceInput.value;
            const municipalityOptions = municipalityInput.querySelectorAll('option');
            let hasSelected = false;
            municipalityOptions.forEach(option => {
                const isDefault = option.value === '';
                const matches = isDefault || option.dataset.province === provinceValue;
                option.style.display = matches ? 'block' : 'none';
                if (!matches && option.selected) {
                    option.selected = false;
                }
                if (matches && option.selected) {
                    hasSelected = true;
                }
            });
            if (!hasSelected) {
                municipalityInput.value = '';
            }
        }

        regionInput.addEventListener('change', filterProvinces);
        provinceInput.addEventListener('change', filterMunicipalities);

        document.addEventListener('DOMContentLoaded', function() {
            filterProvinces();
        });
    </script>
</body>

</html>