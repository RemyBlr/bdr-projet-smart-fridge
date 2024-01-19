<?php
session_start();
include_once('../auth/db_connection.php');
global $pdo;

if (!isset($_SESSION['authenticated']) || !$_SESSION['authenticated']) {
  header('Location: login.php');
  exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  if (isset($_POST['submit'])) {
    //get ingredients and quantities
    $selectedIngredients = isset($_POST['ingredient']) ? $_POST['ingredient'] : [];
    $quantities = isset($_POST['quantity']) ? $_POST['quantity'] : [];

    // validate and add ingredients to userstock
    foreach ($selectedIngredients as $index => $ingredientId) {
      $quantity = $quantities[$index];

      // validate quantity
      if ($quantity > 0) {
        // check if ingredient already exists in user stock
        $checkQuery = "SELECT * FROM Stock
                               WHERE planificateur IN (
                                   SELECT P.id FROM Planificateur AS P
                                   INNER JOIN Utilisateur_menage AS UM ON P.id = UM.menage
                                   WHERE UM.utilisateur = :userEmail
                               ) AND ingredient = :ingredientId";
        $checkStmt = $pdo->prepare($checkQuery);
        $checkStmt->bindParam(':userEmail', $_SESSION['s_email']);
        $checkStmt->bindParam(':ingredientId', $ingredientId, PDO::PARAM_INT);
        $checkStmt->execute();

        if ($checkStmt->rowCount() > 0) {
          // if ingredient exists, update stock with the sum
          $updateQuery = "UPDATE Stock
                                    SET nombreStock = nombreStock + :quantity
                                    WHERE planificateur IN (
                                        SELECT P.id FROM Planificateur AS P
                                        INNER JOIN Utilisateur_menage AS UM ON P.id = UM.menage
                                        WHERE UM.utilisateur = :userEmail
                                    ) AND ingredient = :ingredientId";
          $updateStmt = $pdo->prepare($updateQuery);
          $updateStmt->bindParam(':quantity', $quantity, PDO::PARAM_STR);
          $updateStmt->bindParam(':userEmail', $_SESSION['s_email']);
          $updateStmt->bindParam(':ingredientId', $ingredientId, PDO::PARAM_INT);
          $updateStmt->execute();
        } else {
          // if ingredient doesn't exist, insert new record
          $insertQuery = "INSERT INTO Stock (nombreStock, planificateur, ingredient)
                                    VALUES (:quantity, (SELECT P.id FROM Planificateur AS P
                                        INNER JOIN Utilisateur_menage AS UM ON P.id = UM.menage
                                        WHERE UM.utilisateur = :userEmail), :ingredientId)";
          $insertStmt = $pdo->prepare($insertQuery);
          $insertStmt->bindParam(':quantity', $quantity, PDO::PARAM_STR);
          $insertStmt->bindParam(':userEmail', $_SESSION['s_email']);
          $insertStmt->bindParam(':ingredientId', $ingredientId, PDO::PARAM_INT);
          $insertStmt->execute();
        }
      }
    }

    header('Location: ../fridge.php');
    exit();
  }
}

$query = "SELECT id, nom, type FROM Ingredient ORDER BY nom";
$stmt = $pdo->query($query);
$ingredients = $stmt->fetchAll(PDO::FETCH_ASSOC);

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Ingredient</title>
    <link rel="stylesheet" type="text/css" href="../../css/styles.css">
</head>
<body>
<?php include("../includes/header.php"); ?>

<h1>Add ingredients to Fridge</h1>

<form method="post" action="add_existing_ingredient.php">
  <label for="ingredient">Ingredient:</label>
  <select name="ingredient[]" id="ingredient" multiple>
    <?php foreach ($ingredients as $ingredient) : ?>
      <option value="<?php echo $ingredient['id']; ?>"><?php echo $ingredient['nom']; ?> <?php echo $ingredient['type']; ?></option>
    <?php endforeach; ?>
  </select>

  <label for="quantity">Quantity:</label>
  <input type="text" name="quantity[]" id="quantity" placeholder="Enter quantity">

  <input type="submit" name="submit" value="Add to Fridge">
</form>

<?php include("../includes/footer.php"); ?>
</body>
</html>
