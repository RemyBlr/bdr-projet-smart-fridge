<?php
session_start();
include_once('../auth/db_connection.php');
global $pdo;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $newRecipeName = $_POST['new_recipe_name'];
  $newRecipeOperations = $_POST['new_recipe_operations'];
  $newRecipeDifficulty = $_POST['new_recipe_difficulty'];
  $newRecipeTime = $_POST['new_recipe_time'];
  $newRecipeCalories = $_POST['new_recipe_calories'];

  $insertQuery = "INSERT INTO Recette (nom, operations, difficulte, temps, calories, utilisateur) VALUES (:newRecipeName, :newRecipeOperations, :newRecipeDifficulty, :newRecipeTime, :newRecipeCalories, :utilisateur)";
  $insertStmt = $pdo->prepare($insertQuery);
  $insertStmt->bindParam(':newRecipeName', $newRecipeName);
  $insertStmt->bindParam(':newRecipeOperations', $newRecipeOperations);
  $insertStmt->bindParam(':newRecipeDifficulty', $newRecipeDifficulty);
  $insertStmt->bindParam(':newRecipeTime', $newRecipeTime);
  $insertStmt->bindParam(':newRecipeCalories', $newRecipeCalories);
  $insertStmt->bindParam(':utilisateur', $_SESSION['s_email']); // Assuming you're storing user email in the session
  $insertStmt->execute();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Recipe</title>
  <link rel="stylesheet" type="text/css" href="../../css/styles.css">
</head>
<body>

<?php include('../includes/header.php'); ?>

<h1>Add Recipe</h1>

<form method="post" action="">
  <label for="new_recipe_name">Recipe Name:</label>
  <input type="text" id="new_recipe_name" name="new_recipe_name" required>

  <label for="new_recipe_operations">Operations:</label>
  <textarea id="new_recipe_operations" name="new_recipe_operations" required></textarea>

  <label for="new_recipe_difficulty">Difficulty:</label>
  <input type="number" id="new_recipe_difficulty" name="new_recipe_difficulty" required>

  <label for="new_recipe_time">Time (in minutes):</label>
  <input type="time" id="new_recipe_time" name="new_recipe_time" required>

  <label for="new_recipe_calories">Calories:</label>
  <input type="number" id="new_recipe_calories" name="new_recipe_calories" required>

  <button type="submit">Add Recipe</button>
</form>

<?php include('../includes/footer.php'); ?>

</body>
</html>
