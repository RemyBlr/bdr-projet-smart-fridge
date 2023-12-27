<?php
session_start();
include_once('../auth/db_connection.php');
global $pdo;

// Check if the user is not authenticated
if (!isset($_SESSION['authenticated']) || !$_SESSION['authenticated']) {
  header('Location: login.php');
  exit();
}

// Fetch the user's current profile information
$querySelect = "SELECT * FROM vue_profile_utilisateur WHERE user_email = :email";
$stmt_select = $pdo->prepare($querySelect);
$stmt_select->bindParam(':email', $_SESSION['s_email']);
$stmt_select->execute();
$userProfile = $stmt_select->fetch(PDO::FETCH_ASSOC);

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $newHeight = $_POST['new_height'];
  $newWeight = $_POST['new_weight'];

  // Validate input (you may add more validation based on your requirements)
  if (!is_numeric($newHeight) || !is_numeric($newWeight)) {
    $error = "Invalid input. Please enter numeric values for height and weight.";
  } else {
    // Update the user's profile in the database
    $queryUpdate = "UPDATE Utilisateur SET taille = :newHeight, poids = :newWeight WHERE email = :email";
    $stmt_update = $pdo->prepare($queryUpdate);
    $stmt_update->bindParam(':newHeight', $newHeight, PDO::PARAM_INT);
    $stmt_update->bindParam(':newWeight', $newWeight, PDO::PARAM_INT);
    $stmt_update->bindParam(':email', $_SESSION['s_email']);
    $stmt_update->execute();

    // Redirect to the profile page after updating
    header('Location: ../profile.php');
    exit();
  }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile</title>
    <link rel="stylesheet" type="text/css" href="../../css/styles.css">
</head>
<body>
<?php include("../includes/header.php"); ?>

<h1>Update Profile</h1>

<?php
if (isset($error)) {
  echo "<p class='error'>$error</p>";
}
?>

<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="POST">
    <label for="new_height">New Height:</label>
    <input type="number" id="new_height" name="new_height" step="0.01" value="<?php echo $userProfile['taille']; ?>" required>

    <label for="new_weight">New Weight:</label>
    <input type="number" id="new_weight" name="new_weight" step="0.01" value="<?php echo $userProfile['poids']; ?>" required>

    <button type="submit">Update Profile</button>
</form>

<br>
<a href="../profile.php">Back to Profile</a>

<?php include("../includes/footer.php"); ?>
</body>
</html>
