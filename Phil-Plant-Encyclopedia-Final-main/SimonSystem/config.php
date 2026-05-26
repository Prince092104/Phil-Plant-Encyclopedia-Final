<?php
// Philippine Plants Encyclopedia database configuration.
// Update these values to match your MySQL server.
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASSWORD', '');
define('DB_NAME', 'philippine_plants_encyclopedia');

// reCAPTCHA v2 keys - replace these with your site's keys from https://www.google.com/recaptcha/admin
// Example: define('RECAPTCHA_SITE_KEY', '6L...');
//          define('RECAPTCHA_SECRET_KEY', '6L...');
define('RECAPTCHA_SITE_KEY', '6LeJoPcsAAAAADlO6YU85AX7Is62H29Gw3PbcObd');
define('RECAPTCHA_SECRET_KEY', '6LeJoPcsAAAAAJodqu6Fs-8BtiP1dv4YAYW_A15e');

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

function connect_db()
{
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
    if ($conn->connect_error) {
        die('Database connection failed: ' . $conn->connect_error);
    }
    $conn->set_charset('utf8mb4');
    return $conn;
}

function fetch_regions($conn)
{
    $result = $conn->query('SELECT id, name FROM regions ORDER BY name');
    return $result ? $result->fetch_all(MYSQLI_ASSOC) : [];
}

function fetch_provinces($conn, $regionId = null)
{
    $sql = 'SELECT id, region_id, name FROM provinces';
    if ($regionId) {
        $stmt = $conn->prepare($sql . ' WHERE region_id = ? ORDER BY name');
        $stmt->bind_param('i', $regionId);
        $stmt->execute();
        $result = $stmt->get_result();
    } else {
        $result = $conn->query($sql . ' ORDER BY name');
    }
    return $result ? $result->fetch_all(MYSQLI_ASSOC) : [];
}

function fetch_municipalities($conn, $provinceId = null)
{
    $sql = 'SELECT id, province_id, name FROM municipalities';
    if ($provinceId) {
        $stmt = $conn->prepare($sql . ' WHERE province_id = ? ORDER BY name');
        $stmt->bind_param('i', $provinceId);
        $stmt->execute();
        $result = $stmt->get_result();
    } else {
        $result = $conn->query($sql . ' ORDER BY name');
    }
    return $result ? $result->fetch_all(MYSQLI_ASSOC) : [];
}

function fetch_plants($conn, $regionId = null, $provinceId = null, $municipalityId = null, $searchQuery = null)
{
    $sql = "SELECT p.id, p.common_name, p.scientific_name, p.description, p.habitat, p.uses, p.conservation,
        GROUP_CONCAT(DISTINCT m.name SEPARATOR ', ') AS municipalities,
        GROUP_CONCAT(DISTINCT pr.name SEPARATOR ', ') AS provinces,
        GROUP_CONCAT(DISTINCT r.name SEPARATOR ', ') AS regions,
        (SELECT GROUP_CONCAT(filename) FROM plant_photos WHERE plant_photos.plant_id = p.id) AS photos
        FROM plants p
        LEFT JOIN plant_municipalities pm ON pm.plant_id = p.id
        LEFT JOIN municipalities m ON pm.municipality_id = m.id
        LEFT JOIN provinces pr ON m.province_id = pr.id
        LEFT JOIN regions r ON pr.region_id = r.id";

    $where = [];
    $params = [];
    $types = '';

    if ($regionId) {
        $where[] = 'r.id = ?';
        $types .= 'i';
        $params[] = $regionId;
    }
    if ($provinceId) {
        $where[] = 'pr.id = ?';
        $types .= 'i';
        $params[] = $provinceId;
    }
    if ($municipalityId) {
        $where[] = 'm.id = ?';
        $types .= 'i';
        $params[] = $municipalityId;
    }

    $searchQuery = trim((string)$searchQuery);
    if ($searchQuery !== '') {
        $where[] = '(p.common_name LIKE ? OR p.scientific_name LIKE ?)';
        $types .= 'ss';
        $wildcard = '%' . $searchQuery . '%';
        $params[] = $wildcard;
        $params[] = $wildcard;
    }

    if ($where) {
        $sql .= ' WHERE ' . implode(' AND ', $where);
    }

    $sql .= ' GROUP BY p.id ORDER BY p.common_name';

    if ($params) {
        $stmt = $conn->prepare($sql);
        if ($stmt === false) {
            return [];
        }
        $stmt->bind_param($types, ...$params);
        $stmt->execute();
        $result = $stmt->get_result();
    } else {
        $result = $conn->query($sql);
    }

    return $result ? $result->fetch_all(MYSQLI_ASSOC) : [];
}

function admin_is_logged_in()
{
    return !empty($_SESSION['admin_logged_in']) && !empty($_SESSION['admin_username']);
}

function require_admin()
{
    if (!admin_is_logged_in()) {
        header('Location: login.php');
        exit;
    }
}

function authenticate_admin($conn, $username, $password)
{
    $stmt = $conn->prepare('SELECT id, username, password FROM admin_users WHERE username = ? LIMIT 1');
    $stmt->bind_param('s', $username);
    $stmt->execute();
    $result = $stmt->get_result();
    $admin = $result ? $result->fetch_assoc() : null;

    if ($admin && password_verify($password, $admin['password'])) {
        $_SESSION['admin_logged_in'] = true;
        $_SESSION['admin_username'] = $admin['username'];
        $_SESSION['admin_id'] = $admin['id'];
        return true;
    }

    return false;
}

function admin_logout()
{
    $_SESSION = [];
    if (ini_get('session.use_cookies')) {
        $params = session_get_cookie_params();
        setcookie(
            session_name(),
            '',
            time() - 42000,
            $params['path'],
            $params['domain'],
            $params['secure'],
            $params['httponly']
        );
    }
    session_destroy();
}

function fetch_plant($conn, $plantId)
{
    $stmt = $conn->prepare("SELECT id, common_name, scientific_name, description, habitat, uses, conservation FROM plants WHERE id = ?");
    $stmt->bind_param('i', $plantId);
    $stmt->execute();
    $result = $stmt->get_result();
    $plant = $result ? $result->fetch_assoc() : null;
    if (!$plant) return null;

    // fetch municipality ids
    $stmt = $conn->prepare('SELECT municipality_id FROM plant_municipalities WHERE plant_id = ?');
    $stmt->bind_param('i', $plantId);
    $stmt->execute();
    $res = $stmt->get_result();
    $municipalityIds = [];
    while ($row = $res->fetch_assoc()) {
        $municipalityIds[] = (int)$row['municipality_id'];
    }
    $plant['municipality_ids'] = $municipalityIds;

    // fetch photos
    $stmt = $conn->prepare('SELECT id, filename FROM plant_photos WHERE plant_id = ?');
    $stmt->bind_param('i', $plantId);
    $stmt->execute();
    $res = $stmt->get_result();
    $photos = [];
    while ($row = $res->fetch_assoc()) {
        $photos[] = ['id' => (int)$row['id'], 'filename' => $row['filename']];
    }
    $plant['photos'] = $photos;

    return $plant;
}

function delete_plant_photo($conn, $photoId)
{
    $stmt = $conn->prepare('SELECT filename FROM plant_photos WHERE id = ? LIMIT 1');
    $stmt->bind_param('i', $photoId);
    $stmt->execute();
    $result = $stmt->get_result();
    $photo = $result ? $result->fetch_assoc() : null;
    if ($photo) {
        $filepath = __DIR__ . '/assets/uploads/' . $photo['filename'];
        if (file_exists($filepath)) {
            @unlink($filepath);
        }
        $stmt = $conn->prepare('DELETE FROM plant_photos WHERE id = ?');
        $stmt->bind_param('i', $photoId);
        $stmt->execute();
    }
}

function normalize_plant_name($name)
{
    $value = preg_replace('/\s+/', ' ', trim($name));
    if (function_exists('mb_strtolower')) {
        return mb_strtolower($value, 'UTF-8');
    }
    return strtolower($value);
}

function find_similar_plant_by_common_name($conn, $commonName, $excludeId = null)
{
    $normalizedName = normalize_plant_name($commonName);
    if ($normalizedName === '') {
        return null;
    }

    $sql = 'SELECT id, common_name, scientific_name FROM plants';
    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        return null;
    }
    $stmt->execute();
    $result = $stmt->get_result();

    while ($row = $result->fetch_assoc()) {
        if ($excludeId && (int)$row['id'] === (int)$excludeId) {
            continue;
        }
        if (normalize_plant_name($row['common_name']) === $normalizedName) {
            return $row;
        }
    }

    return null;
}

function delete_plant($conn, $plantId)
{
    $stmt = $conn->prepare('SELECT id FROM plant_photos WHERE plant_id = ?');
    $stmt->bind_param('i', $plantId);
    $stmt->execute();
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
        delete_plant_photo($conn, (int)$row['id']);
    }

    $stmt = $conn->prepare('DELETE FROM plant_municipalities WHERE plant_id = ?');
    $stmt->bind_param('i', $plantId);
    $stmt->execute();

    $stmt = $conn->prepare('DELETE FROM plants WHERE id = ?');
    $stmt->bind_param('i', $plantId);
    return $stmt->execute();
}

function save_plant($conn, $plantId, $municipalityIds, $commonName, $scientificName, $description, $habitat, $uses, $conservation)
{
    if ($plantId) {
        $stmt = $conn->prepare("UPDATE plants SET common_name = ?, scientific_name = ?, description = ?, habitat = ?, uses = ?, conservation = ? WHERE id = ?");
        $stmt->bind_param('ssssssi', $commonName, $scientificName, $description, $habitat, $uses, $conservation, $plantId);
        if (!$stmt->execute()) {
            return false;
        }

        // update municipalities mapping
        $stmt = $conn->prepare('DELETE FROM plant_municipalities WHERE plant_id = ?');
        $stmt->bind_param('i', $plantId);
        $stmt->execute();

        if ($municipalityIds && is_array($municipalityIds)) {
            $stmt = $conn->prepare('INSERT INTO plant_municipalities (plant_id, municipality_id) VALUES (?, ?)');
            foreach ($municipalityIds as $mid) {
                $mid = (int)$mid;
                $stmt->bind_param('ii', $plantId, $mid);
                $stmt->execute();
            }
        }

        return $plantId;
    }

    $stmt = $conn->prepare("INSERT INTO plants (common_name, scientific_name, description, habitat, uses, conservation) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param('ssssss', $commonName, $scientificName, $description, $habitat, $uses, $conservation);
    if (!$stmt->execute()) return false;
    $newId = $conn->insert_id;

    if ($municipalityIds && is_array($municipalityIds)) {
        $stmt = $conn->prepare('INSERT INTO plant_municipalities (plant_id, municipality_id) VALUES (?, ?)');
        foreach ($municipalityIds as $mid) {
            $mid = (int)$mid;
            $stmt->bind_param('ii', $newId, $mid);
            $stmt->execute();
        }
    }

    return $newId;
}
