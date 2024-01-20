<?php
session_start();
include_once('../auth/db_connection.php');
global $pdo;

$selectQuery = "SELECT * FROM Ingredient ORDER BY nom ASC";
$selectStmt = $pdo->prepare($selectQuery);
$selectStmt->execute();
$ingredients = $selectStmt->fetchAll(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $newName = $_POST['new_name'];
  $newDescription = $_POST['new_description'];
    $type = $_POST['new_type'];
    $category = $_POST['new_category'];

  $insertQuery = "INSERT INTO Ingredient (nom, description, type, categorie, utilisateur) VALUES (:newName, :newDescription, :type, :categorie, :utilisateur)";
  $insertStmt = $pdo->prepare($insertQuery);
  $insertStmt->bindParam(':newName', $newName);
  $insertStmt->bindParam(':newDescription', $newDescription);
  $insertStmt->bindParam(':type', $type);
  $insertStmt->bindParam(':categorie', $category);
  $insertStmt->bindParam(':utilisateur', $_SESSION['s_email']);
  $insertStmt->execute();

  header('Location: ../ingredients.php');
  exit();
}
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

<?php include('../includes/header.php'); ?>

<h1>Add Ingredient</h1>

<form method="post" action="">
  <label for="new_name">Name:</label>
  <input type="text" id="new_name" name="new_name" required>

  <label for="new_description">Description:</label>
  <textarea id="new_description" name="new_description" required></textarea>

    <label for="new_type">Type:</label>
    <textarea id="new_type" name="new_type" required></textarea>

    <label for="new_category">Catégorie:</label>
    <select id="new_category" name="new_category" required>
    <?php foreach ($ingredients as $ingredient) : ?>
        <option value="<?php echo $ingredient['categorie']; ?>"><?php echo $ingredient['categorie']; ?></option>
    <?php endforeach; ?>
    </select>

  <button type="submit">Add Ingredient</button>
</form>

<?php include('../includes/footer.php'); ?>

</body>
</html>
