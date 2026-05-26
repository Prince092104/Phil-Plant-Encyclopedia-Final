<?php
require_once 'config.php';
$conn = connect_db();

$selectedRegion = isset($_GET['region']) && is_numeric($_GET['region']) ? (int)$_GET['region'] : null;
$selectedProvince = isset($_GET['province']) && is_numeric($_GET['province']) ? (int)$_GET['province'] : null;
$selectedMunicipality = isset($_GET['municipality']) && is_numeric($_GET['municipality']) ? (int)$_GET['municipality'] : null;
$searchQuery = isset($_GET['search']) ? trim($_GET['search']) : '';

$regions = fetch_regions($conn);
$provinces = fetch_provinces($conn);
$municipalities = fetch_municipalities($conn);
$plants = fetch_plants($conn, $selectedRegion, $selectedProvince, $selectedMunicipality, $searchQuery);

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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="assets/css/style.css" />
</head>

<body>
    <header class="hero py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="display-5 fw-bold text-white">Philippine Plants Encyclopedia</h1>
                    <p class="lead text-white-75 mb-4">Explore native plants by region, province, and municipality with descriptions, habitat, uses, and conservation notes.</p>
                </div>
                <div class="col-lg-4 text-lg-end">
                    <a class="btn btn-light btn-lg text-primary" href="admin.php">Open admin panel</a>
                </div>
            </div>
        </div>
    </header>

    <main class="container my-5">
        <section class="search-panel mb-4">
            <div class="card shadow-sm border-0">
                <div class="card-body">
                    <form method="get" class="row gx-3 gy-3 align-items-end">
                        <div class="col-12 col-lg-4">
                            <label for="search" class="form-label">Search plants</label>
                            <input id="search" name="search" type="search" class="form-control form-control-lg" placeholder="Common or scientific name" value="<?= escape($searchQuery) ?>" onkeypress="if(event.key==='Enter') this.form.submit();" />
                        </div>

                        <div class="col-12 col-sm-6 col-lg-2">
                            <label for="region" class="form-label">Region</label>
                            <select id="region" name="region" class="form-select" onchange="this.form.submit()">
                                <option value="">All regions</option>
                                <?php foreach ($regions as $region): ?>
                                    <option value="<?= escape($region['id']) ?>" <?= $selectedRegion === (int)$region['id'] ? 'selected' : '' ?>>
                                        <?= escape($region['name']) ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>

                        <div class="col-12 col-sm-6 col-lg-2">
                            <label for="province" class="form-label">Province</label>
                            <select id="province" name="province" class="form-select">
                                <option value="">All provinces</option>
                                <?php foreach ($provinces as $province): ?>
                                    <option value="<?= escape($province['id']) ?>" data-region="<?= escape($province['region_id']) ?>" <?= $selectedProvince === (int)$province['id'] ? 'selected' : '' ?> >
                                        <?= escape($province['name']) ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>

                        <div class="col-12 col-sm-6 col-lg-2">
                            <label for="municipality" class="form-label">Municipality</label>
                            <select id="municipality" name="municipality" class="form-select">
                                <option value="">All municipalities</option>
                                <?php foreach ($municipalities as $municipality): ?>
                                    <option value="<?= escape($municipality['id']) ?>" data-province="<?= escape($municipality['province_id']) ?>" <?= $selectedMunicipality === (int)$municipality['id'] ? 'selected' : '' ?> >
                                        <?= escape($municipality['name']) ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>

                        <div class="col-12 col-sm-6 col-lg-auto d-grid">
                            <button type="submit" class="btn btn-primary btn-sm">Search</button>
                        </div>
                        <div class="col-12 col-sm-6 col-lg-auto d-grid">
                            <a class="btn btn-outline-secondary btn-sm" href="index.php">Reset</a>
                        </div>
                    </form>
                </div>
            </div>
        </section>

        <section class="plants">
            <?php if ($plants): ?>
                <div class="summary d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4 gap-3">
                    <div>
                        <h2 class="h4 mb-1">Plant results</h2>
                        <p class="mb-0 text-muted">Browse the most relevant plant documentation.</p>
                    </div>
                    <div class="text-muted">
                        <?= count($plants) ?> plant<?= count($plants) === 1 ? '' : 's' ?> found.
                    </div>
                </div>

                <div class="row gy-4">
                    <?php foreach ($plants as $plant): ?>
                        <?php
                            $photoSrc = null;
                            if (!empty($plant['photos'])) {
                                $photos = array_filter(array_map('trim', explode(',', $plant['photos'])));
                                $photoSrc = reset($photos) ?: null;
                            }
                        ?>
                        <div class="col-12">
                            <article class="plant-card card shadow-sm border-0 overflow-hidden plant-card-clickable" data-bs-toggle="modal" data-bs-target="#plantModal"
                                data-common-name="<?= escape($plant['common_name']) ?>"
                                data-scientific-name="<?= escape($plant['scientific_name']) ?>"
                                data-region="<?= escape($plant['regions'] ?? $plant['region'] ?? '') ?>"
                                data-province="<?= escape($plant['provinces'] ?? $plant['province'] ?? '') ?>"
                                data-municipality="<?= escape($plant['municipalities'] ?? $plant['municipality'] ?? '') ?>"
                                data-description="<?= escape($plant['description']) ?>"
                                data-habitat="<?= escape($plant['habitat']) ?>"
                                data-uses="<?= escape($plant['uses']) ?>"
                                data-conservation="<?= escape($plant['conservation']) ?>"
                                data-photo="<?= escape($photoSrc) ?>"
                            >
                                <div class="row g-0 align-items-stretch">
                                    <div class="col-lg-9">
                                        <div class="card-body">
                                            <header>
                                                <h3 class="h4 mb-2"><?= escape($plant['common_name']) ?></h3>
                                                <p class="text-muted mb-3">Scientific name: <strong><?= escape($plant['scientific_name']) ?></strong></p>
                                            </header>

                                            <div class="mb-3">
                                                <span class="badge bg-primary bg-opacity-15 text-primary me-2 mb-2">Region: <?= escape($plant['regions'] ?? $plant['region'] ?? '') ?></span>
                                                <span class="badge bg-success bg-opacity-15 text-success me-2 mb-2">Province: <?= escape($plant['provinces'] ?? $plant['province'] ?? '') ?></span>
                                                <span class="badge bg-info bg-opacity-15 text-info mb-2">Municipality: <?= escape($plant['municipalities'] ?? $plant['municipality'] ?? '') ?></span>
                                            </div>

                                            <div class="description">
                                                <p><strong>Description:</strong> <?= escape($plant['description']) ?></p>
                                                <p><strong>Habitat:</strong> <?= escape($plant['habitat']) ?></p>
                                                <p><strong>Uses:</strong> <?= escape($plant['uses']) ?></p>
                                                <p><strong>Conservation:</strong> <?= escape($plant['conservation']) ?></p>
                                            </div>
                                        </div>
                                    </div>
                                    <?php
                                        $photoSrc = null;
                                        if (!empty($plant['photos'])) {
                                            $photos = array_filter(array_map('trim', explode(',', $plant['photos'])));
                                            $photoSrc = reset($photos) ?: null;
                                        }
                                    ?>
                                    <?php if ($photoSrc): ?>
                                        <div class="col-lg-3 d-none d-lg-block">
                                            <img src="assets/uploads/<?= escape($photoSrc) ?>" alt="<?= escape($plant['common_name']) ?>" class="img-fluid h-100 w-100 object-fit-cover" />
                                        </div>
                                    <?php endif; ?>
                                </div>
                            </article>
                        </div>
                    <?php endforeach; ?>
                </div>
            <?php else: ?>
                <div class="empty-state card shadow-sm p-4 text-center">
                    <h2>No plants found</h2>
                    <p>Try selecting a different region, province, or municipality to see more plant documentation.</p>
                </div>
            <?php endif; ?>
        </section>
    </main>

    <div class="modal fade" id="plantModal" tabindex="-1" aria-labelledby="plantModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-bottom-0">
                    <div>
                        <h5 class="modal-title" id="plantModalLabel"></h5>
                        <p class="text-muted mb-0 modal-subtitle"></p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <img src="" alt="Plant image" class="img-fluid w-100 plant-modal-image mb-4 d-none" />
                    <div class="mb-3">
                        <span class="badge badge-region me-2 mb-2" id="plantModalRegion"></span>
                        <span class="badge badge-province me-2 mb-2" id="plantModalProvince"></span>
                        <span class="badge badge-municipality mb-2" id="plantModalMunicipality"></span>
                    </div>
                    <div class="mb-3">
                        <h6 class="mb-2">About</h6>
                        <p id="plantModalDescription" class="mb-3"></p>
                    </div>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <h6 class="mb-2">Habitat</h6>
                            <p id="plantModalHabitat" class="mb-0"></p>
                        </div>
                        <div class="col-md-6">
                            <h6 class="mb-2">Uses</h6>
                            <p id="plantModalUses" class="mb-0"></p>
                        </div>
                    </div>
                    <div class="mt-4">
                        <h6 class="mb-2">Conservation</h6>
                        <p id="plantModalConservation" class="mb-0"></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        <p>Philippine Plants Encyclopedia &copy; <?= date('Y') ?> Designed by Villeza, P. - IT3A</p>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        (function() {
            const regionInput = document.getElementById('region');
            const provinceInput = document.getElementById('province');
            const municipalityInput = document.getElementById('municipality');

            if (!regionInput || !provinceInput || !municipalityInput) return;

        const initialProvinceValue = provinceInput.value;
        const initialMunicipalityValue = municipalityInput.value;

        const provinces = Array.from(provinceInput.querySelectorAll('option')).map(o => ({
            value: o.value,
            text: o.textContent,
            region: o.dataset.region || '',
            isDefault: o.value === '',
            wasSelected: o.selected
        }));

        const municipalities = Array.from(municipalityInput.querySelectorAll('option')).map(o => ({
            value: o.value,
            text: o.textContent,
            province: o.dataset.province || '',
            isDefault: o.value === '',
            wasSelected: o.selected
        }));

        function rebuildProvinces() {
            const regionValue = regionInput.value;
            const currentProvinceValue = provinceInput.value;
            provinceInput.innerHTML = '';
            const defaultOpt = document.createElement('option');
            defaultOpt.value = '';
            defaultOpt.textContent = 'All provinces';
            provinceInput.appendChild(defaultOpt);

            provinces.forEach(p => {
                if (p.isDefault || !regionValue || String(p.region) === String(regionValue)) {
                    const opt = document.createElement('option');
                    opt.value = p.value;
                    opt.textContent = p.text;
                    if (p.value === currentProvinceValue) opt.selected = true;
                    provinceInput.appendChild(opt);
                }
            });

            if (!provinceInput.querySelector('option[selected]')) provinceInput.value = '';
            rebuildMunicipalities();
        }

        function rebuildMunicipalities() {
            const provinceValue = provinceInput.value;
            const currentMunicipalityValue = municipalityInput.value;
            municipalityInput.innerHTML = '';
            const defaultOpt = document.createElement('option');
            defaultOpt.value = '';
            defaultOpt.textContent = 'All municipalities';
            municipalityInput.appendChild(defaultOpt);

            municipalities.forEach(m => {
                if (m.isDefault || !provinceValue || String(m.province) === String(provinceValue)) {
                    const opt = document.createElement('option');
                    opt.value = m.value;
                    opt.textContent = m.text;
                    if (m.value === currentMunicipalityValue) opt.selected = true;
                    municipalityInput.appendChild(opt);
                }
            });

            if (!municipalityInput.querySelector('option[selected]')) municipalityInput.value = '';
        }

        regionInput.addEventListener('change', function() {
            rebuildProvinces();
            // keep behavior consistent with existing UI
            // (if desired, remove auto-submit to allow multi-select before submit)
            this.form.submit();
        });

        provinceInput.addEventListener('change', function() {
            rebuildMunicipalities();
        });

        municipalityInput.addEventListener('change', function() {
            // Just allow the selection to be made without auto-submitting
        });

        document.addEventListener('DOMContentLoaded', rebuildProvinces);

        var plantModal = document.getElementById('plantModal');
        if (plantModal) {
            plantModal.addEventListener('show.bs.modal', function (event) {
                var trigger = event.relatedTarget;
                if (!trigger) return;

                var commonName = trigger.dataset.commonName || 'Unknown plant';
                var scientificName = trigger.dataset.scientificName || 'Unknown scientific name';
                var region = trigger.dataset.region || 'Unknown region';
                var province = trigger.dataset.province || 'Unknown province';
                var municipality = trigger.dataset.municipality || 'Unknown municipality';
                var description = trigger.dataset.description || 'No description available.';
                var habitat = trigger.dataset.habitat || 'No habitat information available.';
                var uses = trigger.dataset.uses || 'No traditional uses recorded.';
                var conservation = trigger.dataset.conservation || 'No conservation notes available.';
                var photo = trigger.dataset.photo || '';

                plantModal.querySelector('.modal-title').textContent = commonName;
                plantModal.querySelector('.modal-subtitle').textContent = 'Scientific name: ' + scientificName;
                plantModal.querySelector('#plantModalRegion').textContent = 'Region: ' + region;
                plantModal.querySelector('#plantModalProvince').textContent = 'Province: ' + province;
                plantModal.querySelector('#plantModalMunicipality').textContent = 'Municipality: ' + municipality;
                plantModal.querySelector('#plantModalDescription').textContent = description;
                plantModal.querySelector('#plantModalHabitat').textContent = habitat;
                plantModal.querySelector('#plantModalUses').textContent = uses;
                plantModal.querySelector('#plantModalConservation').textContent = conservation;

                var imageEl = plantModal.querySelector('.plant-modal-image');
                if (photo) {
                    imageEl.src = 'assets/uploads/' + photo;
                    imageEl.classList.remove('d-none');
                } else {
                    imageEl.classList.add('d-none');
                }
            });
        }
    })();
</script>
</body>

</html>