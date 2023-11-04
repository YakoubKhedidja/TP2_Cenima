--
-- Base de données : `cinema`
--

DROP SCHEMA IF EXISTS `cinema`;
CREATE SCHEMA `cinema` DEFAULT CHARACTER SET utf8 ;
USE `cinema` ;

-- --------------------------------------------------------

--
-- Structure de la table `acteur`
--

CREATE TABLE `acteur` (
  `acteur_id` int(10) UNSIGNED NOT NULL,
  `acteur_nom` varchar(255) NOT NULL,
  `acteur_prenom` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `acteur`
--

INSERT INTO `acteur` (`acteur_id`, `acteur_nom`, `acteur_prenom`) VALUES
(1, 'Montand', 'Yves'),
(2, 'Depardieu', 'Gérard'),
(3, 'Auteuil', 'Daniel'),
(4, 'Depardieu', 'Élisabeth'),
(5, 'Béart', 'Emmanuelle'),
(6, 'Girardot', 'Hippolyte'),
(7, 'De Tonquedec', 'Guillaume'),
(8, 'Carré', 'Isabelle'),
(9, 'Bouillette', 'Christian'),
(10, 'Lavernhe', 'Benjamin'),
(11, 'Gadebois', 'Grégory'),
(12, 'Lefèbvre', 'Lorenzo'),
(13, 'Montpetit', 'Sara'),
(14, 'Ricard', 'Sébastien'),
(15, 'Florent', 'Hélène'),
(16, 'Schneider', 'Émile'),
(17, 'Pilon', 'Antoine Olivier'),
(18, 'Naylor', 'Robert'),
(19, 'Dubreuil', 'Martin'),
(20, 'Gilmore', 'Danny'),
(21, 'Arcand', 'Gabriel'),
(22, 'Sicotte', 'Gilbert'),
(23, 'Bibeau', 'Émilie'),
(24, 'Cloutier', 'Fabien'),
(25, 'Papineau', 'François'),
(26, 'Girard', 'Rémy'),
(27, 'Vachon', 'Arnaud'),
(28, 'Huard', 'Xavier'),
(29, 'Dujardin', 'Jean'),
(30, 'Lindinger', 'Natacha'),
(31, 'N\'Diaye', 'Fatou'),
(32, 'Yordanoff', 'Wladimir '),
(33, 'Casta', 'Melodie'),
(34, 'Niney', 'Pierre'),
(35, 'Merad', 'Kad'),
(36, 'Ayala', 'David'),
(37, 'Cissokho', 'Lamine'),
(38, 'Khammes', 'Sofian'),
(39, 'Lottin', 'Pierre'),
(40, 'Nabié', 'Wabinlé'),
(41, 'Medvedev', 'Alexandre'),
(42, 'Benchnafa', 'Saïd'),
(43, 'Hands', 'Marina'),
(44, 'Stocker', 'Laurent'),
(45, 'Seydoux', 'Léa'),
(46, 'Köhler', 'Juliane'),
(47, 'Biolay', 'Benjamin'),
(48, 'Gardin', 'Blanche'),
(49, 'Arioli', 'Emanuele'),
(50, 'Zemmar', 'Jawad');

-- --------------------------------------------------------

--
-- Structure de la table `film`
--

CREATE TABLE `film` (
  `film_id` int(10) UNSIGNED NOT NULL,
  `film_titre` varchar(255) NOT NULL,
  `film_duree` smallint(5) UNSIGNED NOT NULL,
  `film_annee_sortie` smallint(5) UNSIGNED NOT NULL,
  `film_resume` text NOT NULL,
  `film_affiche` varchar(255) NOT NULL,
  `film_bande_annonce` varchar(255) NOT NULL DEFAULT '',
  `film_statut` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `film_genre_id` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `film`
--

INSERT INTO `film` (`film_id`, `film_titre`, `film_duree`, `film_annee_sortie`, `film_resume`, `film_affiche`, `film_bande_annonce`, `film_statut`, `film_genre_id`) VALUES
(1, 'MARIA CHAPDELAINE', 158, 2021, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'medias/affiches/a-1-1634825410.jpg', 'medias/bandes-annonces/ba-1-1634825459.mp4', 1, 4),

(2, 'LE LOUP ET LE LION', 99, 2021, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'medias/affiches/leloupetlelion_affiche.jpeg', 'medias/bandes-annonces/ba-2-1634829119.mp4', 1, 3),

(3, 'Kung Fu Panda', 92, 2008, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'medias/affiches/kung-panda.jpg', '', 1, 2),

(4, 'LE CLUB VINLAND', 125, 2020, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'medias/affiches/a-4-1634836393.jpg', '', 1, 4),

(5, 'LE CORBEAU', 92, 1943, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'medias/affiches/lecorbeau.jpg', '', 1, 5),

(6, 'UN TRIOMPHE', 106, 2019, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'medias/affiches/a-6-1634843715.jpg', '', 1, 3),

(7, 'FRANCE', 133, 2021, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'medias/affiches/a-7-1634847376.jpg', '', 1, 3),

(8, 'JOSEP', 71, 2020, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'medias/affiches/a-8-1634851037.jpg', '', 1, 1),

(9, 'JEAN DE FLORETTE', 120, 1986, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'medias/affiches/a-9-1634854698.jpg', '', 1, 4),

(10, 'MANON DES SOURCES', 120, 1986, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'medias/affiches/a-10-1634858359.jpg', '', 1, 4);

-- --------------------------------------------------------

--
-- Structure de la table `film_acteur`
--

CREATE TABLE `film_acteur` (
  `f_a_film_id` int(10) UNSIGNED NOT NULL,
  `f_a_acteur_id` int(10) UNSIGNED NOT NULL,
  `f_a_priorite` tinyint(3) UNSIGNED NOT NULL DEFAULT 99
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `film_acteur`
--

INSERT INTO `film_acteur` (`f_a_film_id`, `f_a_acteur_id`, `f_a_priorite`) VALUES
(1, 13, 1),
(1, 14, 2),
(1, 15, 3),
(1, 16, 4),
(1, 17, 5),
(1, 18, 6),
(1, 19, 7),
(1, 20, 8),
(1, 21, 9),
(1, 22, 10),
(2, 7, 1),
(2, 8, 2),
(2, 9, 3),
(2, 10, 4),
(2, 11, 5),
(2, 12, 6),
(3, 29, 1),
(3, 30, 2),
(3, 31, 3),
(3, 32, 4),
(3, 33, 5),
(3, 34, 6),
(4, 14, 6),
(4, 23, 1),
(4, 24, 2),
(4, 25, 3),
(4, 26, 4),
(4, 27, 5),
(4, 28, 7),
(6, 35, 1),
(6, 36, 2),
(6, 37, 3),
(6, 38, 4),
(6, 39, 5),
(6, 40, 6),
(6, 41, 7),
(6, 42, 8),
(6, 43, 9),
(6, 44, 10),
(7, 45, 1),
(7, 46, 2),
(7, 47, 3),
(7, 48, 4),
(7, 49, 5),
(7, 50, 6),
(9, 1, 1),
(9, 2, 2),
(9, 3, 3),
(9, 4, 4),
(10, 1, 1),
(10, 3, 3),
(10, 4, 5),
(10, 5, 2),
(10, 6, 4);

-- --------------------------------------------------------

--
-- Structure de la table `film_pays`
--

CREATE TABLE `film_pays` (
  `f_p_film_id` int(10) UNSIGNED NOT NULL,
  `f_p_pays_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `film_pays`
--

INSERT INTO `film_pays` (`f_p_film_id`, `f_p_pays_id`) VALUES
(1, 1),
(2, 4),
(3, 4),
(4, 1),
(5, 4),
(6, 4),
(7, 4),
(7, 6),
(7, 9),
(7, 10),
(8, 3),
(8, 4),
(8, 10),
(9, 4),
(9, 6),
(9, 7),
(9, 8),
(10, 4),
(10, 6),
(10, 7);

-- --------------------------------------------------------

--
-- Structure de la table `film_realisateur`
--

CREATE TABLE `film_realisateur` (
  `f_r_film_id` int(10) UNSIGNED NOT NULL,
  `f_r_realisateur_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `film_realisateur`
--

INSERT INTO `film_realisateur` (`f_r_film_id`, `f_r_realisateur_id`) VALUES
(1, 2),
(2, 4),
(3, 5),
(4, 3),
(5, 9),
(6, 6),
(7, 8),
(8, 7),
(9, 1),
(10, 1);

-- --------------------------------------------------------

--
-- Structure de la table `genre`
--

CREATE TABLE `genre` (
  `genre_id` tinyint(3) UNSIGNED NOT NULL,
  `genre_nom` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `genre`
--

INSERT INTO `genre` (`genre_id`, `genre_nom`) VALUES
(1, 'Animation'),
(2, 'Comédie'),
(3, 'Comédie dramatique'),
(4, 'Drame'),
(5, 'Documentaire');

-- --------------------------------------------------------

--
-- Structure de la table `pays`
--

CREATE TABLE `pays` (
  `pays_id` int(10) UNSIGNED NOT NULL,
  `pays_nom` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `pays`
--

INSERT INTO `pays` (`pays_id`, `pays_nom`) VALUES
(1, 'Canada'),
(2, 'États-Unis'),
(3, 'Espagne'),
(4, 'France'),
(5, 'Grande-Bretagne'),
(6, 'Italie'),
(7, 'Suisse'),
(8, 'Autriche'),
(9, 'Allemagne'),
(10, 'Belgique');

-- --------------------------------------------------------

--
-- Structure de la table `realisateur`
--

CREATE TABLE `realisateur` (
  `realisateur_id` int(10) UNSIGNED NOT NULL,
  `realisateur_nom` varchar(255) NOT NULL,
  `realisateur_prenom` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `realisateur`
--

INSERT INTO `realisateur` (`realisateur_id`, `realisateur_nom`, `realisateur_prenom`) VALUES
(1, 'Berri', 'Claude'),
(2, 'Pilote', 'Sébastien'),
(3, 'Pilon', 'Benoît'),
(4, ' Besnard', 'Éric'),
(5, 'Bedos', 'Nicolas'),
(6, 'Courcol', 'Emmanuel'),
(7, 'Aurel', ''),
(8, 'Dumont', 'Bruno'),
(9, 'Vasseur', 'Flore');

-- --------------------------------------------------------

--
-- Structure de la table `salle`
--

CREATE TABLE `salle` (
  `salle_numero` tinyint(3) UNSIGNED NOT NULL,
  `salle_nb_places` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `salle`
--

INSERT INTO `salle` (`salle_numero`, `salle_nb_places`) VALUES
(1, 200),
(2, 120),
(3, 50);

-- --------------------------------------------------------

--
-- Structure de la table `seance`
--

CREATE TABLE `seance` (
  `seance_film_id` int(10) UNSIGNED NOT NULL,
  `seance_salle_numero` tinyint(3) UNSIGNED NOT NULL,
  `seance_date` date NOT NULL,
  `seance_heure` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `seance`
--

INSERT INTO `seance` (`seance_film_id`, `seance_salle_numero`, `seance_date`, `seance_heure`) VALUES
(2, 1, '2021-10-25', '14:00:00'),
(2, 1, '2021-10-25', '17:00:00'),
(2, 1, '2021-10-26', '07:00:00'),
(2, 1, '2021-10-26', '10:00:00'),
(2, 1, '2021-10-26', '14:00:00'),
(2, 1, '2021-10-26', '17:00:00'),
(2, 1, '2021-10-26', '20:00:00'),
(2, 1, '2021-10-26', '23:00:00'),
(2, 1, '2021-10-31', '15:00:00'),
(3, 3, '2021-11-04', '18:00:00'),
(3, 3, '2021-11-04', '21:00:00'),
(3, 3, '2021-11-05', '16:00:00'),
(5, 2, '2021-10-25', '14:00:00'),
(5, 2, '2021-10-26', '14:00:00');

-- --------------------------------------------------------

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `acteur`
--
ALTER TABLE `acteur`
  ADD PRIMARY KEY (`acteur_id`);

--
-- Index pour la table `film`
--
ALTER TABLE `film`
  ADD PRIMARY KEY (`film_id`),
  ADD KEY `fk_film_genre_idx` (`film_genre_id`);

--
-- Index pour la table `film_acteur`
--
ALTER TABLE `film_acteur`
  ADD PRIMARY KEY (`f_a_film_id`,`f_a_acteur_id`),
  ADD KEY `fk_f_a_acteur_idx` (`f_a_acteur_id`),
  ADD KEY `fk_f_a_film_idx` (`f_a_film_id`);

--
-- Index pour la table `film_pays`
--
ALTER TABLE `film_pays`
  ADD PRIMARY KEY (`f_p_film_id`,`f_p_pays_id`),
  ADD KEY `fk_f_p_pays_idx` (`f_p_pays_id`),
  ADD KEY `fk_f_p_film_idx` (`f_p_film_id`);

--
-- Index pour la table `film_realisateur`
--
ALTER TABLE `film_realisateur`
  ADD PRIMARY KEY (`f_r_film_id`,`f_r_realisateur_id`),
  ADD KEY `fk_f_r_realisateur_idx` (`f_r_realisateur_id`),
  ADD KEY `fk_f_r_film_idx` (`f_r_film_id`);

--
-- Index pour la table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`genre_id`);

--
-- Index pour la table `pays`
--
ALTER TABLE `pays`
  ADD PRIMARY KEY (`pays_id`);

--
-- Index pour la table `realisateur`
--
ALTER TABLE `realisateur`
  ADD PRIMARY KEY (`realisateur_id`);

--
-- Index pour la table `salle`
--
ALTER TABLE `salle`
  ADD PRIMARY KEY (`salle_numero`);

--
-- Index pour la table `seance`
--
ALTER TABLE `seance`
  ADD PRIMARY KEY (`seance_film_id`,`seance_salle_numero`,`seance_date`,`seance_heure`),
  ADD KEY `fk_seance_salle_idx` (`seance_salle_numero`),
  ADD KEY `fk_seance_film_idx` (`seance_film_id`);

-- --------------------------------------------------------

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `acteur`
--
ALTER TABLE `acteur`
  MODIFY `acteur_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT pour la table `film`
--
ALTER TABLE `film`
  MODIFY `film_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `pays`
--
ALTER TABLE `pays`
  MODIFY `pays_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `realisateur`
--
ALTER TABLE `realisateur`
  MODIFY `realisateur_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

-- --------------------------------------------------------

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `film`
--
ALTER TABLE `film`
  ADD CONSTRAINT `fk_film_genre` FOREIGN KEY (`film_genre_id`) REFERENCES `genre` (`genre_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `film_acteur`
--
ALTER TABLE `film_acteur`
  ADD CONSTRAINT `fk_f_a_acteur` FOREIGN KEY (`f_a_acteur_id`) REFERENCES `acteur` (`acteur_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_f_a_film` FOREIGN KEY (`f_a_film_id`) REFERENCES `film` (`film_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `film_pays`
--
ALTER TABLE `film_pays`
  ADD CONSTRAINT `fk_f_p_film` FOREIGN KEY (`f_p_film_id`) REFERENCES `film` (`film_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_f_p_pays` FOREIGN KEY (`f_p_pays_id`) REFERENCES `pays` (`pays_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `film_realisateur`
--
ALTER TABLE `film_realisateur`
  ADD CONSTRAINT `fk_f_r_film` FOREIGN KEY (`f_r_film_id`) REFERENCES `film` (`film_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_f_r_realisateur` FOREIGN KEY (`f_r_realisateur_id`) REFERENCES `realisateur` (`realisateur_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `seance`
--
ALTER TABLE `seance`
  ADD CONSTRAINT `fk_seance_film` FOREIGN KEY (`seance_film_id`) REFERENCES `film` (`film_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_seance_salle` FOREIGN KEY (`seance_salle_numero`) REFERENCES `salle` (`salle_numero`) ON DELETE NO ACTION ON UPDATE NO ACTION;