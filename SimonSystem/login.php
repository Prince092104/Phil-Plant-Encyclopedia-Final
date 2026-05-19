<?php
require_once 'config.php';
$conn = connect_db();

$error = '';
if (admin_is_logged_in()) {
    header('Location: admin.php');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = trim($_POST['password'] ?? '');

    if ($username === '' || $password === '') {
        $error = 'Please enter both username and password.';
    } elseif (authenticate_admin($conn, $username, $password)) {
        header('Location: admin.php');
        exit;
    } else {
        $error = 'Invalid username or password.';
    }
}

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
    <title>Admin Login - Philippine Plants Encyclopedia</title>
    <link rel="stylesheet" href="assets/css/style.css" />
</head>

<body>
    <header class="hero">
        <div class="container">
            <h1>Admin Login</h1>
            <p>Enter your administrator credentials to manage plant documentation.</p>
            <a class="hero-link" href="index.php">View public encyclopedia</a>
        </div>
    </header>

    <main class="container">
        <section class="controls admin-controls">
            <?php if ($error): ?>
                <div class="status error"><?= escape($error) ?></div>
            <?php endif; ?>
            <form method="post" class="admin-form">
                <div class="field-group">
                    <label for="username">Username</label>
                    <input id="username" name="username" type="text" value="<?= escape($_POST['username'] ?? '') ?>" required />
                </div>
                <div class="field-group">
                    <label for="password">Password</label>
                    <input id="password" name="password" type="password" required />
                </div>
                <div class="actions admin-actions">
                    <button type="submit">Log in</button>
                </div>
            </form>
        </section>
    </main>
</body>

</html>