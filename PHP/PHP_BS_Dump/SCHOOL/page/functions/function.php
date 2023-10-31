<?php

  function makeStatement($query, $arrayValues = null)
  {
    global $conn;
    try
    {
      $stmt = $conn->prepare($query); 
      $stmt->execute($arrayValues);
      return $stmt;
    }
    catch(Exception $e) 
    {
      #echo 'Fehler - ' . $e->getCode(). ': ' . $e->getMessage() . '<br>';
      return $e;
    }
  }

  function makeTable($query, $arrayValues = null)
  {
    try
    {
      $stmt = makeStatement($query, $arrayValues);
      /* Die Attributeigenschaften können über meta-Daten ermittelt werden z.B. Attributbezeichnung (name), Datentyp, , PK usw. */ 
      $meta = array();
      echo '<table class="table">
            <tr class ="tr">';

      for ($i = 0; $i < $stmt->columnCount(); $i++)
      {
        $meta[] = $stmt->getColumnMeta($i);
        echo '<th class="th">' . $meta[$i]['name'] . '</th>';

      }
      echo '</tr>';


      $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
      foreach ($results as $row) {
        echo "<tr>";
        foreach ($row as $value) {
            echo "<td>$value</td>";
        }
        echo "</tr>";
    }

      echo '</table>';
    }
    catch(Exception $e) 
    {
      echo 'Fehler - ' . $e->getCode(). ': ' . $e->getMessage() . '<br>';
    }
  }

function getSchools(){
  $query = 'select * from school 
              ORDER BY
              REGEXP_SUBSTR(sch_long_name, "^[[:alpha:]]*"),
              CAST(REGEXP_SUBSTR(sch_long_name, "[[:digit:]]*$") AS UNSIGNED);';
  $stmt = makeStatement($query);
  $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

  echo '<form method="post">
          <div class="form-group">
            <select class="form-select" name="select" aria-label="Default select example">';
  foreach ($result as $entry){
    echo '<option value="'. $entry["sch_id"] .'">' . $entry["sch_long_name"] . '</option>';
  }
  echo     '</select>
          </div>
          <br>
        <button type="submit" name ="school" class="btn btn-primary">Auswählen</button>
      </form>';
}

function getTurnus($schId){
  $query = 'select concat_ws(" - ", sch_long_name, sch_id) result from school where sch_id = ?;';
  $stmt = makeStatement($query, array($schId));
  $school = $stmt->fetch(PDO::FETCH_ASSOC);

  echo '<h1>'. $school["result"] .'</h1>';

  $query = 'select  if (scpe_from is not null, 
                concat(concat_ws(" - ", scye_from, scye_to), " Turnus: ", concat_ws(" - ", scpe_from, scpe_to)), 
                concat_ws(" - ", scye_from, scye_to)) time, scpe_id from school_year
              left join school_period using (scye_id)
              where sch_id = ?;';
  $stmt = makeStatement($query, array($schId));
  $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

  echo '<form id="turnus" method="POST">
          <div class="form-group">
              <label>Wähle einen Zeitraum:</label>';
  $first = 0;
  foreach ($result as $entry){
    if ($first == 0){
      echo '      <div class="form-check">
      <input type="radio" class="form-check-input" id="radioOption1" name="option" value="'. $entry["scpe_id"] .'" checked>
      <label class="form-check-label" for="radioOption1">'. $entry["time"]  .'</label>
  </div>';
    } else {
    echo '      <div class="form-check">
                    <input type="radio" class="form-check-input" id="radioOption1" name="option" value="'. $entry["scpe_id"] .'">
                    <label class="form-check-label" for="radioOption1">'. $entry["time"]  .'</label>
                </div>';
    }

  }
  echo     '</div>
          <input hidden  name="school" value="'. $school["result"] .'">
          <button type="submit" class="btn btn-primary" name ="turnus" id="confirmButton">Bestätigen</button>
        </form>';
}

function getSchuljahr($scpeId){

  $string = "";
  $query = 'select concat_ws(" - ", scye_from, scye_to) result 
              from school_year
              join school_period using (scye_id) where scpe_id = ?;';
  $stmt = makeStatement($query, array($scpeId));
  $result = $stmt->fetch(PDO::FETCH_ASSOC);

  $string .= '<h5>Schuljahr: '. $result["result"] .'</h5>';

  $query = 'select concat_ws(" - ", scpe_from, scpe_to) result from school_period where scpe_id = ?;';
  $stmt = makeStatement($query, array($scpeId));
  $result = $stmt->fetch(PDO::FETCH_ASSOC);
 if ($result["result"] != ""){
  $string .= '<h5>Turnus: '. $result["result"] .'</h5>';
 }else{
  $string .= '<h5>Turnus /</h5>';
 }
 return $string;
}

function isAssigned($name, $scpeId){
  $query = "select * from school_class 
              join school_period_class using (sccl_id)
              where sccl_name = ?
                and scpe_id = ?";
  $stmt = makeStatement($query, array($name, $scpeId));
  $result = $stmt->fetch(PDO::FETCH_ASSOC);
  if (!$result) {
    $insert = 'insert into school_period_class(scpe_id, sccl_id) values (?, (select sccl_id from school_class where sccl_name = ?));';
    $stmt = makeStatement($insert, array($scpeId, $name));
      return $result;
  }
  return $result;
}