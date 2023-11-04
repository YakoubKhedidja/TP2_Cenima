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
}