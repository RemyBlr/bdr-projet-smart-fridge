SET search_path TO Planificateur_repas;

-- Requête 1 : Lister les ingrédients liés à une recette
DROP VIEW IF EXISTS Ingredients_recette;

CREATE OR REPLACE VIEW Ingredients_recette AS
    SELECT r.id r_id,
           r.nom r_nom,
           i.id i_id,
           i.nom i_nom,
           i.type i_type,
              ip.ingredientprincipal ip_id
    FROM Recette r
    INNER JOIN ingredient_principal ip
        ON r.id = ip.recette
    INNER JOIN ingredient i
        ON ip.ingredient = i.id;


-- Recherche des ingrédients liés à une recette : Exemple avec la recette "Sauce bolognese maison"
SELECT  i_nom, i_type
FROM Ingredients_recette
WHERE r_nom = 'Sauce bolognese maison';

select *
from Ingredients_recette;

-- Requête 2 : Trouver pour un ingrédient principal, les ingrédients sustituables
DROP VIEW IF EXISTS Ingredients_sustituables;

CREATE OR REPLACE VIEW Ingredients_sustituables AS
    SELECT  ir.r_nom,
            ir.i_nom ingredient_principal_nom,
            ir.i_type ingredient_principal_type,
            i.nom ingredient_substituable_nom,
            i.type ingredient_substituable_type

    FROM ingredients_recette ir
    INNER JOIN ingredient_substitue isu
        ON ir.ip_id= isu.ingredient_principal
    INNER JOIN ingredient i
        ON isu.ingredient_substitue = i.id;

SELECT *
FROM Ingredients_sustituables;