SET search_path TO Planificateur_repas;

BEGIN;

-- Menage: id (INT, PK), adr_rue (VARCHAR(100), adr_num (VARCHAR(20)), adr_npa (VARCHAR(20)),
--         adr_ville (VARCHAR(100))
INSERT INTO Menage VALUES (1, 'Evergreen Terrace', '742', '65619', 'Springfield, Mo');
INSERT INTO Menage VALUES (2, 'Evergreen Terrace', '740', '65619', 'Springfield, Mo');

-- Utilisateur: email (VARCHAR(100), PK), prenom (VARCHAR(100)), nom (VARCHAR(100)), genre (CHAR(1): H, F),
--              dob (DATE), poids (FLOAT), taille (FLOAT), mot_de_passe (VARCHAR(80))
INSERT INTO Utilisateur VALUES ('admin@planificateur_repas.ch', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO Utilisateur VALUES ('homer@simpson.com', 'Homer', 'Simpson', 'H', '1965-05-12', 109, 175, '$2y$10$kwF7ZeawluQcvhM3N0PydeRFG.eLaK/C5yEaCuL3A9uzCgj1ORs2O');
INSERT INTO Utilisateur VALUES ('marge@simpson.com', 'Marge', 'Simpson', 'F', '1968-03-19', 63, 175, '$2y$10$vld/U/3LFXhjhAfOJmwYbu7T2dBgcMVRNin0JDeFla.p9.ao8NWyq');
INSERT INTO Utilisateur VALUES ('bart@simpson.com', 'Bart', 'Simpson', 'H', '2009-04-01', 51, 163, '$2y$10$9kflkK4ipooc.Cw223T5kOMq/raAAB8OvetN84fiX2IOdMkMIx4FS');
INSERT INTO Utilisateur VALUES ('lisa@simpson.com', 'Lisa', 'Simpson', 'F', '2011-05-09', 42, 152, '$2y$10$L3v9B4jiVMf1tXTN7NirJeB8eh6irjm2jSQI.BW.a.SrZjeXKuQJO');
INSERT INTO Utilisateur VALUES ('maggie@simpson.com', 'Maggie', 'Simpson', 'F', '2016-01-14', 22, 121, '$2y$10$HKxaqGXD34w3i0UZmnsKfuLLwlCqikh1YO8gBWVaci1SjPjd3xTrS');
INSERT INTO Utilisateur VALUES ('ned@flanders.com', 'Ned', 'Flanders', 'H', '1965-10-12', 73, 175, '$2y$10$QYCJVagH3JWhQw4W5kid3eFKTYQD13KOwDi7Eq6sNrtXJwxopcEI6');
INSERT INTO Utilisateur VALUES ('maude@flanders.com', 'Maude', 'Flanders', 'F', '1968-12-16', 55, 165, '$2y$10$sn2isvZgRMcG3hsjUs70lOcWW2SPcXZ0XGbutHaRxd18GZEN.SDRa');
INSERT INTO Utilisateur VALUES ('rod@flanders.com', 'Rod', 'Flanders', 'H', '2013-01-01', 31, 138, '$2y$10$HLE3134pn93iWVDLrhV3R.3/N6OiGBytHHe3S5R6JVAqclqrdVxQK');
INSERT INTO Utilisateur VALUES ('todd@flanders.com', 'Todd', 'Flanders', 'H', '2014-04-07', 28, 133, '$2y$10$rIISBA3Kfc1aGhZzOxWIP.uCSgx8yf03pM3a5SH5beB85TVD.LrJ2');

-- Recette: id (INT, PK), nom (VARCHAR(100)), operations (VARCHAR(2000)), difficulte (INT), temps (TIME),
--          calories (FLOAT), score (INT), visibilite (INT), utilisateur (VARCHAR(100), FK)
DO $$
DECLARE
    op      text;
BEGIN
    op := '01. Dans une grande poêle, faites chauffer un peu d''huile d''olive à feu moyen. Ajoutez l''oignon finement haché et l''ail émincé, puis faites-les revenir jusqu''à ce qu''ils soient translucides.
02. Ajoutez la carotte finement hâchée. Faites-les cuire pendant quelques minutes jusqu''à ce qu''ils soient tendres.
03. Ajoutez la viande de boeuf hachée à la poêle et faites-la brunir. Assurez-vous de bien casser la viande pour qu''elle soit uniformément cuite.
04. Une fois que la viande est bien cuite, ajoutez les tomates fraîches moyennes, pelées et concassées. Si vous utilisez des tomates en conserve, ajoutez-les à ce stade.
05. Ajoutez du vin rouge (optionnel) et du concentré de tomates. Mélangez bien.
06. Ajoutez du laurier, de l''origan séché, du thym séché, du sel et du poivre.
07. Réduisez le feu, couvrez la poêle et laissez mijoter pendant au moins 30 à 45 minutes, en remuant de temps en temps.
08. Goûtez et ajustez l''assaisonnement selon vos préférences.
09. Servez la sauce bolognaise sur des pâtes cuites al dente. Vous pouvez également la servir avec du parmesan râpé.';
    INSERT INTO Recette VALUES (1, 'Sauce bolognese maison', op, 3, '00:45:00', 400, 'C', 'public', 'admin@planificateur_repas.ch');
END$$;

DO $$
DECLARE
    op      text;
BEGIN
    op := '01. Faites chauffer une grande casserole d''eau à feu vif. Ajoutez du sel à l''eau en ébullition.
02. Lorsque l''eau atteint l''ébullition, ajoutez les spaghetti dans la casserole. Remuez-les immédiatement pour éviter qu''ils ne collent ensemble.
03. Faites cuire les spaghetti selon les instructions de l''emballage pour qu''ils soient al dente.
04. Une fois cuits, égouttez les spaghetti dans une passoire.
05. Servez immédiatement les spaghetti chauds avec la sauce de votre choix.';
    INSERT INTO Recette VALUES (2, 'Spaghetti', op, 2, '00:15:00', 200, 'A', 'public', 'admin@planificateur_repas.ch');
END$$;

DO $$
DECLARE
    op      text;
BEGIN
    op := '01. Faites chauffer une poêle à feu moyen. Ajoutez l''huile d''olive à la poêle, puis faites revenir les dés de pancetta jusqu''à ce qu''ils soient dorés et croustillants. Si vous préférez une version moins grasse, vous pouvez omettre l''huile d''olive et simplement faire sauter la pancetta.
02. Ajoutez l''ail émincé à la pancetta cuite dans la poêle, puis retirez la poêle du feu.
03. Dans un bol, battez l''oeuf et mélangez-y le parmesan râpé. Assaisonnez généreusement de poivre noir moulu.
04. Versez rapidement le mélange d''oeuf et de parmesan sur la pancetta dans la poêle et mélangez bien pour que la chaleur résiduelle cuise l''oeuf et crée une sauce crémeuse.
05. Si la sauce semble trop épaisse, vous pouvez ajouter un peu d''eau chaude pour l''assouplir.
06. Servez la sauce carbonara chaude, garnie de persil frais haché et de poivre noir moulu.';
    INSERT INTO Recette VALUES (3, 'Sauce carbonara', op, 4, '00:20:00', 400, 'C', 'public', 'admin@planificateur_repas.ch');
END$$;

-- Permission: email (VARCHAR(100), PK, FK), admin (BOOL), menage (BOOL), recette (BOOL), stock (BOOL),
--             ingredient (BOOL)
INSERT INTO Permission VALUES ('admin@planificateur_repas.ch', true, true, true, true, true);

INSERT INTO Permission VALUES ('homer@simpson.com', false, false, false, true, false);
INSERT INTO Permission VALUES ('marge@simpson.com', false, true, true, true, true);
INSERT INTO Permission VALUES ('bart@simpson.com', false, false, false, true, false);
INSERT INTO Permission VALUES ('lisa@simpson.com', false, false, false, true, false);
INSERT INTO Permission VALUES ('maggie@simpson.com', false, false, false, false, false);

INSERT INTO Permission VALUES ('ned@flanders.com', false, true, true, true, true);
INSERT INTO Permission VALUES ('maude@flanders.com', false, false, false, true, false);
INSERT INTO Permission VALUES ('rod@flanders.com', false, false, false, false, false);
INSERT INTO Permission VALUES ('todd@flanders.com', false, false, false, false, false);

-- Catégorie (d'ingrédient): nom (VARCHAR(100), PK)
INSERT INTO Categorie VALUES ('Fruit');
INSERT INTO Categorie VALUES ('Légume');
INSERT INTO Categorie VALUES ('Viande');
INSERT INTO Categorie VALUES ('Charcuterie');
INSERT INTO Categorie VALUES ('Féculent');
INSERT INTO Categorie VALUES ('Snack');
INSERT INTO Categorie VALUES ('Plat');
INSERT INTO Categorie VALUES ('Boisson sans alcool');
INSERT INTO Categorie VALUES ('Boisson alcoolisée');
INSERT INTO Categorie VALUES ('Noix');
INSERT INTO Categorie VALUES ('Huile');
INSERT INTO Categorie VALUES ('Aromate');
INSERT INTO Categorie VALUES ('Condiment');
INSERT INTO Categorie VALUES ('Fromage');
INSERT INTO Categorie VALUES ('Céréale');
INSERT INTO Categorie VALUES ('Sucrerie');
INSERT INTO Categorie VALUES ('Produit laitier');
INSERT INTO Categorie VALUES ('Pain');
INSERT INTO Categorie VALUES ('Oeuf');
INSERT INTO Categorie VALUES ('Divers');
INSERT INTO Categorie VALUES ('');

-- Planificateur: id (INT, PK), menage (INT, FK)
INSERT INTO Planificateur VALUES (1, 1);
INSERT INTO Planificateur VALUES (2, 2);

-- Utilisateur_menage: menage (INT, FK, PK), utilisateur (VARCHAR(100), FK, PK)
INSERT INTO utilisateur_menage VALUES (1, 'homer@simpson.com');
INSERT INTO utilisateur_menage VALUES (1, 'marge@simpson.com');
INSERT INTO utilisateur_menage VALUES (1, 'bart@simpson.com');
INSERT INTO utilisateur_menage VALUES (1, 'lisa@simpson.com');
INSERT INTO utilisateur_menage VALUES (1, 'maggie@simpson.com');

INSERT INTO utilisateur_menage VALUES (2, 'ned@flanders.com');
INSERT INTO utilisateur_menage VALUES (2, 'maude@flanders.com');
INSERT INTO utilisateur_menage VALUES (2, 'rod@flanders.com');
INSERT INTO utilisateur_menage VALUES (2, 'todd@flanders.com');

-- Ingredient: id (INT, PK), nom (VARCHAR(100)), type (VARCHAR(100)), description VARCHAR(100),
--             unite (VARCHAR(20)), categorie (VARCHAR(100), FK), utilisateur (VARCHAR(100), FK)
INSERT INTO Ingredient VALUES (1, 'Carotte', 'Orange', NULL, 'unite', 'Légume', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (2, 'Tomate', 'San Marzano', NULL, 'unite', 'Fruit', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (3, 'Viande hâchée', 'Boeuf', NULL, 'g', 'Viande', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (4, 'Sauce tomate', 'Barilla', NULL, 'ml', 'Plat', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (5, 'Sauce bolognese', 'Barilla', NULL, 'ml', 'Plat', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (6, 'Pâtes', 'Spaghetti', NULL, 'g', 'Féculent', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (7, 'Jambon', NULL, NULL, 'g', 'Charcuterie', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (8, 'Biere', NULL, NULL, 'ml', 'Charcuterie', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (9, 'Huile', 'Olive', NULL, 'ml', 'Huile', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (10, 'Oignon', 'Jaune', NULL, 'unite', 'Légume', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (11, 'Ail', 'Blanc', NULL, 'gousse', 'Légume', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (12, 'Tomate', 'Conserve', NULL,'g', 'Fruit', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (13, 'Vin', 'Rouge', NULL, 'ml', 'Boisson alcoolisée', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (14, 'Tomate', 'Concentré', NULL, 'ml', 'Fruit', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (15, 'Laurier', 'Noble', NULL, 'feuille', 'Aromate', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (16, 'Origan', 'Commun-Séché', NULL, 'cc', 'Aromate', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (17, 'Thym', 'Commun-Séché', NULL, 'cc', 'Aromate', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (18, 'Sel', 'De table', NULL, 'g', 'Condiment', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (19, 'Poivre', 'Noir', NULL, 'g', 'Condiment', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (20, 'Parmesan', 'Parmigiano-Reggiano', NULL, 'g', 'Fromage', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (21, 'Eau', NULL, NULL, 'ml', 'Boisson sans alcool', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (22, 'Pancetta', 'Cru', NULL, 'g', 'Charcuterie', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (23, 'Lard', 'Cru', NULL, 'g', 'Charcuterie', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (24, 'Oeuf', 'Cru', NULL, 'unite', 'Oeuf', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (25, 'Persil', 'Italien', NULL, 'cs', 'Aromate', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (26, 'Viande hâchée', 'Veau', NULL, 'g', 'Viande', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (27, 'Viande hâchée', '50% boeuf, 50% porc', NULL, 'g', 'Viande', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (28, 'Pâtes', 'Penne', NULL, 'g', 'Féculent', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (29, 'Pâtes', 'Rigatoni', NULL, 'g', 'Féculent', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (30, 'Pâtes', 'Tagliatelle', NULL, 'g', 'Féculent', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (31, 'Crème', 'Entière', NULL, 'ml', 'Produit laitier', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (0, NULL, NULL, NULL, NULL, '', 'admin@planificateur_repas.ch');

-- Allergie: utilisateur (VARCHAR(100), FK, PK), ingredient (INT, FK, PK)
INSERT INTO allergie VALUES ('homer@simpson.com', 1); -- plus généralement Catégories : Fruit, Légume
INSERT INTO allergie VALUES ('homer@simpson.com', 2);

-- Aime_ingredient: utilisateur (VARCHAR(100), FK, PK), ingredient (INT, FK, PK)
INSERT INTO aime_ingredient VALUES ('homer@simpson.com', 8);
INSERT INTO aime_ingredient VALUES ('bart@simpson.com', 6);
INSERT INTO aime_ingredient VALUES ('lisa@simpson.com', 6);
INSERT INTO aime_ingredient VALUES ('maggie@simpson.com', 1);

COMMIT;