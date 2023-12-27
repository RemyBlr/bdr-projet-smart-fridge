<?php
session_start();
include_once('../auth/db_connection.php');
global $pdo;

if (isset($_SESSION['authenticated']) && $_SESSION['authenticated']) {
  if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['recipeId'])) {
    $recipeId = $_POST['recipeId'];
    $userEmail = $_SESSION['s_email'];

    // Check if the user already likes the recipe
    $queryCheckLike = "SELECT * FROM Aime_recette WHERE utilisateur = :userEmail AND recette = :recipeId";
    $stmtCheckLike = $pdo->prepare($queryCheckLike);
    $stmtCheckLike->bindParam(':userEmail', $userEmail);
    $stmtCheckLike->bindParam(':recipeId', $recipeId);
    $stmtCheckLike->execute();

    if ($stmtCheckLike->rowCount() > 0) {
      // User already likes the recipe, remove like
      $queryRemoveLike = "DELETE FROM Aime_recette WHERE utilisateur = :userEmail AND recette = :recipeId";
      $stmtRemoveLike = $pdo->prepare($queryRemoveLike);
      $stmtRemoveLike->bindParam(':userEmail', $userEmail);
      $stmtRemoveLike->bindParam(':recipeId', $recipeId);
      $stmtRemoveLike->execute();
    } else {
      // User does not like the recipe, add like
      $queryAddLike = "INSERT INTO Aime_recette (utilisateur, recette) VALUES (:userEmail, :recipeId)";
      $stmtAddLike = $pdo->prepare($queryAddLike);
      $stmtAddLike->bindParam(':userEmail', $userEmail);
      $stmtAddLike->bindParam(':recipeId', $recipeId);
      $stmtAddLike->execute();
    }
  }
}

$db = null;
?>
