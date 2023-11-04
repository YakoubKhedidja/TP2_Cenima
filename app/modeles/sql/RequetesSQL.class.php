<?php

/**
 * Classe des requêtes SQL
 *
 */
class RequetesSQL extends RequetesPDO {

  /**
   * Récupération des films à l'affiche ou prochainement
   * @param  string $critere
   * @return array tableau des lignes produites par la select   
   */ 
  public function getFilms($critere = 'enSalle') {
    $oAujourdhui = ENV === "DEV" ? new DateTime(MOCK_NOW) : new DateTime();
    $aujourdhui  = $oAujourdhui->format('Y-m-d');
    $dernierJour = $oAujourdhui->modify('+6 day')->format('Y-m-d');
    $this->sql = "
      SELECT film_id, film_titre, film_duree, film_annee_sortie, film_resume,
             film_affiche, film_bande_annonce, film_statut, genre_nom
      FROM film
      INNER JOIN genre ON genre_id = film_genre_id
      WHERE film_statut = ".Film::STATUT_VISIBLE;

      switch($critere) {
        case 'enSalle':
          $this->sql .= " AND film_id IN (SELECT DISTINCT seance_film_id FROM seance
                                         WHERE seance_date >='$aujourdhui' AND seance_date <= '$dernierJour')";
          break;
        case 'prochainement':
          $this->sql .= " AND film_id NOT IN (SELECT DISTINCT seance_film_id FROM seance
                                             WHERE seance_date <= '$dernierJour')";
          break;
      }      
    return $this->getLignes();
  }

  /**
   * Récupération d'un film
   * @param int $film_id, clé du film 
   * @return array|false tableau associatif de la ligne produite par la select, false si aucune ligne  
   */ 
  public function getFilm($film_id) {
    $this->sql = "
      SELECT film_id, film_titre, film_duree, film_annee_sortie, film_resume,
             film_affiche, film_bande_annonce, film_statut, genre_nom
      FROM film
      INNER JOIN genre ON genre_id = film_genre_id
      WHERE film_id = :film_id AND film_statut = ".Film::STATUT_VISIBLE;

    return $this->getLignes(['film_id' => $film_id], RequetesPDO::UNE_SEULE_LIGNE);
  }

  /**
   * Récupération des réalisateurs d'un film
   * @param int $film_id, clé du film
   * @return array tableau des lignes produites par la select 
   */ 
  public function getRealisateursFilm($film_id) {
    $this->sql = "
      SELECT realisateur_nom, realisateur_prenom
      FROM realisateur
      INNER JOIN film_realisateur ON f_r_realisateur_id = realisateur_id
      WHERE f_r_film_id = :film_id";

    return $this->getLignes(['film_id' => $film_id]);
  }

  /**
   * Récupération des pays d'un film
   * @param int $film_id, clé du film
   * @return array tableau des lignes produites par la select 
   */ 
  public function getPaysFilm($film_id) {
    $this->sql = "
      SELECT pays_nom
      FROM pays
      INNER JOIN film_pays ON f_p_pays_id = pays_id
      WHERE f_p_film_id = :film_id";

    return $this->getLignes(['film_id' => $film_id]);
  }

  /**
   * Récupération des acteurs d'un film
   * @param int $film_id, clé du film
   * @return array tableau des lignes produites par la select 
   */ 
  public function getActeursFilm($film_id) {
    $this->sql = "
      SELECT acteur_nom, acteur_prenom
      FROM acteur
      INNER JOIN film_acteur ON f_a_acteur_id = acteur_id
      WHERE f_a_film_id = :film_id
      ORDER BY f_a_priorite ASC";

    return $this->getLignes(['film_id' => $film_id]);
  }

  /**
   * Récupération des séances d'un film
   * @param int $film_id, clé du film
   * @return array tableau des lignes produites par la select 
   */ 
  public function getSeancesFilm($film_id) {
    $oAujourdhui = ENV === "DEV" ? new DateTime(MOCK_NOW) : new DateTime();
    $aujourdhui  = $oAujourdhui->format('Y-m-d');
    $dernierJour = $oAujourdhui->modify('+6 day')->format('Y-m-d');
    $this->sql = "
      SELECT DATE_FORMAT(seance_date, '%W') AS seance_jour, seance_date, seance_heure
      FROM seance
      INNER JOIN film ON seance_film_id = film_id
      WHERE seance_film_id = :film_id AND seance_date >='$aujourdhui' AND seance_date <= '$dernierJour'
      ORDER BY seance_date, seance_heure";

    return $this->getLignes(['film_id' => $film_id]);
  }


// ============================== Fonctionnalités CRUD ====================
/**
 * Récupération de la liste de tous les films
 *
 * @return array tableau des films
 */
public function getTousFilms() {
  $this->sql = "
      SELECT * FROM film";

  return $this->getLignes();
}


  public function ajoutFilm($titre, $duree, $annee_sortie, $resume, $affiche, $bande, $statut,  $genre) {
    // Requête SQL pour insérer un nouveau film dans la base de données
    $sql = "INSERT INTO film (film_titre, film_duree, film_annee_sortie, film_resume, film_affiche, film_bande_annonce, film_statut, film_genre_id)
    VALUES (:titre, :duree, :annee_sortie, :resume, :affiche, :bande, :statut, :genre)";
  
    // Utilisation d'une requête préparée pour sécuriser l'insertion
    $sPDO= SingletonPDO::getInstance();
    $stmt = $this->$sPDO->prepare($sql);

    // Protection des données pour éviter les injections SQL
    $stmt->bindParam(':titre', $titre, PDO::PARAM_STR);
    $stmt->bindParam(':duree', $duree, PDO::PARAM_INT);
    $stmt->bindParam(':annee_sortie', $annee_sortie, PDO::PARAM_INT);
    $stmt->bindParam(':resume', $resume, PDO::PARAM_STR);
    $stmt->bindParam(':affiche', $affiche, PDO::PARAM_STR);
    $stmt->bindParam(':bande', $bande, PDO::PARAM_STR);
    $stmt->bindParam(':statut', $statut, PDO::PARAM_INT);
    $stmt->bindParam(':genre', $genre, PDO::PARAM_INT);

    // Exécution de la requête
    $stmt->execute();

    // Récupérez l'ID du nouveau film inséré
    
    $filmId = $this->$sPDO->lastInsertId();

    return $filmId;
  }


  public function modificationFilm($film_id) {
  
        // Récupération des données mises à jour du film
        $titre = $_POST['titre'];
        $duree = $_POST['duree'];
        $annee_sortie = $_POST['annee_sortie'];
        $resume = $_POST['resume'];
        $affiche = $_POST['affiche'];
        $bande = $_POST['bande'];
        $statut = $_POST['statut'];
        $genre = $_POST['genre'];

        // Requête SQL pour mettre à jour un film dans la base de données
        $sql = "UPDATE film
                SET film_titre = :titre, film_duree = :duree, film_annee_sortie = :annee_sortie, 
                    film_resume = :resume, film_affiche = :affiche, film_bande_annonce = :bande, 
                    film_statut = :statut, film_genre_id = :genre
                WHERE film_id = :film_id";

        // Utilisation d'une requête préparée pour sécuriser l'insertion
        $sPDO= SingletonPDO::getInstance();
        $stmt = $this->$sPDO->prepare($sql);

        // Protection des données pour éviter les injections SQL
        $stmt->bindParam(':film_id', $film_id, PDO::PARAM_INT);
        $stmt->bindParam(':titre', $titre, PDO::PARAM_STR);
        $stmt->bindParam(':duree', $duree, PDO::PARAM_INT);
        $stmt->bindParam(':annee_sortie', $annee_sortie, PDO::PARAM_INT);
        $stmt->bindParam(':resume', $resume, PDO::PARAM_STR);
        $stmt->bindParam(':affiche', $affiche, PDO::PARAM_STR);
        $stmt->bindParam(':bande', $bande, PDO::PARAM_STR);
        $stmt->bindParam(':statut', $statut, PDO::PARAM_INT);
        $stmt->bindParam(':genre', $genre, PDO::PARAM_INT);

        // Exécution de la requête
        $stmt->execute();

        // Rediriger l'utilisateur vers la page de liste des films
        header('Location: liste_films.php');
}

  public function suppressionFilm($film_id) {
        // Requête SQL pour supprimer un film de la base de données
        $sql = "DELETE FROM film WHERE film_id = :film_id";

        // Utilisation d'une requête préparée pour sécuriser l'insertion
        $sPDO= SingletonPDO::getInstance();
        $stmt = $this->$sPDO->prepare($sql);

        // Protection des données pour éviter les injections SQL
        $stmt->bindParam(':film_id', $film_id, PDO::PARAM_INT);

        // Exécution de la requête
        $stmt->execute();

        // Rediriger l'utilisateur vers la page de liste des films
        header('Location: liste_films.php');
  }

}

