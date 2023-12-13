<?php
$host = 'localhost';
$dbname = 'bdr';
$user = 'bdr';
$password = 'bdr';

try {
  // co à la db
  $pdo = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
  $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  $pdo->exec("SET SEARCH_PATH TO Planificateur_repas");
} catch (PDOException $e) {
  die("Error: " . $e->getMessage());
}
?>
