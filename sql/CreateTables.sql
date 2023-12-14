CREATE SCHEMA IF NOT EXISTS Planificateur_repas;

SET search_path TO Planificateur_repas;

-- Menage
CREATE TABLE IF NOT EXISTS Menage (
    id          INT             PRIMARY KEY,
    adrRue      VARCHAR(100),
    adrNum      VARCHAR(20),
    adrNPA      VARCHAR(20),
    adrVille    VARCHAR(100)
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
    operations  VARCHAR(500),
    difficulte  INT,
    temps       TIME,
    calories    FLOAT,
    score       CHAR(1),
    visibilite  VARCHAR(20), -- public, privé
    utilisateur VARCHAR(100)    NOT NULL,
    FOREIGN KEY (utilisateur)   REFERENCES Utilisateur(email)
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
    nombre          FLOAT,
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
    nombre          FLOAT,
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
    PRIMARY KEY (Utilise_recette, ingredient),
    FOREIGN KEY (utilise_recette)   REFERENCES Utilise_recette(id),
    FOREIGN KEY (ingredient)        REFERENCES Ingredient(id)
);

-- Ingredient_principal
CREATE TABLE IF NOT EXISTS Ingredient_principal (
    id                          INT        PRIMARY KEY,
    recette                     INT,
    ingredient                  INT,
    nombre                      FLOAT,
    FOREIGN KEY (recette)       REFERENCES Recette(id),
    FOREIGN KEY (ingredient)    REFERENCES Ingredient(id)
);

-- Ingredient_substitue
CREATE TABLE IF NOT EXISTS Ingredient_substitue (
    ingredient_principal    INT,
    ingredient              INT,
    PRIMARY KEY (ingredient_principal, ingredient),
    FOREIGN KEY (ingredient_principal)  REFERENCES Ingredient_principal(id),
    FOREIGN KEY (ingredient)            REFERENCES Ingredient(id)
);