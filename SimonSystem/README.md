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
