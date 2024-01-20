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

$queryIngredients = "SELECT IP.*, I.nom AS ingredient_nom, I.unite, I.type
                    FROM Ingredient_principal AS IP
                    INNER JOIN Ingredient AS I ON IP.ingredient = I.id
                    WHERE IP.recette = :recipeId
                    UNION
                    SELECT ISU.*, I.nom AS ingredient_nom, I.unite, I.type
                    FROM Ingredient_substitue AS ISU
                    INNER JOIN Ingredient AS I ON ISU.ingredient_substitue = I.id
                    WHERE ISU.recette = :recipeId
                    ORDER BY ingredient_nom";
$stmtIngredients = $pdo->prepare($queryIngredients);
$stmtIngredients->bindParam(':recipeId', $recipeId);
$stmtIngredients->execute();
$ingredients = $stmtIngredients->fetchAll(PDO::FETCH_ASSOC);
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

<h2>Ingredients</h2>

<ul class="ingredient-list">
  <?php foreach ($ingredients as $ingredient) : ?>
  <?php if ($ingredient['ingredient_nom'] != 0) : ?>
      <li><?php echo $ingredient['ingredient_nom']; ?> <?php echo $ingredient['type'];?> - <?php echo $ingredient['nombreingredient']; ?> <?php echo $ingredient['unite'];?></li>
    <?php endif; ?>
  <?php endforeach; ?>
</ul>

<a href="../recipe.php">Retour</a>
<a href="update_recipe.php?id=<?php echo $recipe['id']; ?>">Update Recipe</a>

<?php include('../includes/footer.php'); ?>

</body>
</html>
