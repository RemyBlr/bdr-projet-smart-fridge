<?php
session_start();
include_once('../auth/db_connection.php');
global $pdo;

// Check if the user is authenticated
if (isset($_SESSION['authenticated']) && $_SESSION['authenticated']) {
  if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['ingredientId'])) {
    $ingredientId = $_POST['ingredientId'];
    $userEmail = $_SESSION['s_email'];

    // Check if the user already likes the ingredient
    $queryCheckLike = "SELECT * FROM Aime_ingredient WHERE utilisateur = :userEmail AND ingredient = :ingredientId";
    $stmtCheckLike = $pdo->prepare($queryCheckLike);
    $stmtCheckLike->bindParam(':userEmail', $userEmail);
    $stmtCheckLike->bindParam(':ingredientId', $ingredientId);
    $stmtCheckLike->execute();

    if ($stmtCheckLike->rowCount() > 0) {
      // User already likes the ingredient, remove like
      $queryRemoveLike = "DELETE FROM Aime_ingredient WHERE utilisateur = :userEmail AND ingredient = :ingredientId";
      $stmtRemoveLike = $pdo->prepare($queryRemoveLike);
      $stmtRemoveLike->bindParam(':userEmail', $userEmail);
      $stmtRemoveLike->bindParam(':ingredientId', $ingredientId);
      $stmtRemoveLike->execute();
    } else {
      // User does not like the ingredient, add like
      $queryAddLike = "INSERT INTO Aime_ingredient (utilisateur, ingredient) VALUES (:userEmail, :ingredientId)";
      $stmtAddLike = $pdo->prepare($queryAddLike);
      $stmtAddLike->bindParam(':userEmail', $userEmail);
      $stmtAddLike->bindParam(':ingredientId', $ingredientId);
      $stmtAddLike->execute();
    }
  }
}

// Close the database connection
$db = null;
?>
