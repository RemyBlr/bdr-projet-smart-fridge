<?php
session_start();
include_once('../auth/db_connection.php');
global $pdo;

$recipeId = isset($_GET['id']) ? $_GET['id'] : null;

if ($recipeId) {
  $deleteQuery = "DELETE FROM Recette WHERE id = :recipeId";
  $deleteStmt = $pdo->prepare($deleteQuery);
  $deleteStmt->bindParam(':recipeId', $recipeId);
  $deleteStmt->execute();

  header('Location: ../recipe.php');
  exit();
} else {
  echo "Invalid recipe ID";
}
?>
