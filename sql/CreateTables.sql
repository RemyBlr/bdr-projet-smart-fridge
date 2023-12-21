CREATE SCHEMA IF NOT EXISTS Planificateur_repas;

SET search_path TO Planificateur_repas;

-- Menage
CREATE TABLE IF NOT EXISTS Menage (
    id          INT             PRIMARY KEY,
    adr_rue     VARCHAR(100),
    adr_num     VARCHAR(20),
    adr_npa     VARCHAR(20),
    adr_ville   VARCHAR(100)
);

-- Utilisateur
CREATE TABLE IF NOT EXISTS Utilisateur (
    email           VARCHAR(100)    PRIMARY KEY,
    prenom          VARCHAR(100),
    nom             VARCHAR(100),
    genre           CHAR(1),
    dob             DATE,
    poids           FLOAT,
    taille          FLOAT,
    mot_de_passe    VARCHAR(80)
);

-- Recette
CREATE TABLE IF NOT EXISTS Recette (
    id          INT             PRIMARY KEY,
    nom         VARCHAR(100),
    operations  VARCHAR(2000),
    difficulte  INT,  -- sur une échelle de 1 à 10 (le plus difficile)
    temps       TIME,
    calories    FLOAT, -- pour 1 adulte
    score       CHAR(1), -- sur une échelle de A (le plus sain) à E
    visibilite  VARCHAR(20), -- public, privé
    utilisateur VARCHAR(100)    NOT NULL,
    FOREIGN KEY (utilisateur)   REFERENCES Utilisateur(email)
);

-- Recette_liee
CREATE TABLE IF NOT EXISTS Recette_liee (
    recette         INT,
    recette_liee    INT,
    PRIMARY KEY (recette, recette_liee),
    FOREIGN KEY (recette)       REFERENCES Recette(id),
    FOREIGN KEY (recette_liee)  REFERENCES Recette(id),
    CHECK (recette <> recette_liee)
);

-- Permission
CREATE TABLE IF NOT EXISTS Permission (
    email       VARCHAR(100)    PRIMARY KEY,
    admin       BOOLEAN,
    menage      BOOLEAN,
    recette     BOOLEAN,
    stock       BOOLEAN,
    ingredient  BOOLEAN,
    FOREIGN KEY (email) REFERENCES Utilisateur(email)
);

-- Catégorie d'ingrédient
CREATE TABLE IF NOT EXISTS Categorie (
    nom VARCHAR(100)    PRIMARY KEY
);

-- Ingredient
CREATE TABLE IF NOT EXISTS Ingredient (
    id          INT             PRIMARY KEY,
    nom         VARCHAR(100),
    type        VARCHAR(100),
    description VARCHAR(100),
    unite       VARCHAR(20),
    categorie   VARCHAR(100)    NOT NULL,
    utilisateur VARCHAR(100)    NOT NULL,
    FOREIGN KEY (categorie)     REFERENCES Categorie(nom),
    FOREIGN KEY (utilisateur)   REFERENCES Utilisateur(email)
);

-- Planificateur
CREATE TABLE IF NOT EXISTS Planificateur (
    id      INT PRIMARY KEY,
    menage  INT NOT NULL,
    FOREIGN KEY (menage) REFERENCES Menage(id)
);

-- Stock
CREATE TABLE IF NOT EXISTS Stock (
    nombreStock     FLOAT,
    expiration      DATE,
    etat            VARCHAR(20),
    planificateur   INT,
    ingredient      INT,
    PRIMARY KEY (planificateur, ingredient),
    FOREIGN KEY (planificateur) REFERENCES Planificateur(id),
    FOREIGN KEY (ingredient)    REFERENCES Ingredient(id)
);

-- Commande
CREATE TABLE IF NOT EXISTS Commande (
    nombreCommande  FLOAT,
    etat            VARCHAR(20),
    planificateur   INT,
    ingredient      INT,
    PRIMARY KEY (planificateur, ingredient),
    FOREIGN KEY (planificateur) REFERENCES Planificateur(id),
    FOREIGN KEY (ingredient)    REFERENCES Ingredient(id)
);

-- Allergie
CREATE TABLE IF NOT EXISTS Allergie (
    utilisateur     VARCHAR(100),
    ingredient      INT,
    PRIMARY KEY (utilisateur, ingredient),
    FOREIGN KEY (utilisateur)   REFERENCES Utilisateur(email),
    FOREIGN KEY (ingredient)    REFERENCES Ingredient(id)
);

-- Aime_ingredient
CREATE TABLE IF NOT EXISTS Aime_ingredient (
    utilisateur VARCHAR(100),
    ingredient  INT,
    PRIMARY KEY (utilisateur, ingredient),
    FOREIGN KEY (utilisateur)   REFERENCES Utilisateur(email),
    FOREIGN KEY (ingredient)    REFERENCES Ingredient(id)
);

-- Aime_recette
CREATE TABLE IF NOT EXISTS Aime_recette (
    utilisateur VARCHAR(100),
    recette     INT,
    PRIMARY KEY (utilisateur, recette),
    FOREIGN KEY (utilisateur)   REFERENCES Utilisateur(email),
    FOREIGN KEY (recette)       REFERENCES Recette(id)
);

-- Utilisateur_menage
CREATE TABLE IF NOT EXISTS Utilisateur_menage (
    menage      INT,
    utilisateur VARCHAR(100),
    PRIMARY KEY (menage, utilisateur),
    FOREIGN KEY (menage)        REFERENCES Menage(id),
    FOREIGN KEY (utilisateur)   REFERENCES Utilisateur(email)
);

-- Utilise_recette
CREATE TABLE IF NOT EXISTS Utilise_recette (
    id      INT             PRIMARY KEY,
    date    DATE,
    menage  INT NOT NULL,
    recette INT NOT NULL,
    FOREIGN KEY (menage)    REFERENCES Menage(id),
    FOREIGN KEY (recette)   REFERENCES Recette(id)
);

-- Utilise_ingredient
CREATE TABLE IF NOT EXISTS Utilise_ingredient (
    utilise_recette INT,
    ingredient      INT,
    nombe           FLOAT,
    PRIMARY KEY (Utilise_recette, ingredient),
    FOREIGN KEY (utilise_recette)   REFERENCES Utilise_recette(id),
    FOREIGN KEY (ingredient)        REFERENCES Ingredient(id)
);

-- Ingredient_principal
CREATE TABLE IF NOT EXISTS Ingredient_principal (
    ingredientPrincipal         INT        PRIMARY KEY,
    recette                     INT,
    ingredient                  INT,
    nombreIngredient            FLOAT,
    FOREIGN KEY (recette)       REFERENCES Recette(id),
    FOREIGN KEY (ingredient)    REFERENCES Ingredient(id)
);

-- Ingredient_substitue
CREATE TABLE IF NOT EXISTS Ingredient_substitue (
    recette                 INT,
    ingredient_principal    INT,
    ingredient_substitue    INT,
    nombre                  FLOAT,
    PRIMARY KEY (recette, ingredient_principal, ingredient_substitue),
    FOREIGN KEY (recette)               REFERENCES Recette(id),
    FOREIGN KEY (ingredient_principal)  REFERENCES Ingredient_principal(ingredientPrincipal),
    FOREIGN KEY (ingredient_substitue)  REFERENCES Ingredient(id)
);

insert into recette values (1, 'pâtes', '1. aaaa 2. sss', 3, '11:00:00', 200, 10, 0, 'remy2@hotmail.com');
insert into recette values (2, 'pâtes carbo', '1. aaaa 2. sss', 3, '11:00:00', 200, 10, 0, 'remy2@hotmail.com');
select * from recette;
select * from utilisateur;
insert into aime_recette values ('remy2@hotmail.com',1);
insert into aime_recette values ('remy2@hotmail.com',2);