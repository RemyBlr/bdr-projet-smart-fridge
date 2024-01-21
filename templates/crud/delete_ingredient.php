<?php
session_start();
include_once('../auth/db_connection.php');
global $pdo;

$ingredientId = isset($_GET['id']) ? $_GET['id'] : null;

if ($ingredientId) {
  $deleteQuery = "DELETE FROM Ingredient WHERE id = :ingredientId";
  $deleteStmt = $pdo->prepare($deleteQuery);
  $deleteStmt->bindParam(':ingredientId', $ingredientId);
  $deleteStmt->execute();

  header('Location: ../ingredients.php');
  exit();
} else {
  echo "Invalid ingredient ID";
}
?>
