<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
<h1>Login</h1>
<?php if (isset($error_message)) { echo "<p>$error_message</p>"; } ?>
<form action="authenticate.php" method="post">
  <label for="email">Email:</label>
  <input type="text" id="email" name="email" required>
  <br>
  <label for="password">Password:</label>
  <input type="password" id="password" name="password" required>
  <br>
  <button type="submit">Login</button>
</form>
</body>
</html>
