<?php
session_start();
include_once('./auth/db_connection.php');
global $pdo;

if (!isset($_SESSION['authenticated']) || !$_SESSION['authenticated']) {
  header('Location: login.php');
  exit();
}

// Query to get all ingredients
$query = "SELECT DISTINCT * FROM Ingredient ORDER BY nom";
$stmt = $pdo->query($query);
$ingredients = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Query to get liked ingredients by the current user
$queryLikedIngredients = "SELECT ingredient FROM Aime_ingredient WHERE utilisateur = :userEmail";
$stmtLikedIngredients = $pdo->prepare($queryLikedIngredients);
$stmtLikedIngredients->bindParam(':userEmail', $_SESSION['s_email']);
$stmtLikedIngredients->execute();
$likedIngredients = $stmtLikedIngredients->fetchAll(PDO::FETCH_COLUMN);

// Close the database connection
$db = null;
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ingredients</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
    <style>
        .liked {
            color: green;
        }
    </style>
</head>
<body>
<?php include("./includes/header.php"); ?>

<h1>Ingredients</h1>

<ul id="ingredientList">
  <?php foreach ($ingredients as $ingredient) : ?>
    <?php
    $likedClass = in_array($ingredient['id'], $likedIngredients) ? 'liked' : '';
    ?>
      <li class="<?php echo $likedClass; ?>" data-ingredient-id="<?php echo $ingredient['id']; ?>">
        <?php echo $ingredient['nom']; ?> </php> <?php echo $ingredient['type']; ?>
      </li>
  <?php endforeach; ?>
</ul>

<script>
    // Add click event listener to each ingredient item
    document.querySelectorAll('#ingredientList li').forEach(item => {
        item.addEventListener('click', function () {
            const ingredientId = this.getAttribute('data-ingredient-id');
            // Toggle liked status (add or remove liked class)
            this.classList.toggle('liked');

            // Send the ingredient ID to the server using AJAX (you can use fetch or another method)
            const xhr = new XMLHttpRequest();
            xhr.open('POST', './crud/toggle_like_ingredient.php', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.send(`ingredientId=${ingredientId}`);
        });
    });
</script>

<?php include("./includes/footer.php"); ?>
</body>
</html>
