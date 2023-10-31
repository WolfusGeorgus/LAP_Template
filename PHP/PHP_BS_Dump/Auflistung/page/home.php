 
  <?php
    if ((count($_POST)) == 0){
      $query = "show databases;"; 
      $arrayValues = array();
      $conn = new Conn();
      $stmt = $conn->makeStatement($query, $arrayValues);
    
      echo '<h1>Datenbanken</h1><div class="card text-bg-light my-3">';
      echo '<form action="#" method="post"><table class="table">
            <tr class="tr">';
      for($i = 0; $i < $stmt->columnCount(); $i++)
      {
        $meta = $stmt->getColumnMeta($i);
        echo '<th class="th">'.$meta['name'].'</th>';
      }
      echo '<th class="th">Anzeigen</th>';
      echo '</tr>';
      while($row = $stmt->fetch(PDO::FETCH_NUM)) {
        echo '<tr class "tr">';
        foreach($row as $r) {
          echo '<td class="td">'.$r.'</td>';
          echo '<td class="td"><button type="submit" class="btn btn-secondary" name="schema" value="'. $r .'" >Anzeigen</button></td>';
        }
        echo '</tr>';
      }
      echo '</table></form>';
    }else if (isset($_POST["schema"])){

      $schema = $_POST["schema"];
      $query = "show tables;"; 
      $arrayValues = array();
      $conn = new Conn($schema);
      $stmt = $conn->makeStatement($query, $arrayValues);
    
      echo '<h1>Tabellen von: '. $schema .'</h1><div class="card text-bg-light my-3">';
      echo '<form action="#" method="post">
            <input hidden name ="db" value="'. $schema .'"></input>
          <table class="table">
            <tr class="tr">';
      for($i = 0; $i < $stmt->columnCount(); $i++)
      {
        $meta = $stmt->getColumnMeta($i);
        echo '<th class="th">'.$meta['name'].'</th>';
      }
      echo '<th class="th">Info</th>';
      echo '<th class="th">Anzeigen</th>';
      echo '</tr>';
      while($row = $stmt->fetch(PDO::FETCH_NUM)) {
        echo '<tr class "tr">';
        foreach($row as $r) {
          echo '<td class="td">'.$r.'</td>';
          echo '<td class="td"><button type="submit" class="btn btn-secondary" name="info" value="'. $r .'" >Beschreibung</button></td>';
          echo '<td class="td"><button type="submit" class="btn btn-secondary" name="inhalt" value="'. $r .'" >Inhalt</button></td>';
        }
        echo '</tr>';
      }
      echo '</table></form>';
    }
    //
    else {
      $schema = $_POST["db"];
      echo '<h1>Schema: '. $schema .'</h1>';

      if (isset($_POST["info"])){
        $query = "describe ". $_POST["info"] .";";
        echo '<h1>Info von: '. $_POST["info"] .'</h1><div class="card text-bg-light my-3">';
      }else if(isset($_POST["inhalt"])){
        $query = "select * from ". $_POST["inhalt"] .";";
        echo '<h1>Inhalt von: '. $_POST["inhalt"] .'</h1><div class="card text-bg-light my-3">';
      }
 
      $arrayValues = array();
      $conn = new Conn($schema);
      $stmt = $conn->makeStatement($query, $arrayValues);
    


      echo '<form action="#" method="post">
            <input hidden name ="db" value="'. $schema .'"></input>
          <table class="table">
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
      echo '</table></form>';
    }

  ?>
</div>
