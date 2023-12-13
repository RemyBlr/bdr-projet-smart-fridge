<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign Up</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
<h1>Sign Up</h1>
    <?php if (isset($error_message)) { echo "<p>$error_message</p>"; } ?>
    <form action="register.php" method="post">
        <label for="email">Email:</label>
        <input type="email" name="email" required><br>
        <label for="password">Password:</label>
        <input type="password" name="password" required><br>
        <!-- Add additional fields for user information -->
        <label for="prenom">First Name:</label>
        <input type="text" name="prenom" required><br>
        <label for="nom">Last Name:</label>
        <input type="text" name="nom" required><br>
        <label for="genre">Gender:</label>
        <input type="text" name="genre" required><br>
        <label for="dob">Date of Birth:</label>
        <input type="date" name="dob" required><br>
        <label for="poids">Weight:</label>
        <input type="number" name="poids" required><br>
        <label for="taille">Height:</label>
        <input type="number" name="taille" required><br>
        <input type="submit" value="Signup">
    </form>
</body>
</html>
