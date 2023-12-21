<?php
session_start();

include './db_connection.php';
global $pdo;

function authenticateUser($email, $password, $pdo) {
  $querrySelect = "SELECT * FROM utilisateur WHERE email = :email";
  $stmt = $pdo->prepare($querrySelect);
  $stmt->bindParam(':email', $email);
  $stmt->execute();
  $user = $stmt->fetch(PDO::FETCH_ASSOC);

  if ($user && password_verify($password, $user['mot_de_passe'])) {
    $_SESSION['username'] = $user['prenom'];
    $_SESSION['authenticated'] = true;
    $_SESSION['s_email'] = $user['email'];
    return $user;
  } else {
    return false;
  }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $email = $_POST['email'];
  $password = $_POST['password'];

  $user = authenticateUser($email, $password, $pdo);
  if ($user) {
    header("Location: ../homepage.php");
    exit();
  } else {
    $error_message = "Invalid email or password";
  }
}