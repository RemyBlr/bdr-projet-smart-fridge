<?php
session_start();
include_once ('./auth/db_connection.php');
global $pdo;

// Check if the user is not authenticated
if (!isset($_SESSION['authenticated']) || !$_SESSION['authenticated']) {
  header('Location: login.php');
  exit();
}

// Query to get user profile information using the view
$querySelect = "SELECT * FROM vue_profile_utilisateur WHERE user_email = :email";
$stmt_select = $pdo->prepare($querySelect);
$stmt_select->bindParam(':email', $_SESSION['s_email']);
$stmt_select->execute();
$userProfile = $stmt_select->fetch(PDO::FETCH_ASSOC);

$queryRccipe = "SELECT * FROM vue_recette_aimee_par_utilisateur WHERE user_email = :email";
$stmt_recipe = $pdo->prepare($queryRccipe);
$stmt_recipe->bindParam(':email', $_SESSION['s_email']);
$stmt_recipe->execute();
$recipe = $stmt_recipe->fetchAll(PDO::FETCH_ASSOC);

$queryIngredient = "SELECT * FROM vue_ingredient_aime_par_utilisateur WHERE user_email = :email";
$stmt_ingredient = $pdo->prepare($queryIngredient);
$stmt_ingredient->bindParam(':email', $_SESSION['s_email']);
$stmt_ingredient->execute();
$ingredient = $stmt_ingredient->fetchAll(PDO::FETCH_ASSOC);

$queryMenage = "SELECT * FROM vue_menage WHERE user_email = :email";
$stmt_menage = $pdo->prepare($queryMenage);
$stmt_menage->bindParam(':email', $_SESSION['s_email']);
$stmt_menage->execute();
$menage = $stmt_menage->fetchAll(PDO::FETCH_ASSOC);
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
<h1>My profile!</h1>
<ul class="perso-info">
    <li>Prénom: <?php echo $userProfile['prenom']; ?></li>
    <li>Nom: <?php echo $userProfile['nom']; ?></li>
    <li>Email: <?php echo $userProfile['user_email']; ?></li>
    <li>Genre: <?php echo $userProfile['genre']; ?></li>
    <li>Date de naissance: <?php echo $userProfile['dob']; ?></li>
    <li>Poids: <?php echo $userProfile['poids']; ?></li>
    <li>Taille: <?php echo $userProfile['taille']; ?></li>
    <li>Droits: <?php echo $userProfile['admin']; ?></li>
</ul>
<button type="button" onclick="window.location.href='./crud/update_profile.php'">Modifier mes informations</button>
<br>
<ul class="liked-recipe">
  Recettes aimées:
    <?php foreach ($recipe as $rec) {?>
  <li><?php echo $rec['recipe_nom']; ?></li>
  <?php } ?>
</ul>
<button type="button">Modifier mes recettes aimées</button>
<br>
<ul class="liked-ingredient">
    Ingrédients aimés:
    <?php foreach ($ingredient as $ing) {?>
        <li><?php echo $ing['ingredient_nom'];?> <?php  echo $ing['type']; ?></li>
    <?php } ?>
</ul>
<button type="button">Modifier mes ingrédients aimés</button>
<?php include("./includes/footer.php"); ?>
</body>
</html>
