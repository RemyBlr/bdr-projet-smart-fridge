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

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ingredients</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" crossorigin="anonymous" />
    <style>
        .liked {
            color: green;
        }
    </style>
</head>
<body>
<?php include("./includes/header.php"); ?>

<h1>Ingredients</h1>
<a href="./crud/add_ingredient.php">Add Ingredient</a>

<ul id="ingredientList">
  <?php foreach ($ingredients as $ingredient) : ?>
    <?php
    $likedClass = in_array($ingredient['id'], $likedIngredients) ? 'liked' : '';
    ?>
      <li>
          <i class="heart fas fa-heart <?php echo $likedClass; ?>" data-ingredient-id="<?php echo $ingredient['id']; ?>"></i>
          <a class="<?php echo $likedClass; ?>" href="./crud/ingredient_info.php?id=<?php echo $ingredient['id']; ?>"><?php echo $ingredient['nom']; ?>  <?php echo $ingredient['type']; ?></a>
      </li>
  <?php endforeach; ?>
</ul>

<script>
    // Add click event listener to each heart icon
    document.querySelectorAll('#ingredientList .heart').forEach(heart => {
        heart.addEventListener('click', function (event) {
            event.stopPropagation(); // Prevent the click event on the li element
            const ingredientId = this.getAttribute('data-ingredient-id');
            const linkElement = this.nextElementSibling;
            // Toggle liked status (add or remove liked class)
            this.classList.toggle('liked');
            linkElement.classList.toggle('liked');

            // Send the ingredient ID to the server using AJAX (you can use fetch or another method)
            const xhr = new XMLHttpRequest();
            xhr.open('POST', './crud/toggle_like_ingredient.php', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.send(`ingredientId=${ingredientId}`);
        });
    });

    // Add click event listener to each ingredient item
    document.querySelectorAll('#ingredientList li').forEach(item => {
        item.addEventListener('click', function () {
            const ingredientId = this.querySelector('.heart').getAttribute('data-ingredient-id');
            window.location.href = `ingredient_info.php?id=${ingredientId}`;
        });
    });
</script>

<?php include("./includes/footer.php"); ?>
</body>
</html>
