

<header>
    <div class="topnav">
      <?php if (isset($_SESSION['authenticated']) && $_SESSION['authenticated']) { ?>
        <a href="./homepage.php">Accueil</a>
        <a href="./ingredients.php">Ingrédients</a>
      <a href="./recipe.php">Recettes</a>
      <a href="./fridge.php">Frigo</a>
      <div class="topnav-right">
          <a href="./profile.php">Hi, <?php echo($_SESSION['username'])?></a>
          <a href="./auth/logout.php">Logout</a>
      <?php } else { ?>
          <div class="topnav-right">
          <a href="./auth/login.php">Login</a>
      <?php } ?>
      </div>
    </div>
</header>