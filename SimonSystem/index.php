<?php
require_once 'config.php';
$conn = connect_db();

$selectedRegion = isset($_GET['region']) && is_numeric($_GET['region']) ? (int)$_GET['region'] : null;
$selectedProvince = isset($_GET['province']) && is_numeric($_GET['province']) ? (int)$_GET['province'] : null;
$selectedMunicipality = isset($_GET['municipality']) && is_numeric($_GET['municipality']) ? (int)$_GET['municipality'] : null;

$regions = fetch_regions($conn);
$provinces = fetch_provinces($conn, $selectedRegion);
$municipalities = fetch_municipalities($conn, $selectedProvince);
$plants = fetch_plants($conn, $selectedRegion, $selectedProvince, $selectedMunicipality);

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
    <title>Philippine Plants Encyclopedia</title>
    <link rel="stylesheet" href="assets/css/style.css" />
</head>

<body>
    <header class="hero">
        <div class="container">
            <h1>Philippine Plants Encyclopedia</h1>
            <p>Explore native plants by region, province, and municipality, with descriptions, habitat, uses, and conservation notes.</p>
            <a class="hero-link" href="admin.php">Open admin panel</a>
        </div>
    </header>

    <main class="container">
        <section class="controls">
            <form method="get" class="filter-form">
                <div class="field-group">
                    <label for="region">Region</label>
                    <select id="region" name="region" onchange="this.form.submit()">
                        <option value="">All regions</option>
                        <?php foreach ($regions as $region): ?>
                            <option value="<?= escape($region['id']) ?>" <?= $selectedRegion === (int)$region['id'] ? 'selected' : '' ?>>
                                <?= escape($region['name']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="field-group">
                    <label for="province">Province</label>
                    <select id="province" name="province" onchange="this.form.submit()">
                        <option value="">All provinces</option>
                        <?php foreach ($provinces as $province): ?>
                            <option value="<?= escape($province['id']) ?>" <?= $selectedProvince === (int)$province['id'] ? 'selected' : '' ?>>
                                <?= escape($province['name']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="field-group">
                    <label for="municipality">Municipality</label>
                    <select id="municipality" name="municipality" onchange="this.form.submit()">
                        <option value="">All municipalities</option>
                        <?php foreach ($municipalities as $municipality): ?>
                            <option value="<?= escape($municipality['id']) ?>" <?= $selectedMunicipality === (int)$municipality['id'] ? 'selected' : '' ?>>
                                <?= escape($municipality['name']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="actions">
                    <button type="submit">Show plants</button>
                    <a class="reset-link" href="index.php">Reset filters</a>
                </div>
            </form>
        </section>

        <section class="plants">
            <?php if ($plants): ?>
                <div class="summary">
                    <h2>Plant results</h2>
                    <p><?= count($plants) ?> plant<?= count($plants) === 1 ? '' : 's' ?> found.</p>
                </div>

                <?php foreach ($plants as $plant): ?>
                    <article class="plant-card">
                        <header>
                            <h3><?= escape($plant['common_name']) ?></h3>
                            <p class="scientific">Scientific name: <strong><?= escape($plant['scientific_name']) ?></strong></p>
                        </header>
                        <div class="meta">
                            <span><strong>Region:</strong> <?= escape($plant['region']) ?></span>
                            <span><strong>Province:</strong> <?= escape($plant['province']) ?></span>
                            <span><strong>Municipality:</strong> <?= escape($plant['municipality']) ?></span>
                        </div>
                        <div class="description">
                            <p><strong>Description:</strong> <?= escape($plant['description']) ?></p>
                            <p><strong>Habitat:</strong> <?= escape($plant['habitat']) ?></p>
                            <p><strong>Uses:</strong> <?= escape($plant['uses']) ?></p>
                            <p><strong>Conservation:</strong> <?= escape($plant['conservation']) ?></p>
                        </div>
                    </article>
                <?php endforeach; ?>
            <?php else: ?>
                <div class="empty-state">
                    <h2>No plants found</h2>
                    <p>Try selecting a different region, province, or municipality to see more plant documentation.</p>
                </div>
            <?php endif; ?>
        </section>
    </main>

    <footer class="footer">
        <p>Philippine Plants Encyclopedia &copy; <?= date('Y') ?>. Use this system to explore plants by location.</p>
    </footer>
</body>

</html>