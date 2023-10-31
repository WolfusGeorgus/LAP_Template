<?php

class Conn
{
    var $conn;
    public function __construct()
    {
        try {
            $servername = "localhost:3306";
            $username = "root";
            $password = "admin";
            $schema = "test";

            $this->conn = new PDO('mysql:host=' . $servername . ';dbname=' . $schema . ';charset=utf8', $username, $password);
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (Exception $e) {
            echo 'Fehler - ' . $e->getCode() . ': ' . $e->getMessage() . '<br>';
        }
    }

    public function makeStatement($query, $arrayValues = null)
    {
        try {
            $stmt = $this->conn->prepare($query);
            $stmt->execute($arrayValues);
            return $stmt;
        } catch (Exception $e) {
            echo 'Fehler - ' . $e->getCode() . ': ' . $e->getMessage() . '<br>';
        }
    }
}

function makeTable($query, $arrayValues = null)
{
  $conn = new Conn();
  $stmt = $conn->makeStatement($query, $arrayValues);

  echo '<table class="table">
        <tr class="tr">';
  for($i = 0; $i < $stmt->columnCount(); $i++)
  {
    $meta = $stmt->getColumnMeta($i);
    echo '<th class="th">'.$meta['name'].'</th>';
  }
  echo '</tr>';
  while($row = $stmt->fetch(PDO::FETCH_NUM)) {
    echo '<tr class "tr">';
    foreach($row as $r) {
      echo '<td class="td">'.$r.'</td>';
    }
    echo '</tr>';
  }
  echo '</table>';
}