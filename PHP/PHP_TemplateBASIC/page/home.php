<h1>HomePage</h1>

<div class="card text-bg-light my-3" style="width: 50%;">
  <img src="assets/img/pic.png">
</div>

<div class="card text-bg-light my-3">
  
  <?php
    $query = "select * from person"; 
    makeTable($query); 
  ?>
</div>

<div class="card text-bg-light my-3">
  <?php 
      $query = "select * from company"; 
      makeTable($query); 
  ?>
</div>