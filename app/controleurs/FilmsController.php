<?php

class FilmsController extends Routeur {
    private $oRequetesSQL;

    public function __construct() {
        $this->oRequetesSQL = new RequetesSQL();
    }

    public function listerTousFilms() {
        // Récupérez la liste de tous les films depuis la base de données
        $films = $this->oRequetesSQL->getFilms();
        
        // Affichez la liste des films en utilisant une vue appropriée
        new Vue("vListeFilms", ['titre' => 'Liste des Films', 'films' => $films], 'gabarit-frontend');
    }

    public function ajouterFilm() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            // Récupérer les données du formulaire
            $titre = $_POST['film_titre'];
            $duree = $_POST['film_duree'];
            $annee_sortie = $_POST['film_annee_sortie'];
            $resume = $_POST['film_resume'];
            $affiche = $_POST['film_affiche'];
            $bande = $_POST['film_bande_annonce'];
            $statut = $_POST['film_statut'];
            $genre = $_POST['genre_nom'];

            // Effectuez les opérations d'ajout dans la base de données
            $filmId = $this->oRequetesSQL->ajoutFilm($titre, $duree, $annee_sortie, $resume, $affiche, $bande, $statut, $genre);

            // Redirigez l'utilisateur vers la page de liste des films
            header('Location: listerTousFilms');
            exit();
        }

        // Affichez le formulaire pour ajouter un film (à faire si la méthode est GET)
        new Vue("ajouter_film", ['titre' => 'Ajouter un Film'], 'gabarit-frontend');
    }

    public function modifierFilm($filmid) {

        // Initialisez un tableau associatif pour stocker les champs mis à jour
        $champsMaj = [];

        foreach ($_POST as $champ => $valeur) {
            // Vérifiez si le champ est non vide
            if (!empty($valeur)) {
                $champsMaj[$champ] = $valeur;
            }
        }

        // Si aucun champ n'a été modifié, ne poursuivez pas la mise à jour
        if (empty($champsMaj)) {
            header('Location: liste_films.php');
            exit;
        }

        // Requête SQL pour mettre à jour les données du film dans la base de données
        $sql = "UPDATE film SET ";

        foreach ($champsMaj as $champ => $valeur) {
            $sql .= "$champ = :$champ, ";
        }

        $sql = rtrim($sql, ', '); // Supprime la virgule finale

        $sql .= " WHERE film_id = :filmid";

        // Utilisation d'une requête préparée pour sécuriser la mise à jour
        $sPDO= SingletonPDO::getInstance();
        $stmt = $this->$sPDO->prepare($sql);

        // Protéger les données pour éviter les injections SQL
        $stmt->bindParam(':filmid', $filmid, PDO::PARAM_INT);

        foreach ($champsMaj as $champ => $valeur) {
            $stmt->bindParam(":$champ", $valeur, PDO::PARAM_STR);
        }

        // Exécution de la requête
        $stmt->execute();

        // Redirigez l'utilisateur vers la page de liste des films
        header('Location: liste_films.php');
        exit;
    }


    public function supprimerFilm($filmid) {
        // Vérifier si $filmid est un entier
        $filmid = (int) $filmid;

        if ($filmid <= 0) {
            // L'ID du film est invalide, redirigez l'utilisateur vers la page de liste des films
            header('Location: liste_films.php');
            exit;
        }

        // Requête SQL pour supprimer le film de la base de données
        $sql = "DELETE FROM film WHERE film_id = :filmid";

        // Utilisation d'une requête préparée pour éviter les injections SQL
        $pdo = SingletonPDO::getInstance();
        $statement = $pdo->prepare($sql);

        // Liez la valeur de $filmid à la requête préparée
        $statement->bindValue(':filmid', $filmid, PDO::PARAM_INT);

        // Exécution de la requête de suppression
        $statement->execute();

        // Redirigez l'utilisateur vers la page de liste des films
        header('Location: liste_films.php');
        exit;
    }

}

?>