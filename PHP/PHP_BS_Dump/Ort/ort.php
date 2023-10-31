<!DOCTYPE html>
<html>
<head>
    <title>Ort hinzufügen</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
        <a class="navbar-brand" href="index.php">Startseite</a>
        </li>
        <li>
        <a class="navbar-brand" href="ort.php">Ort hinzufügen</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

    <div class="container mt-5">
        <h2>Ort hinzufügen</h2>
        <form method="post" action="ort.php">
            <div class="mb-3">
                <label for="ortid">Ortsname</label>
                <input id ="ortid" type="text" class="form-control" name="ort" required placeholder="z.B. Graz">
            </div>
            <div class="mb-3">
                <label for="plzid">Postleitzahl</label>
                <select id="plzid" name="plz" class="form-select">
                    <?php
                        $db = new Conn();
                        $sql = "SELECT * from plz order by plz_nr asc";
                        $stmt = $db->makeStatement($sql);
                        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

                        foreach ($result as $row) {
                        echo '<option value="'. $row["plz_id"] .'">'. $row["plz_nr"] .'</option>';
                        };
                    ?>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Ort hinzufügen</button>
        </form>
    </div>
    <div class="container mt-5">
    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {

        try {
            $db = new Conn();

            // Ortsdaten aus dem Formular erhalten
            $ort = $_POST["ort"];
            $plzId = $_POST["plz"];

            // Überprüfen, ob der Datensatz bereits existiert
            $sql = "SELECT * FROM ort WHERE ort_name = ?";
            $stmt = $db->makeStatement($sql, array($ort));

            if ($stmt->rowCount() > 0) {
                echo "Der Ort ". $ort ." ist bereits vorhanden. Hier können nur neue Ortsnamen erfasst werden!";
            } else {
                // Ort in die Datenbank einfügen
                $sql = "INSERT INTO ort (ort_name) VALUES (?)";
                $result = $db->makeStatement($sql, array($ort));
                $ortId = $db->conn->lastInsertId();
                echo "Ort wurde erfolgreich hinzugefügt.";

                $sql = "insert into ort_plz(ort_id, plz_id) values (?, ?);";
                $result = $db->makeStatement($sql, array($ortId, $plzId));

                getTable($db);

            }
        } catch (PDOException $e) {
            die("Fehler: " . $e->getMessage());
        }
    }
    ?>
    </div>


    <!-- Füge den Bootstrap JS-Link hier ein -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
<?php
class Conn
{
    var $conn;
    public function __construct()
    {
        try {
            $servername = "localhost";
            $username = "root";
            $password = "admin";
            $schema = "adresse";
            /*
            $servername = "127.0.0.1";
            $username = "root";
            $password = "admin";
            $schema = "dag";
            */
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
            $str = 'Fehler - ' . $e->getCode() . ': ' . $e->getMessage() . '<br>';
            echo $str;
        }
    }
}

function getTable($db){
    $sql = "SELECT * from plz
                join ort_plz using (plz_id)
                join ort using (ort_id)
                order by plz_nr asc;";
    $stmt = $db->makeStatement($sql);
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $str =  '
            <table class="table">
            <thead>
                <tr>
                <th scope="col">PLZ</th>
                <th scope="col">Ort</th>

                </tr>
            </thead>
            <tbody>';

    foreach($result as $row){
        $str .= '<tr>
                     <td>'. $row["plz_nr"] .'</td>
                     <td>'. $row["ort_name"] .'</td><tr>';
    }
   $str .= '</tbody>
    </table>';
    echo $str;
}
?>