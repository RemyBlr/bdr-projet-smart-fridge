<?php
session_start();
include_once('../auth/db_connection.php');
global $pdo;

if (!isset($_SESSION['authenticated']) || !$_SESSION['authenticated']) {
  header('Location: login.php');
  exit();
}

$ingredientId = isset($_GET['id']) ? $_GET['id'] : null;

$query = "SELECT * FROM Ingredient WHERE id = :ingredientId";
$stmt = $pdo->prepare($query);
$stmt->bindParam(':ingredientId', $ingredientId);
$stmt->execute();
$ingredient = $stmt->fetch(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $updatedName = $_POST['updated_name'];
  $updatedDescription = $_POST['updated_description'];

  $updateQuery = "UPDATE Ingredient SET nom = :updatedName, description = :updatedDescription WHERE id = :ingredientId";
  $updateStmt = $pdo->prepare($updateQuery);
  $updateStmt->bindParam(':updatedName', $updatedName);
  $updateStmt->bindParam(':updatedDescription', $updatedDescription);
  $updateStmt->bindParam(':ingredientId', $ingredientId);
  $updateStmt->execute();

  header('Location: ingredient_info.php?id=' . $ingredientId);
  exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Update Ingredient</title>
  <link rel="stylesheet" type="text/css" href="../../css/styles.css">
</head>
<body>
<?php include('../includes/header.php'); ?>

<h1>Update Ingredient</h1>

<form method="post" action="">
  <label for="updated_name">Name:</label>
  <input type="text" id="updated_name" name="updated_name" value="<?php echo $ingredient['nom']; ?>" required>

  <label for="updated_description">Description:</label>
  <textarea id="updated_description" name="updated_description" required><?php echo $ingredient['description']; ?></textarea>

  <button type="submit">Update Ingredient</button>
</form>

<?php include('../includes/footer.php'); ?>

</body>
</html>
