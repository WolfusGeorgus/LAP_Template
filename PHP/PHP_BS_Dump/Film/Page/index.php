<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Movies search</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
  </head>
<body>
    <div class="container mt-5">
        <h1>Nach Filmtitel suchen</h1>
        <form action="index.php" method="POST">
            <div class="form-group">
                <label>Auswahl:</label>
                <div class="form-check">
                    <input type="radio" class="form-check-input" name="auswahl" value="option1" checked>
                    <label class="form-check-label">Originalfilm</label>
                </div>
                <div class="form-check">
                    <input type="radio" class="form-check-input" name="auswahl" value="option2">
                    <label class="form-check-label">Fremdsprachentiteln</label>
                </div>
                <div class="form-check">
                    <input type="radio" class="form-check-input" name="auswahl" value="option3">
                    <label class="form-check-label">Episodentiteln</label>
                </div>
                <div class="form-check">
                    <input type="radio" class="form-check-input" name="auswahl" value="option4">
                    <label class="form-check-label">alle oben genannten</label>
                </div>
            </div>
            <div class="form-group">
                <label for="suchbegriff">Suchbegriff:</label>
                <input type="text" class="form-control" id="suchbegriff" name="suchbegriff">
            </div>
            <button type="submit" class="btn btn-primary" name="submit">Suchen</button>
        </form>
        <div id="ergebnis">
            <!-- Hier werden die Ergebnisse angezeigt -->
            <?php
            if (isset($_POST['submit'])) {
                // Handle form submission and display the results here
                $auswahl = $_POST['auswahl'];
                $suchbegriff = $_POST['suchbegriff'];
                    generateCards($auswahl, $suchbegriff);

            }
            ?>
        </div>
    </div>

    <!-- Bootstrap JS und jQuery einbinden -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        </body>
        </html>
<?php

// Close the database connection
$conn = null;

function generateCards($selectedOption, $search) {
    $conn = new Conn();

    $result = getResultByOption($selectedOption, $search,$conn);
    $string = "";
    if (count($result) > 0) {
        $string .= '<div class="row row-cols-1 row-cols-md-3 g-4">';
        foreach ($result as $mov) {
            $movie = getMovieById($mov, $conn);

            $string .= '<div class="col">
                        <div class="card shadow h-80" >
                        <img src="' . $movie['url'] . '" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">' . $movie['title'] . ' - ' . $movie['episode'] . ' (' . $movie["year"] .')</h5>
                            <p class="card-text">Darsteller:</p>';

            foreach($movie["worker"] as $actor){
                $string .= '<p class="card-text" style="margin: 0px;">' . $actor . '</p>';
            }

            $string .=  '<p class="card-text" style="margin-top: 10px">Regie:</p>';

            foreach($movie["regie"] as $regie){
                $string .= '<p class="card-text">' . $regie . '</p>';
            }
            $string .=    '   </div>
                            </div>
                        </div>';
        }
        $string .= "</div>";
    } 
    echo $string;
}

function getMovieById($movie, $conn){
    $result = [
        "id" => $movie["id_movie"],
        "title" => $movie["name"],
        "episode" => $movie["episode"],
        "year" => $movie["relase_year"],
        "url" => $movie["poster"]
    ];

    $result["regie"] = getRegie($result["id"], $conn);
    $result["worker"] = getWorker($result["id"], $conn);

    return $result;
}

function getRegie($id, $conn){
    $query = "select * from 
                movie m
                join movie_person using (id_movie)
                join person using (id_person)
                where id_mpt = 3
                and id_movie = ?;";
    $stmt = $conn->makeStatement($query, array($id));
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $arr = [];
    foreach ($result as $reg){
        $arr[] = $reg["name"];
    }
    return $arr;
}

function getWorker($id, $conn){
    $query = "select * from 
                movie m
                join movie_person using (id_movie)
                join person using (id_person)
                where id_mpt in (1, 2)
                and id_movie = ?;";
    $stmt = $conn->makeStatement($query, array($id));
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $arr = [];
    foreach ($result as $reg){
        $arr[] = $reg["name"];
    }
    return $arr;
}

function getResultByOption($option, $search, $conn){
    $query = "select * from film";

    switch ($option)
        {
            case "option1":
                $query = "select id_movie, relase_year, t.name, e.name episode, poster
                                    from movie m
                                    join movie_language ml using (id_movie)
                                    join title t using (id_title)
                                    left join episode_title e using (id_epti)
                                    where is_original = 1
                                    and t.name like ?;";
                $movies = getMovies($query, $search, $conn);
                return $movies;
            case "option2":
                $query = "select id_movie, relase_year, t.name, e.name episode, poster
                                    from movie m
                                    join movie_language ml using (id_movie)
                                    join title t using (id_title)
                                    left join episode_title e using (id_epti)
                                    where is_original = 0
                                    and t.name like ?;";
                $movies = getMovies($query, $search, $conn);
                return $movies;
            case "option3":
                $query = "select id_movie, relase_year, t.name, e.name episode, poster
                                    from movie m
                                    join movie_language ml using (id_movie)
                                    join title t using (id_title)
                                    left join episode_title e using (id_epti)
                                    where is_original in (0, 1)
                                    and e.name like ?;";
                $movies = getMovies($query, $search, $conn);
                return $movies;
            case "option4":
                $query = "select id_movie, relase_year, t.name, e.name episode, poster
                                            from movie m
                                            join movie_language ml using (id_movie)
                                            join title t using (id_title)
                                            left join episode_title e using (id_epti)
                                            where is_original in (0, 1)
                                            and t.name like ?
                            union
                            select id_movie, relase_year, t.name, e.name episode, poster
                                            from movie m
                                            join movie_language ml using (id_movie)
                                            join title t using (id_title)
                                            left join episode_title e using (id_epti)
                                            where is_original in (0, 1)
                                            and e.name like ?;";
                $movies = getMovies($query, $search, $conn, 1);
                return $movies;
            default:
            break;
        }
    
    return 1;
}

function getMovies($query, $search, $conn, $all = 0){
    if ($all == 1){
        $stmt = $conn->makeStatement($query, array('%'.$search.'%', '%'.$search.'%'));
    }else{
        $stmt = $conn->makeStatement($query, array('%'.$search.'%'));
    }
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    return $result;
} 

class Conn
{
    var $conn;
    public function __construct()
    {
        try {
            $servername = "localhost:3306";
            $username = "root";
            $password = "admin";
            $schema = "mydb";

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
            echo 'Fehler - ' . $e->getCode() . ': ' . $e->getMessage() . '<br>';
        }
    }
}
?>
