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

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $updatedRecipeName = $_POST['updated_recipe_name'];
  $updatedRecipeOperations = $_POST['updated_recipe_operations'];
  $updatedRecipeDifficulty = $_POST['updated_recipe_difficulty'];
  $updatedRecipeTime = $_POST['updated_recipe_time'];
  $updatedRecipeCalories = $_POST['updated_recipe_calories'];

  $updateQuery = "UPDATE Recette SET nom = :updatedRecipeName, operations = :updatedRecipeOperations, difficulte = :updatedRecipeDifficulty, temps = :updatedRecipeTime, calories = :updatedRecipeCalories WHERE id = :recipeId";
  $updateStmt = $pdo->prepare($updateQuery);
  $updateStmt->bindParam(':updatedRecipeName', $updatedRecipeName);
  $updateStmt->bindParam(':updatedRecipeOperations', $updatedRecipeOperations);
  $updateStmt->bindParam(':updatedRecipeDifficulty', $updatedRecipeDifficulty);
  $updateStmt->bindParam(':updatedRecipeTime', $updatedRecipeTime);
  $updateStmt->bindParam(':updatedRecipeCalories', $updatedRecipeCalories);
  $updateStmt->bindParam(':recipeId', $recipeId);
  $updateStmt->execute();

  header('Location: recipe_info.php?id=' . $recipeId);
  exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Update Recipe</title>
  <link rel="stylesheet" type="text/css" href="../../css/styles.css">
</head>
<body>
<?php include('../includes/header.php'); ?>

<h1>Update Recipe</h1>

<form method="post" action="">
  <label for="updated_recipe_name">Recipe Name:</label>
  <input type="text" id="updated_recipe_name" name="updated_recipe_name" value="<?php echo $recipe['nom']; ?>" required>

  <label for="updated_recipe_operations">Operations:</label>
  <textarea id="updated_recipe_operations" name="updated_recipe_operations" required><?php echo $recipe['operations']; ?></textarea>

  <label for="updated_recipe_difficulty">Difficulty:</label>
  <input type="number" id="updated_recipe_difficulty" name="updated_recipe_difficulty" value="<?php echo $recipe['difficulte']; ?>" required>

  <label for="updated_recipe_time">Time (in minutes):</label>
  <input type="time" id="updated_recipe_time" name="updated_recipe_time" value="<?php echo $recipe['temps']; ?>" required>

  <label for="updated_recipe_calories">Calories:</label>
  <input type="number" id="updated_recipe_calories" name="updated_recipe_calories" value="<?php echo $recipe['calories']; ?>" required>

  <button type="submit">Update Recipe</button>
</form>

<?php include('../includes/footer.php'); ?>

</body>
</html>
