-- lors de l'utilisation d'ingrédients
CREATE OR REPLACE FUNCTION maj_quantite_stock()
    RETURNS TRIGGER 
    LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE Stock
    SET nombre = nombre - NEW.quantite
    WHERE ingredient = NEW.ingredient;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_maj_quantite_stock
AFTER INSERT ON Utilise_ingredient
FOR EACH ROW
EXECUTE FUNCTION maj_quantite_stock();


-- lors d'un ajoutd'ingrédient dans la BD
CREATE OR REPLACE FUNCTION maj_allergies_utilisateur()
    RETURNS TRIGGER 
    LANGUAGE plpgsql
    AS 
$$
BEGIN
    INSERT INTO Allergie (utilisateur, ingredient)
    VALUES (NEW.utilisateur, NEW.id);

    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_maj_allergies_utilisateur
AFTER INSERT ON Ingredient
FOR EACH ROW
WHEN NEW.utilisateur IS NOT NULL
EXECUTE FUNCTION maj_allergies_utilisateur();

-- lors d'un ajout de recette à la DB
CREATE OR REPLACE FUNCTION set_visibilite_base_recette()
    RETURNS TRIGGER 
    LANGUAGE plpgsql
    AS 
$$
BEGIN
    IF NEW.visibilite IS NULL THEN
        NEW.visibilite = 1;
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_set_visibilite_base_recette
BEFORE INSERT ON Recette
FOR EACH ROW
EXECUTE FUNCTION set_visibilite_base_recette();
