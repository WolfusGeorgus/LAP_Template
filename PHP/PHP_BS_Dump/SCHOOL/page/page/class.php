<?php

if(isset($_POST['save']))
{
 try
 {
    echo $_POST["school"];
    echo $_POST["schuljahr"];
    echo '<h5>Klasse: '.$_POST["name"].'</h5>';

    $name = $_POST["name"];
    $scpeId = $_POST["scpe"];


    $insert = 'insert into school_class (sccl_name) values (?)';

    $arr = array($name);
    $stmt = makeStatement($insert, $arr);

    if ($stmt instanceof PDOException){
     if ($stmt->errorInfo[1] == 1062){
      if (isAssigned($name, $scpeId)){
        echo '<h3> Die Klasse und Zuweisung existierten bereits. </h3>';
      }else{
        echo '<h3> Die Klasse existierte bereits und wurde jetzt zugewiesen. </h3>';
      }
     };
    } else{
      $query = 'SELECT LAST_INSERT_ID()';

      $stmt = makeStatement($query);
      $lastId = $stmt->fetchColumn();
  
      $insert = 'insert into school_period_class(scpe_id, sccl_id) values (?, ?);';
      $stmt = makeStatement($insert, array($scpeId, $lastId));
  
  
      echo '<h3> Die Daten wurden erfolgreich gespeichert </h3>';
    }


 }
 catch (Exception $e)
 {
  echo 'Fehler - ' . $e->getCode(). ': ' . $e->getMessage() . '<br>';
 }
}else if (isset($_POST['turnus'])){

  $school ='<h1>'. $_POST["school"] .'</h1>';
  $schuljahr = getSchuljahr($_POST["option"]);

  echo $school;
  echo $schuljahr;
  ?>

    <div class="container">
      <h2>Neue Klasse einfügen</h2>
      <form method="post">
          <div class="form-group">
              <label for="long">Name</label>
              <input type="text" class="form-control" id="name" name="name" required>
              <input hidden type="text" class="form-control" id="name" name="scpe" value="<?php echo $_POST["option"] ?>" required>
              <input hidden type="text" class="form-control" id="name" name="school" value="<?php echo $school ?>" required>
              <input hidden type="text" class="form-control" id="name" name="schuljahr" value="<?php echo $schuljahr ?>" required>
          </div>
          <br>
          <button type="submit" class="btn btn-primary" name="save">Sichern</button>
      </form>
    </div>

<?php
}
else if (isset($_POST['school'])){
  getTurnus($_POST["select"]);
}
else  
{
  getSchools();

}

echo '<h2>Klassen</h2>';
/* Liste bestehender */
#$query = 'select sch_id SchulID, sch_short_name Schulname from school where sch_id = ?';

$query = 'select sccl_name Klassenname from school_class order by sccl_name asc';


#$schid = 401075;
#$arr = array($schid);

makeTable($query); #, $arr);



