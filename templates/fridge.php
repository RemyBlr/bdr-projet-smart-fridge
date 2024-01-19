<?php
session_start();
include_once('./auth/db_connection.php');
global $pdo;

// Check if the user is not authenticated
if (!isset($_SESSION['authenticated']) || !$_SESSION['authenticated']) {
  header('Location: login.php');
  exit();
}

$query = "SELECT DISTINCT I.id, I.nom, I.type, S.nombrestock, I.unite FROM Ingredient AS I
          INNER JOIN Stock AS S ON I.id = S.ingredient
          INNER JOIN Planificateur AS P ON S.planificateur = P.id
          INNER JOIN Utilisateur_menage AS UM ON P.id = UM.menage
          WHERE UM.utilisateur = :userEmail
          ORDER BY I.nom";
$stmt = $pdo->prepare($query);
$stmt->bindParam(':userEmail', $_SESSION['s_email']);
$stmt->execute();
$ingredients = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
<?php include("./includes/header.php"); ?>
<h1>Fridge</h1>

<a href="./crud/add_existing_ingredient.php">Add to fridge</a>

<ul id="ingredientList">
  <?php foreach ($ingredients as $ingredient) : ?>
    <?php if($ingredient['nombrestock'] != 0): ?>
      <li>
        <a  href="./crud/ingredient_info.php?id=<?php echo $ingredient['id']; ?>">
            <?php echo $ingredient['nom']; ?>  <?php echo $ingredient['type']; ?> :
            <?php echo $ingredient['nombrestock']; ?> <?php echo $ingredient['unite']; ?> in stock
        </a>
      <button class="remove-btn" data-ingredient-id="<?php echo $ingredient['id']; ?>">Remove</button>
      </li>
    <?php endif; ?>
    <?php endforeach; ?>
</ul>
<?php include("./includes/footer.php"); ?></body>
</html>

<script>
    document.querySelectorAll('#ingredientList .remove-btn').forEach(removeBtn => {
        removeBtn.addEventListener('click', function (event) {
            event.stopPropagation();
            const ingredientId = this.getAttribute('data-ingredient-id');

            const xhr = new XMLHttpRequest();
            xhr.open('POST', './crud/delete_ingredient_from_fridge.php', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.send(`ingredientId=${ingredientId}`);

            const listItem = this.parentNode;
            listItem.parentNode.removeChild(listItem);
        });
    });
</script>

