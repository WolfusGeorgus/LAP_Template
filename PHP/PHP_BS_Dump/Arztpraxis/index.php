<!DOCTYPE html>
<html>
<head>
    <title>Arzt</title>

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
      </ul>
    </div>
  </div>
</nav>

    <div class="container mt-5">
        <form method="post" action="index.php">
        <h2>Patienten Diagnose</h2>
            <div class="mb-3">
                <label for="svnr">SV-Nr.</label>
                <input style="width: 15em;" id ="svnr" type="text" class="form-control" name="svnr" maxlength="4" minlength="4" required placeholder="vierstellige Zahl">
            </div>
            <div class="mb-3">
                <label for="dot">Geburtstag</label>
                <input style="width: 15em;" id ="dot" type="date" class="form-control" name="dot" required>
            </div>
            <h2>Behandlungszeitraum</h2>
            <div class="mb-3">
                <label for="start">Start</label>
                <input style="width: 15em;" id ="start" type="date" class="form-control" name="start" >
            </div>

            <div class="mb-3">
                <label for="end">Ende</label>
                <input style="width: 15em;" id ="end" type="date" class="form-control" name="end">
            </div>
            <button type="submit" class="btn btn-primary" name="submit" >Anzeigen</button>
        </form>
    </div>
    <div class="container mt-5">
    <?php
        if (isset($_POST['submit'])) {
          include 'conn.php';
          // Handle form submission and display the results here
          $svnr = $_POST['svnr'];
          $dot = $_POST['dot'];
          $start = $_POST['start'];
          $end = $_POST['end'];
          $result;
          $conn = new Conn();

          if (!is_numeric($svnr) || $dot > '9999-31-12' || $dot < '1000-01-01') {
            echo '<h1>SVNR muss eine vierstellige ZAHL sein</h1>';
            echo '<h1>Das Datum muss diesem Format (12-31-9999) entsprechen</h1>';
            return;
          };
          if ($end == ""){
            $end = '9999-12-31';
          } 
          if ($start == ""){
            $start = '-9999-12-31';
          }
          $arr = array($svnr, $dot, $start, $end);
          $query = "select concat_ws(' - ', ter_begin, ter_end) time, concat_ws(' ', per_vname,  per_nname) patient,
          per_svnr svnr, dia_name diagnosis from person
                    join behandlungszeitraum using (per_id)
                      join diagnose using (dia_id)
                      where per_svnr = ?
                        and per_geburt = ?
                        and (ter_begin > ? or ter_begin is null)
                        and (ter_end < ? or ter_end is null);";
          $result = $conn->makeStatement($query, $arr)->fetchAll(PDO::FETCH_ASSOC);

          $str = "<h1>Ergebnis<h1>
                    <h2>Suchkriterien</h2>
                     <p>SV-Nr.: ". $svnr ."/".$dot."</p>";
          
          if ($start != '-9999-12-31'){
            $str .= "<p>Startzeitraum: ".$start."</p>";
          }
          if ($end != '9999-12-31'){
            $str .= "<p>Endzeitraum: ".$end."</p>";
          }

          if (count($result) == 0) {  
            $str .= "<h2>Es sind keine Ergebnisse vorhanden<h2>";
          } else {
            $str .= '<table class="table">
            <thead>
              <tr>
                <th scope="col">Zeitraum</th>
                <th scope="col">Patient</th>
                <th scope="col">SVNr</th>
                <th scope="col">Diagnose</th>
              </tr>
            </thead>
            <tbody>';

              foreach ($result as $row) {
              
                $str .= '<tr>
                            <td>'. $row["time"] .'</td>
                            <td>'. $row["patient"] .'</td>
                            <td>'. $row["svnr"] .'</td>
                            <td>'. $row["diagnosis"] .'</td>
                          </tr>';
              };



          $str .= '</tbody>
                  </table>';
          };         
          echo $str;
      }
    ?>
    </div>
    <!-- Füge den Bootstrap JS-Link hier ein -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
  
</body>
</html>
