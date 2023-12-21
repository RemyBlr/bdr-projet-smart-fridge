SET search_path TO Planificateur_repas;

CREATE OR REPLACE VIEW vue_ingredient_substitue AS
SELECT
    IP.ingredientPrincipal,
    IP.recette AS recette_id,
    IP.nombreIngredient,
    ISU.ingredient_substitue AS substitut_id,
    I.nom AS ingredient_nom,
    I.description
FROM Ingredient_principal AS IP
INNER JOIN Ingredient_substitue AS ISU
    ON IP.ingredientPrincipal = ISU.ingredient_principal
INNER JOIN Ingredient AS I 
    ON ISU.ingredient_substitue = I.id;


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

CREATE OR REPLACE VIEW vue_profile_utilisateur AS
SELECT
    U.email AS user_email,
    U.prenom,
    U.nom,
    U.genre,
    U.dob,
    U.poids,
    U.taille,
    P.admin
FROM Utilisateur AS U
LEFT JOIN Permission AS P ON U.email = P.email;

CREATE OR REPLACE VIEW vue_menage AS
SELECT
    UM.utilisateur AS user_email,
    M.id AS household_id,
    M.adr_rue,
    M.adr_num,
    M.adr_npa,
    M.adr_ville
FROM Utilisateur_menage AS UM
INNER JOIN Menage AS M ON UM.menage = M.id;
