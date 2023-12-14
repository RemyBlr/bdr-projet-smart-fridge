SET search_path TO Planificateur_repas;

-- Menage: id (INT, PK), adr_rue (VARCHAR(100), adr_num (VARCHAR(20)), adr_npa (VARCHAR(20)),
--         adr_ville (VARCHAR(100))
INSERT INTO Menage VALUES (1, 'Evergreen Terrace', '742', '65619', 'Springfield, Mo');
INSERT INTO Menage VALUES (2, 'Evergreen Terrace', '740', '65619', 'Springfield, Mo');

-- Utilisateur: email (VARCHAR(100), PK), prenom (VARCHAR(100)), nom (VARCHAR(100)), genre (CHAR(1): H, F),
--              dob (DATE), poids (FLOAT), taille (FLOAT), mot_de_passe (VARCHAR(80))
INSERT INTO Utilisateur VALUES ('admin@planificateur_repas.ch', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO Utilisateur VALUES ('homer@simpson.com', 'Homer', 'Simpson', 'H', '1965-05-12', 109, 175, 'homer');
INSERT INTO Utilisateur VALUES ('marge@simpson.com', 'Marge', 'Simpson', 'F', '1968-03-19', 63, 175, 'marge');
INSERT INTO Utilisateur VALUES ('bart@simpson.com', 'Bart', 'Simpson', 'H', '2009-04-01', 51, 163, 'bart');
INSERT INTO Utilisateur VALUES ('lisa@simpson.com', 'Lisa', 'Simpson', 'F', '2011-05-09', 42, 152, 'lisa');
INSERT INTO Utilisateur VALUES ('maggie@simpson.com', 'Maggie', 'Simpson', 'F', '2016-01-14', 22, 121, 'maggie');

INSERT INTO Utilisateur VALUES ('ned@flanders.com', 'Ned', 'Flanders', 'H', '1965-10-12', 73, 175, 'ned');
INSERT INTO Utilisateur VALUES ('maude@flanders.com', 'Maude', 'Flanders', 'F', '1968-12-16', 55, 165, 'maude');
INSERT INTO Utilisateur VALUES ('rod@flanders.com', 'Rod', 'Flanders', 'H', '2013-01-01', 31, 138, 'rod');
INSERT INTO Utilisateur VALUES ('todd@flanders.com', 'Todd', 'Flanders', 'H', '2014-04-07', 28, 133, 'todd');

-- Recette: id (INT, PK), nom (VARCHAR(100)), operations (VARCHAR(500)), difficulte (INT), temps (TIME),
--          calories (FLOAT), score (INT), visibilite (INT), utilisateur (VARCHAR(100), FK)
DO $$
DECLARE
    email   text;
    op      text;
BEGIN
    email := 'admin@planificateur_repas.ch';
    op := '01. Dans une grande poêle, faites chauffer un peu d''huile d''olive à feu moyen. Ajoutez 1/4 oignon finement haché et 1 gousse d''ail émincée, puis faites-les revenir jusqu''à ce qu''ils soient translucides.
           02. Ajoutez 1 petite carotte finement hâchée. Faites-les cuire pendant quelques minutes jusqu''à ce qu''ils soient tendres.
           03. Ajoutez 100 g de viande de boeuf hachée à la poêle et faites-la brunir. Assurez-vous de bien casser la viande pour qu''elle soit uniformément cuite.
           04. Une fois que la viande est bien cuite, ajoutez 2 tomates fraîches moyennes, pelées et concassées. Si vous utilisez des tomates en conserve, ajoutez-les à ce stade.
           05. Ajoutez 50 ml de vin rouge (optionnel) et du concentré de tomates. Mélangez bien.
           06. Ajoutez 1/4 de feuille de laurier, 1/4 de cuillère à café d''origan séché, 1/4 de cuillère à café de thym séché, du sel et du poivre.
           07. Réduisez le feu, couvrez la poêle et laissez mijoter pendant au moins 30 à 45 minutes, en remuant de temps en temps.
           08. Goûtez et ajustez l''assaisonnement selon vos préférences.
           09. Servez la sauce bolognaise sur des pâtes cuites al dente. Vous pouvez également la servir avec du parmesan râpé.';
    INSERT INTO Recette VALUES (1, 'Sauce bolognese maison', op, 3, '00:45:00', 400, 'C', 'public', email);
END$$;

/*
    Cuisson des Spaghettis :
        Faites bouillir de l'eau dans une grande casserole.
        Ajoutez une pincée de sel dans l'eau bouillante.
        Ajoutez les spaghettis dans l'eau bouillante et faites-les cuire selon les instructions sur l'emballage jusqu'à ce qu'ils soient al dente.

    Égouttage des Spaghettis :
        Une fois les spaghettis cuits, égouttez-les dans une passoire.

    Assemblage :
        Dans une assiette, servez une portion de spaghettis.
        Versez une généreuse quantité de sauce bolognaise chaude sur les spaghettis.

    Garniture :
        Si vous le souhaitez, saupoudrez de parmesan râpé sur le dessus.
        Ajoutez des feuilles de basilic frais ou du persil haché pour garnir.

    Servez immédiatement :
        Servez les spaghettis bolognaise chauds immédiatement.
*/
DO $$
DECLARE
    email   text;
    op      text;
BEGIN
    email := 'admin@planificateur_repas.ch';
    op := '';
    INSERT INTO Recette VALUES (2, 'Spaghetti', op, 3, '00:45:00', 400, 'C', 'public', email);
END$$;

DO $$
DECLARE
    email   text;
    op      text;
BEGIN
    email := 'marge@simpson.com';
    op := '1. peser trop de spaghettis; 2. cuire de l''eau; 3. cuire les spaghettis jusqu''a bouillie; 4. ajouter la sauce bolognese toute prête; 5. C''est prêt!';
    INSERT INTO Recette VALUES (3, 'Spaghettis bolognese à la Homer Simpson', op, 1, '00:45:00', 450.5, 5, 1, email);
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
INSERT INTO Categorie VALUES ('Légume');
INSERT INTO Categorie VALUES ('Fruit');
INSERT INTO Categorie VALUES ('Viande');
INSERT INTO Categorie VALUES ('Charcuterie');
INSERT INTO Categorie VALUES ('Feculent');
INSERT INTO Categorie VALUES ('Plat cuisiné');
INSERT INTO Categorie VALUES ('Plat frais');
INSERT INTO Categorie VALUES ('Reste');
INSERT INTO Categorie VALUES ('Boisson');
INSERT INTO Categorie VALUES ('Sauce');
INSERT INTO Categorie VALUES ('Huile');
INSERT INTO Categorie VALUES ('Vin');
INSERT INTO Categorie VALUES ('Aromate');
INSERT INTO Categorie VALUES ('Condiment');
INSERT INTO Categorie VALUES ('Fromage');

-- Ingredient: id (INT, PK), nom (VARCHAR(100)), type (VARCHAR(100)), description VARCHAR(100),
--             unite (VARCHAR(20)), categorie (VARCHAR(100), FK), utilisateur (VARCHAR(100), FK)
CREATE SEQUENCE count START 0;
INSERT INTO Ingredient VALUES (nextval('count'), 'Carotte', 'Orange', NULL, 'Légume', 'unité', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Tomate', 'San Marzano', NULL, 'Fruit', 'unité', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Boeuf', 'Viande rouge', NULL, 'Viande', 'grammes', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Sauce tomate', 'Barilla', 'Sauce', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Sauce bolognese', 'Barilla', 'Sauce', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Spaghetti', 'Pâtes', 'Feculent', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Jambon', NULL, 'Charcuterie', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Biere', NULL, 'Charcuterie', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Huile', 'Olive', 'Huile', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Oignon', 'Jaune', 'Légume', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Ail', 'Blanc', 'Légume', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Tomate', 'Conserve', 'Fruit', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Vin', 'Rouge', 'Vin', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Tomate', 'Concentré', 'Fruit', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Laurier', 'Noble', 'Aromate', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Origan', 'Commun-Séché', 'Aromate', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Thym', 'Commun-Séché', 'Aromate', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Sel', 'De table', 'Condiment', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Poivre', 'Noir', 'Condiment', 'admin@planificateur_repas.ch');
INSERT INTO Ingredient VALUES (nextval('count'), 'Parmesan', 'Parmigiano-Reggiano', 'Fromage', 'admin@planificateur_repas.ch');

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

-- Allergie: utilisateur (VARCHAR(100), FK, PK), ingredient (INT, FK, PK)
INSERT INTO allergie VALUES ('homer@simpson.com', 1); -- plus généralement Catégories : Fruit, Légume
INSERT INTO allergie VALUES ('homer@simpson.com', 2);

-- Aime_ingredient: utilisateur (VARCHAR(100), FK, PK), ingredient (INT, FK, PK)
INSERT INTO aime_ingredient VALUES ('homer@simpson.com', 8);
INSERT INTO aime_ingredient VALUES ('bart@simpson.com', 6);
INSERT INTO aime_ingredient VALUES ('lisa@simpson.com', 6);
INSERT INTO aime_ingredient VALUES ('maggie@simpson.com', 1);