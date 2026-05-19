<?php
// Philippine Plants Encyclopedia database configuration.
// Update these values to match your MySQL server.
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASSWORD', '');
define('DB_NAME', 'philippine_plants_encyclopedia');

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

function fetch_plants($conn, $regionId = null, $provinceId = null, $municipalityId = null)
{
    $sql = "SELECT p.id, p.common_name, p.scientific_name, p.description, p.habitat, p.uses, p.conservation,
        m.name AS municipality, pr.name AS province, r.name AS region
        FROM plants p
        JOIN municipalities m ON p.municipality_id = m.id
        JOIN provinces pr ON m.province_id = pr.id
        JOIN regions r ON pr.region_id = r.id";
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

    if ($where) {
        $sql .= ' WHERE ' . implode(' AND ', $where);
    }
    $sql .= ' ORDER BY p.common_name';

    if ($params) {
        $stmt = $conn->prepare($sql);
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
    $stmt = $conn->prepare("SELECT p.id, p.common_name, p.scientific_name, p.description, p.habitat, p.uses, p.conservation,
        p.municipality_id, m.province_id, pr.region_id
        FROM plants p
        JOIN municipalities m ON p.municipality_id = m.id
        JOIN provinces pr ON m.province_id = pr.id
        WHERE p.id = ?");
    $stmt->bind_param('i', $plantId);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result ? $result->fetch_assoc() : null;
}

function save_plant($conn, $plantId, $municipalityId, $commonName, $scientificName, $description, $habitat, $uses, $conservation)
{
    if ($plantId) {
        $stmt = $conn->prepare("UPDATE plants SET municipality_id = ?, common_name = ?, scientific_name = ?, description = ?, habitat = ?, uses = ?, conservation = ? WHERE id = ?");
        $stmt->bind_param('issssssi', $municipalityId, $commonName, $scientificName, $description, $habitat, $uses, $conservation, $plantId);
        if ($stmt->execute()) {
            return $plantId;
        }
        return false;
    }

    $stmt = $conn->prepare("INSERT INTO plants (municipality_id, common_name, scientific_name, description, habitat, uses, conservation) VALUES (?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param('issssss', $municipalityId, $commonName, $scientificName, $description, $habitat, $uses, $conservation);
    return $stmt->execute() ? $conn->insert_id : false;
}
