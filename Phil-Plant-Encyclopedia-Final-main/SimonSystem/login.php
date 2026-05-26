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

    // Verify reCAPTCHA v2
    $recaptchaResponse = trim($_POST['g-recaptcha-response'] ?? '');
    if ($recaptchaResponse === '') {
        $error = 'Please complete the reCAPTCHA.';
    } else {
        $verifyUrl = 'https://www.google.com/recaptcha/api/siteverify';
        $data = http_build_query([
            'secret' => RECAPTCHA_SECRET_KEY,
            'response' => $recaptchaResponse,
            'remoteip' => $_SERVER['REMOTE_ADDR'] ?? null,
        ]);
        $opts = [
            'http' => [
                'method' => 'POST',
                'header' => "Content-Type: application/x-www-form-urlencoded\r\n",
                'content' => $data,
                'timeout' => 5,
            ],
        ];
        $context = stream_context_create($opts);
        $result = @file_get_contents($verifyUrl, false, $context);
        $json = $result ? json_decode($result, true) : null;
        if (empty($json) || empty($json['success'])) {
            $error = 'reCAPTCHA verification failed. Please try again.';
        }
    }

    if ($error === '') {
        if ($username === '' || $password === '') {
            $error = 'Please enter both username and password.';
        } elseif (authenticate_admin($conn, $username, $password)) {
            header('Location: admin.php');
            exit;
        } else {
            $error = 'Invalid username or password.';
        }
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="assets/css/style.css" />
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>

<body>
    <header class="hero py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="display-5 fw-bold text-white">Admin Login</h1>
                    <p class="lead text-white-75 mb-4">Enter your administrator credentials to manage plant documentation.</p>
                </div>
            </div>
        </div>
    </header>

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card shadow-sm border-0 login-card">
                    <div class="card-body p-4">
                        <?php if ($error): ?>
                            <div class="alert alert-danger"><?= escape($error) ?></div>
                        <?php endif; ?>
                        <form method="post" class="mt-3">
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input id="username" name="username" type="text" class="form-control" value="<?= escape($_POST['username'] ?? '') ?>" required />
                            </div>
                            <div class="mb-4">
                                <label for="password" class="form-label">Password</label>
                                <input id="password" name="password" type="password" class="form-control" required />
                            </div>
                            <div class="mb-3 d-flex justify-content-center">
                                <div class="g-recaptcha" data-sitekey="<?= escape(RECAPTCHA_SITE_KEY) ?>"></div>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 btn-lg">Log in</button>
                        </form>
                        <div class="mt-4 text-center">
                            <a href="index.php" class="link-secondary">Back to encyclopedia</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>