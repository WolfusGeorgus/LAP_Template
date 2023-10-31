<?php
include "../functions/conn.php";

$conn = new Conn();

if (array_key_exists('action', $_POST)) {
  if ($_POST['action'] == 'add_person') {
    $query= "insert into person (per_fname, per_lname) values (?,?)";
    $conn->makeStatement($query, array($_POST['input_fname'], $_POST['input_lname']));
  }
  else if ($_POST['action'] == 'add_company') {
    $query= "insert into company (com_name) values (?)";
    $conn->makeStatement($query, array($_POST['input_name']));
  }
  else if ($_POST['action'] == 'assign_person') {
    $query= "update person set com_id = ? where per_id = ?";
    $conn->makeStatement($query, array($_POST['select_company'], $_POST['select_person']));
  }
}

header("Location: ../index.php?page=page1");