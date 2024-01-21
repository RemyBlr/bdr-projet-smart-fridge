<?php
session_start();
include_once('./auth/db_connection.php');
global $pdo;

// Check if the user is not authenticated
if (!isset($_SESSION['authenticated']) || !$_SESSION['authenticated']) {
  header('Location: login.php');
  exit();
}

// Query to get all recipes
$query = "SELECT * FROM Recette ORDER BY nom";
$stmt = $pdo->query($query);
$recipes = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Query to get liked recipes by the current user
$queryLikedRecipes = "SELECT recette FROM Aime_recette WHERE utilisateur = :userEmail";
$stmtLikedRecipes = $pdo->prepare($queryLikedRecipes);
$stmtLikedRecipes->bindParam(':userEmail', $_SESSION['s_email']);
$stmtLikedRecipes->execute();
$likedRecipes = $stmtLikedRecipes->fetchAll(PDO::FETCH_COLUMN);

// Close the database connection
$db = null;
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recipes</title>
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

<h1>Recipes</h1>
<a href="./crud/add_recipe.php">Add Recipe</a>

<ul id="recipeList">
  <?php foreach ($recipes as $recipe) : ?>
    <?php
    $likedClass = in_array($recipe['id'], $likedRecipes) ? 'liked' : '';
    ?>
      <li>
          <i class="heart fas fa-heart <?php echo $likedClass; ?>" data-recipe-id="<?php echo $recipe['id']; ?>"></i>
          <a href="./crud/recipe_info.php?id=<?php echo $recipe['id']; ?>" class="<?php echo $likedClass; ?>"><?php echo $recipe['nom']; ?></a>
      </li>
  <?php endforeach; ?>
</ul>

<script>
    // Add click event listener to each heart icon
    document.querySelectorAll('#recipeList .heart').forEach(heart => {
        heart.addEventListener('click', function (event) {
            event.stopPropagation(); // Prevent the click event on the li element
            const recipeId = this.getAttribute('data-recipe-id');
            // Toggle liked status (add or remove liked class)
            const linkElement = this.nextElementSibling;
            this.classList.toggle('liked');
            linkElement.classList.toggle('liked');

            // Send the recipe ID to the server using AJAX (you can use fetch or another method)
            const xhr = new XMLHttpRequest();
            xhr.open('POST', './crud/toggle_like_recipe.php', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.send(`recipeId=${recipeId}`);
        });
    });

    // Add click event listener to each recipe item
    document.querySelectorAll('#recipeList li').forEach(item => {
        item.addEventListener('click', function () {
            const recipeId = this.querySelector('.heart').getAttribute('data-recipe-id');
            window.location.href = `recipe_info.php?id=${recipeId}`;
        });
    });
</script>

<?php include("./includes/footer.php"); ?>
</body>
</html>
