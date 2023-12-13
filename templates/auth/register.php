<?php
session_start();

include './db_connection.php';
global $pdo;


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $email = $_POST['email'];
  $password = $_POST['password'];
  $hashedPassword = password_hash($password, PASSWORD_DEFAULT); // Hash the password

  $prenom = $_POST['prenom'];
  $nom = $_POST['nom'];
  $genre = $_POST['genre'];
  $dob = $_POST['dob'];
  $poids = $_POST['poids'];
  $taille = $_POST['taille'];

  // Check if the email is already in use
  $querrySelect = "SELECT * FROM utilisateur WHERE email = :email";
  $stmt = $pdo->prepare($querrySelect);
  $stmt->bindParam(':email', $email);
  $stmt->execute();

  if ($stmt->fetch()) {
    $error_message = "Email already in use. Please choose a different email.";
  } else {
    $querryInsert = "INSERT INTO utilisateur (email, prenom, nom, genre, dob, poids, taille, mot_de_passe) 
                              VALUES (:email, :prenom, :nom, :genre, :dob, :poids, :taille, :mdp)";
    $stmt = $pdo->prepare($querryInsert);
    $stmt->bindParam(':email', $email);
    $stmt->bindParam(':prenom', $prenom);
    $stmt->bindParam(':nom', $nom);
    $stmt->bindParam(':genre', $genre);
    $stmt->bindParam(':dob', $dob);
    $stmt->bindParam(':poids', $poids);
    $stmt->bindParam(':taille', $taille);
    $stmt->bindParam(':mdp', $hashedPassword);
    $stmt->execute();

    $_SESSION['authenticated'] = true;
    $_SESSION['username'] = $_POST['prenom'];

    header("Location: ../homepage.php");
    exit();
  }
}