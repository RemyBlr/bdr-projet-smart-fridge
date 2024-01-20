<?php
session_start();
include_once('../auth/db_connection.php');
global $pdo;

if (!isset($_SESSION['authenticated']) || !$_SESSION['authenticated']) {
  header('Location: login.php');
  exit();
}

// ingrient id passed in the url
$ingredientId = isset($_GET['id']) ? $_GET['id'] : null;

$query = "SELECT * FROM Ingredient WHERE id = :ingredientId";
$stmt = $pdo->prepare($query);
$stmt->bindParam(':ingredientId', $ingredientId);
$stmt->execute();
$ingredient = $stmt->fetch(PDO::FETCH_ASSOC);

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ingredient Information</title>
    <link rel="stylesheet" type="text/css" href="../../css/styles.css">
</head>
<body>

<?php include('../includes/header.php'); ?>

<h1>Ingredient Information</h1>
<ul>
    <li>ID: <?php echo $ingredient['id']; ?></li>
    <li>Name: <?php echo $ingredient['nom']; ?></li>
    <li>Description: <?php echo $ingredient['description']; ?></li>
    <li>Unité: <?php echo $ingredient['unite']; ?></li>
    <li>Catégorie: <?php echo $ingredient['categorie']; ?></li>
</ul>

<a href="../ingredients.php">Retour</a>
<a href="./update_ingredient.php?id=<?php echo $ingredient['id']; ?>">Update Ingredient</a>
<a href="./delete_ingredient.php?id=<?php echo $ingredient['id']; ?>">Delete Ingredient</a>

<?php include('../includes/footer.php'); ?>

</body>
</html>
