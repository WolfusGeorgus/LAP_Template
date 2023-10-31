<?php
echo '<h2>Schulbezeichnung</h2>';

/* Schule erfassen:  */


if(isset($_POST['save']))
{
 // save Button gedrückt, Speichern und Text ausgeben
 try
 {
    $long = $_POST["long"];
    $short = $_POST["short"];

    $insert = 'insert into school (sch_long_name, sch_short_name) values (?, ?)';

    $arr = array($long, $short);
    makeStatement($insert, $arr);

    echo '<h3> Die Daten wurden erfolgreich gespeichert </h3>';
 }
 catch (Exception $e)
 {
  echo 'Fehler - ' . $e->getCode(). ': ' . $e->getMessage() . '<br>';
 }
}
else
{
  // Formular anzeigen
  ?>

    <div class="container">
      <h2>Neue Schule einfügen</h2>
      <form method="post">
          <div class="form-group">
              <label for="long">langer Name</label>
              <input type="text" class="form-control" id="long" name="long" required>
          </div>

          <div class="form-group">
              <label for="short">kurzer Name</label>
              <input type="text" class="form-control" id="short" name="short" required>
          </div>

          <button type="submit" class="btn btn-primary" name="save">Sichern</button>
      </form>
    </div>

<?php
}

/* Liste bestehender */
#$query = 'select sch_id SchulID, sch_short_name Schulname from school where sch_id = ?';

$query = 'select sch_id SchulID, sch_short_name Schulname from school';


#$schid = 401075;
#$arr = array($schid);

makeTable($query); #, $arr);

