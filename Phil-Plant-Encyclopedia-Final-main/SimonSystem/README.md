# Philippine Plants Encyclopedia

A simple PHP/MySQL encyclopedia that displays Philippine plants by region, province, and municipality.

## Setup

1. Place the folder in your Apache document root (for XAMPP this is usually `C:\xampp\htdocs`).
2. Import `database.sql` into MySQL using phpMyAdmin or the MySQL command line.
3. Update database credentials in `config.php` if needed.
4. Open `http://localhost/SimonSystem/` in your browser.

## Admin login

- Visit `http://localhost/SimonSystem/login.php` to access the admin panel.
- Default admin credentials:
  - Username: `admin`
  - Password: `admin123`

## Files

- `index.php` — main encyclopedia page with filters.
- `config.php` — database connection and query helpers.
- `database.sql` — schema and sample plant data.
- `admin.php` — add and edit plant documentation.
- `assets/css/style.css` — styling for the interface.
- `bulk_import.php` — command-line CSV importer for bulk plant uploads.
- `migrate_dataset.php` — dataset migration script for public CSV or JSON plant datasets.
- `plant_import_template.csv` — sample import template with location and photo fields.
- `dataset_field_map_example.json` — an example field mapping for datasets with custom column names.

## Bulk import

1. Place your photo files in `assets/uploads/` or provide absolute paths in the `photos` column.
2. Prepare a CSV with the headers shown in `plant_import_template.csv`.
3. Run:

```powershell
php bulk_import.php path\to\plants.csv
```

4. The importer resolves municipalities by ID or by `region > province > municipality` strings.

## Public dataset migration

If you have a public plant dataset in CSV or JSON format, use `migrate_dataset.php`.

```powershell
php migrate_dataset.php --source=path\to\dataset.csv --photos-dir=assets/uploads --mapping=dataset_field_map_example.json
```

Options:
- `--format=csv|json` if the file extension does not match the format.
- `--skip-existing` to avoid importing plants already in the database.
- `--dry-run` to validate the dataset without writing anything.

The script maps dataset columns into the app fields and resolves municipality locations using Philippine region/province/municipality names.
