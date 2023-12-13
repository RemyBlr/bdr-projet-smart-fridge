<?php
session_start();

// Check if the user is authenticated
if (isset($_SESSION['authenticated']) && $_SESSION['authenticated']) {
  $welcome_message = 'Welcome, ' . $_SESSION['username'] . '!';
} else {
  $welcome_message = 'Please <a href="./auth/login.php">login</a> or <a href="./auth/signup.php">sign up</a> to access more features.';
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
    <body>
    <?php include("./includes/header.php"); ?>
        <h1>Welcome to My Accueil!</h1>
        <p><?php echo $welcome_message; ?></p>
    <?php include("./includes/footer.php"); ?>
    </body>
</html>
