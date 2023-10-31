<h1>Page1</h1>

<div class="card text-bg-light my-3">
  <div class="m-3">
    <h5 class="card-title">Person anlegen</h5>
    <form method="post" action="functions/func1.php">
      <div class="mb-3">
        <label for="search" class="form-label">Vorname</label>
        <input type="text" class="form-control" name="input_fname">
      </div>
      <div class="mb-3">
        <label for="search" class="form-label">Nachname</label>
        <input type="text" class="form-control" name="input_lname">
      </div>
      <button type="submit" class="btn btn-primary" name="action" value="add_person">Anlegen</button>
    </form>
  </div>
</div>

<div class="card text-bg-light my-3">
  <div class="m-3">
    <h5 class="card-title">Firma anlegen</h5>
    <form method="post" action="functions/func1.php">
      <div class="mb-3">
        <label for="search" class="form-label">Name der Firma</label>
        <input type="text" class="form-control" name="input_name">
      </div>
      <button type="submit" class="btn btn-primary" name="action" value="add_company">Anlegen</button>
    </form>
  </div>
</div>

<div class="card text-bg-light my-3">
  <div class="m-3">
    <h5 class="card-title">Zuweisung Person -> Firma</h5>
    <form method="post" action="functions/func1.php">
      <select class="form-select mb-2" name="select_person">
        <option value="-1" selected>Person auswählen</option>
        <?php
          $conn = new Conn();
          $query = "select per_id, concat(per_fname, ' ', per_lname) 'per_name' from person";
          $result = $conn->makeStatement($query);

          foreach ($result as $person) {
            echo '<option value="'.$person['per_id'].'">'.$person['per_name'].'</option>';
          }
        ?>
      </select>
      <select class="form-select mb-2" name="select_company">
        <option value="-1" selected>Firma auswählen</option>
        <?php
          $conn = new Conn();
          $query = "select com_id, com_name from company";
          $result = $conn->makeStatement($query);

          foreach ($result as $company) {
            echo '<option value="'.$company['com_id'].'">'.$company['com_name'].'</option>';
          }
        ?>
      </select>
      <button type="submit" class="btn btn-primary" name="action" value="assign_person">Zuweisen</button>
    </form>
  </div>
</div>

<div class="card text-bg-light my-3">
  <?php 
    $query = "select per_id, concat(per_fname, ' ', per_lname) 'per_name', com_name from person left join company using(com_id)";
    makeTable($query); 
    ?>
</div>