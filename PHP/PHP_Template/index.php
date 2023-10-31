<?php include 'functions/conn.php'; ?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Test</title>

  <!-- Bootstrap 5.3.2 -->
  <link href="assets/css/bootstrap.min.css" rel="stylesheet">
  <script src="assets/js/bootstrap.bundle.min.js"></script>
</head>
<body>
  <nav class="navbar navbar-expand-sm navbar-dark bg-dark">
    <div class="container-fluid">
      <a class="navbar-brand" href="?page=home">Test</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav me-auto mb-2 mb-sm-0">
          <li class="nav-item">
            <a class="nav-link" href="?page=home">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="?page=page1">Page1</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="?page=form">Form</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container mt-3">
    <?php
      if(isset($_GET['page']))
      {
        switch($_GET['page'])
        {
          case 'page1':
            include 'page/page1.php';
            break;
          case 'form':
            include 'page/form.php';
            break;
          default:
            include 'page/home.php';
        }
      } else 
      {
        include "page/home.php";
      }
    ?>
  </div>
</body>
</html>