<?php
session_start();
include_once('../auth/db_connection.php');
global $pdo;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  // get ingredient id from POST
  $ingredientId = isset($_POST['ingredientId']) ? intval($_POST['ingredientId']) : 0;

  // check if authenticated
  if (isset($_SESSION['authenticated']) && $_SESSION['authenticated']) {
    // check if ingredient exists in user stock
    $query = "SELECT * FROM Stock
                  WHERE ingredient = :ingredientId
                  AND planificateur IN (
                      SELECT P.id FROM Planificateur AS P
                      INNER JOIN Utilisateur_menage AS UM ON P.id = UM.menage
                      WHERE UM.utilisateur = :userEmail
                  )";
    $stmt = $pdo->prepare($query);
    $stmt->bindParam(':ingredientId', $ingredientId, PDO::PARAM_INT);
    $stmt->bindParam(':userEmail', $_SESSION['s_email']);
    $stmt->execute();
    $stockData = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($stockData) {
      // remove ingredient from stock
      $deleteQuery = "DELETE FROM Stock WHERE ingredient = :ingredientId";
      $deleteStmt = $pdo->prepare($deleteQuery);
      $deleteStmt->bindParam(':ingredientId', $ingredientId, PDO::PARAM_INT);
      $deleteStmt->execute();

      echo json_encode(['status' => 'success', 'message' => 'Ingredient removed successfully']);
      exit();
    } else {
      echo json_encode(['status' => 'error', 'message' => 'Ingredient not found in the stock']);
      exit();
    }
  }
}

echo json_encode(['status' => 'error', 'message' => 'Invalid request']);
exit();
?>
