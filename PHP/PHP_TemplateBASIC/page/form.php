<div class="card text-bg-light m-3 p-3" style="width:500px">
<h5 class="card-title mb-3">Beispiel Form</h5>
  <form method="POST" action="#">
    
    <div class="form-floating mb-3">
      <input type="text" class="form-control" id="input1" name="firstname">
      <label for="input1">Firstname</label>
    </div>

    <div class="form-floating mb-3">
      <input type="text" class="form-control" id="input2" name="lastname">
      <label for="input2">Lastname</label>
    </div>

    <div class="form-floating mb-3">
      <input type="number" class="form-control" id="input3" name="number">
      <label for="input3">Input Number</label>
    </div>

    <div class="form-floating mb-3">
      <input type="date" class="form-control" id="input4" name="date" max="<?php echo date('Y-m-d', strtotime('+1 week')) ?>">
      <label for="input4">Input Date</label>
    </div>

    <div class="mb-3">
      <select class="form-select" name="select">
        <option value="null" selected>Select</option>
        <option value="1">Eins</option>
        <option value="2">Zwei</option>
      </select>
    </div>

    <div class="mb-3">
      <div class="form-check">
        <input class="form-check-input" type="checkbox" id="checkbox1" name="checkbox_one" value="1">
        <label class="form-check-label" for="checkbox1">Checkbox</label>
      </div>
      <div class="form-check">
        <input class="form-check-input" type="checkbox" id="checkbox2" name="checkbox_two" value="2" checked>
        <label class="form-check-label" for="checkbox2">Checkbox default checked</label>
      </div>
    </div>

    <div class="mb-3">
      <div class="form-check">
        <input class="form-check-input" type="radio" id="radio1" name="radio" value="1">
        <label class="form-check-label" for="radio1">Radio</label>
      </div>
      <div class="form-check">
        <input class="form-check-input" type="radio" id="radio2" name="radio" value="2" checked>
        <label class="form-check-label" for="radio2">Radio default checked</label>
      </div>
    </div>

    <button type="submit" class="btn btn-success" name="action" value="add">Hinzufügen</button>
    <button type="submit" class="btn btn-warning" name="action" value="change">Bearbeiten</button>
    <button type="submit" class="btn btn-danger" name="action" value="delete">Entfernen</button>
  </form>
</div>

<?php

if (isset($_POST['action'])) {

  $date = $_POST['date'];
  $number = $_POST['number'];
  $firstname = $_POST['firstname'];
  $lastname = $_POST['lastname'];

  $conn = new Conn();

  if ($_POST['action'] == 'add') {
    $query= "insert into person (per_fname, per_lname) values (?,?)";
    $conn->makeStatement($query, array($firstname, $lastname));
  }
  else if ($_POST['action'] == 'change') {
    $query= "update person set per_fname = ?, per_lname = ? where per_id = ?";
    $conn->makeStatement($query, array($firstname, $lastname, $number));
  }
  else if ($_POST['action'] == 'delete') {
    $query= "delete from person where per_id = ?";
    $conn->makeStatement($query, array($number));
  }
  

  echo '<div class="card text-bg-light m-3 p-3">';
  echo '<h5 class="card-title mb-3">$_POST Array:</h5>';
  
  foreach ($_POST as $key => $value) {
    echo '<p>$_POST["'. $key .'"] -> "'. $value .'"</p>';
  }
  echo '</div>';

  echo '<div class="card text-bg-light m-3 p-3">';
  echo '<h5 class="card-title mb-3">Result:</h5>';
  $query = "select * from person;";
  makeTable($query);
  echo '</div>';
}
