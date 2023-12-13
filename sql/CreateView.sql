CREATE OR REPLACE VIEW vue_ingredient_substitue AS
SELECT
    IP.ingredientPrincipal,
    IP.recette AS recette_id,
    IP.nombre AS quantite,
    ISU.ingredient AS substitut_id,
    I.nom AS ingredient_nom,
    I.description AS ingredient_description
FROM Ingredient_principal AS IP
INNER JOIN Ingredient_substitue  AS ISU
    ON IP.ingredientPrincipal = ISU.ingredientPrincipal
INNER JOIN Ingredient AS I 
    ON ISU.ingredient = I.id;


CREATE OR REPLACE VIEW vue_ingredient_aime_par_utilisateur AS
SELECT
    AI.utilisateur AS user_email,
    I.nom AS ingredient_nom,
    I.description AS ingredient_description
FROM Aime_ingredient AS AI
INNER JOIN Ingredient AS I
    ON AI.ingredient = I.id;


CREATE OR REPLACE VIEW vue_ingredient_par_recette AS
SELECT
    R.id AS recipe_id,
    R.nom AS recipe_nom,
    R.operations,
    I.id AS ingredient_id,
    I.nom AS ingredient_nom,
    I.description AS ingredient_description
FROM Recette AS R
INNER JOIN Ingredient_principal AS IP
    ON R.id = IP.recette
INNER JOIN Ingredient AS I
    ON IP.ingredient = I.id;


CREATE OR REPLACE VIEW vue_recette_aimee_par_utilisateur AS
SELECT
    AR.utilisateur AS user_email,
    R.id AS recipe_id,
    R.nom AS recipe_nom,
    R.operations
FROM Aime_recette AS AR
INNER JOIN Recette AS R
    ON AR.recette = R.id;