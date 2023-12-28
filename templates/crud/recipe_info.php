<?php
session_start();
include_once('../auth/db_connection.php');
global $pdo;

$recipeId = isset($_GET['id']) ? $_GET['id'] : null;

$query = "SELECT * FROM Recette WHERE id = :recipeId";
$stmt = $pdo->prepare($query);
$stmt->bindParam(':recipeId', $recipeId);
$stmt->execute();
$recipe = $stmt->fetch(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Recipe Information</title>
  <link rel="stylesheet" type="text/css" href="../../css/styles.css">
</head>
<body>

<?php include('../includes/header.php'); ?>

<h1>Recipe Information</h1>

<ul class="recipe-info">
  <li>Name: <?php echo $recipe['nom']; ?></li>
  <li>Operations: <?php echo $recipe['operations']; ?></li>
  <li>Difficulty: <?php echo $recipe['difficulte']; ?></li>
  <li>Time: <?php echo $recipe['temps']; ?> minutes</li>
  <li>Calories: <?php echo $recipe['calories']; ?></li>
</ul>

<a href="../recipe.php">Retour</a>
<a href="update_recipe.php?id=<?php echo $recipe['id']; ?>">Update Recipe</a>

<?php include('../includes/footer.php'); ?>

</body>
</html>
