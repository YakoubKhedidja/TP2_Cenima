<?php
//require_once '../vues/Vue.class.php';
/**
 * Classe Contrôleur des requêtes de l'interface frontend
 * 
 */

class Frontend extends Routeur {

  private $film_id;
  
  /**
   * Constructeur qui initialise des propriétés à partir du query string
   * et la propriété oRequetesSQL déclarée dans la classe Routeur
   * 
   */
  public function __construct() {
    $this->film_id = $_GET['film_id'] ?? null; 
    $this->oRequetesSQL = new RequetesSQL;
  }


  /**
   * Lister les films à l'affiche
   * 
   */  
  public function listerAlaffiche() {
    $films = $this->oRequetesSQL->getFilms('enSalle');
    new Vue("vListeFilms",
            array(
              'titre'  => "À l'affiche",
              'films' => $films
            ),
            "gabarit-frontend");
  }

  /**
   * Lister les films diffusés prochainement
   * 
   */  
  public function listerProchainement() {
    $films = $this->oRequetesSQL->getFilms('prochainement');
    new Vue("vListeFilms",
            array(
              'titre'  => "Prochainement",
              'films' => $films
            ),
            "gabarit-frontend");
  }

  /**
   * Voir les informations d'un film
   * 
   */  
  public function voirFilm() {
    $film = false;
    if (!is_null($this->film_id)) {
      $film = $this->oRequetesSQL->getFilm($this->film_id);
      $realisateurs = $this->oRequetesSQL->getRealisateursFilm($this->film_id);
      $pays         = $this->oRequetesSQL->getPaysFilm($this->film_id);
      $acteurs      = $this->oRequetesSQL->getActeursFilm($this->film_id);

      // affichage avec vFilm.twig
      // ============================
      $seancesTemp  = $this->oRequetesSQL->getSeancesFilm($this->film_id);
      $seances = [];
      foreach ($seancesTemp as $seance) {
        $seances[$seance['seance_date']]['jour']     = $seance['seance_jour'];
        $seances[$seance['seance_date']]['heures'][] = $seance['seance_heure'];
      }
    }
    if (!$film) throw new Exception("Film inexistant.");

    new Vue("vFilm",
            array(
              'titre'        => $film['film_titre'],
              'film'         => $film,
              'realisateurs' => $realisateurs,
              'pays'         => $pays,
              'acteurs'      => $acteurs,
              'seances'      => $seances
            ),
            "gabarit-frontend");
  }

// =========================== Gestions fonctionnalités CRUD ==============
  /**
   * Lister tous les films
   */  
  public function listerTousFilms() {

    // Créer une instance de RequetesSQL
    $requetesSQL = new RequetesSQL();

    // Récupérer la liste de tous les films
    $films = $requetesSQL->getTousFilms();

    // Render la vue avec les données récupérées
    $donnees = ['films' => $films];
    //$this->Vue->afficher('listeTousFilms', $donnees);

    new Vue("listeTousFilms",
           $donnees,
            "gabarit-frontend");
  }

  /**
   * Modifier ou supprimer un film
   */  
  public function modifSpprimeFilm() {

    // Récupérer les détails du film en fonction de $film_id depuis la base de données
    $film = $requetesSQL->getFilm($film_id); 

    // Render la vue avec les données récupérées
    $donnees = ['film' => $film];
    new Vue("modifSpprimeFil", $donnees, "gabarit-frontend");
  }

  public function supprimerFilm($film_id) {
    // Utiliser une instance de RequetesSQL pour supprimer le film de la base de données
    $requetesSQL->suppressionFilm($film_id); 
  }
}

