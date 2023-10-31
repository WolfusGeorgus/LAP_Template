<?php

$server = 'localhost:3306';
$user = 'root';
$pw = 'admin';
$schema = 'SCHOOL';

try 
{
  $conn = new PDO('mysql:host=' . $server . ';dbname=' . $schema . ';charset=utf8', $user, $pw);
  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} 
catch(Exception $e) 
{
  echo 'Fehler - ' . $e->getCode(). ': ' . $e->getMessage() . '<br>';
}
