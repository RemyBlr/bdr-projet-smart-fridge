SET search_path TO Planificateur_repas;

-- Stock: nombre (FLOAT), expiration (DATE), etat (VARCHAR(20)),
--        planificateur (INT, FK, PK), ingredient (INT, FK, PK)
INSERT INTO Stock VALUES (300, '2025-12-31', 'Frais', 1, 1);

-- Commande: nombre (FLOAT), etat (VARCHAR(20)), planificateur (INT, FK, PK), ingredient (INT, FK, PK)


-- Aime_recette: utilisateur (VARCHAR(100), FK, PK), recette (INT, FK, PK)


-- Utilise_recette: id (INT, PK), date (DATE), menage (INT, FK), recette (INT, FK)

-- Utilise_ingredient: utilise_recette (INT, FK, PK), ingredient (INT, FK, PK)

-- Ingredient_principal: id (INT, PK), recette (INT, FK), ingredient (INT, FK), nombre (FLOAT)
CREATE SEQUENCE count START 0;
DO $$
DECLARE id_ingredient INTEGER;
BEGIN
    SELECT id INTO id_ingredient FROM Ingredient WHERE nom = 'Oignon';
    INSERT INTO ingredient_principal VALUES (nextval('count'), 1, id_ingredient, 1/4);
END $$;
DO $$
DECLARE id_ingredient INTEGER;
BEGIN
    SELECT id INTO id_ingredient FROM Ingredient WHERE nom = 'Ail';
    INSERT INTO ingredient_principal VALUES (nextval('count'), 1, id_ingredient, 1);
END $$;
DO $$
DECLARE id_ingredient INTEGER;
BEGIN
    SELECT id INTO id_ingredient FROM Ingredient WHERE nom = 'Carotte';
    INSERT INTO ingredient_principal VALUES (nextval('count'), 1, id_ingredient, 1);
END $$;
DO $$
DECLARE id_ingredient INTEGER;
BEGIN
    SELECT id INTO id_ingredient FROM Ingredient WHERE nom = 'Boeuf';
    INSERT INTO ingredient_principal VALUES (nextval('count'), 1, id_ingredient, 100);
END $$;
DO $$
DECLARE id_ingredient INTEGER;
BEGIN
    SELECT id INTO id_ingredient FROM Ingredient WHERE nom = 'Tomate';
    INSERT INTO ingredient_principal VALUES (nextval('count'), 1, id_ingredient, 2);
END $$;
DO $$
DECLARE id_ingredient INTEGER;
BEGIN
    SELECT id INTO id_ingredient FROM Ingredient WHERE nom = 'Vin rouge' AND description = 'Rouge';
    INSERT INTO ingredient_principal VALUES (nextval('count'), 1, id_ingredient, 50);
END $$;
DO $$
DECLARE id_ingredient INTEGER;
BEGIN
    SELECT id INTO id_ingredient FROM Ingredient WHERE nom = 'Tomate' AND description = 'Concentré';
    INSERT INTO ingredient_principal VALUES (nextval('count'), 1, id_ingredient, 100);
END $$;
DO $$
DECLARE id_ingredient INTEGER;
BEGIN
    SELECT id INTO id_ingredient FROM Ingredient WHERE nom = 'Laurier';
    INSERT INTO ingredient_principal VALUES (nextval('count'), 1, id_ingredient, 1/4);
END $$;
DO $$
DECLARE id_ingredient INTEGER;
BEGIN
    SELECT id INTO id_ingredient FROM Ingredient WHERE nom = 'Origan';
    INSERT INTO ingredient_principal VALUES (nextval('count'), 1, id_ingredient, 1/4);
END $$;
DO $$
DECLARE id_ingredient INTEGER;
BEGIN
    SELECT id INTO id_ingredient FROM Ingredient WHERE nom = 'Thym';
    INSERT INTO ingredient_principal VALUES (nextval('count'), 1, id_ingredient, 1/4);
END $$;
DO $$
DECLARE id_ingredient INTEGER;
BEGIN
    SELECT id INTO id_ingredient FROM Ingredient WHERE nom = 'Sel';
    INSERT INTO ingredient_principal VALUES (nextval('count'), 1, id_ingredient, NULL);
END $$;
DO $$
DECLARE id_ingredient INTEGER;
BEGIN
    SELECT id INTO id_ingredient FROM Ingredient WHERE nom = 'Poivre';
    INSERT INTO ingredient_principal VALUES (nextval('count'), 1, id_ingredient, NULL);
END $$;
DO $$
DECLARE id_ingredient INTEGER;
BEGIN
    SELECT id INTO id_ingredient FROM Ingredient WHERE nom = 'Parmesan';
    INSERT INTO ingredient_principal VALUES (nextval('count'), 1, id_ingredient, NULL);
END $$;

-- Ingredient_substitue: ingredient_principal (INT, FK, PK), ingredient (INT, FK, PK)



