<?php
require_once 'config.php';
admin_logout();
header('Location: login.php');
exit;
