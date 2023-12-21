SET search_path TO Planificateur_repas;

-- Stock: nombre (FLOAT), expiration (DATE), etat (VARCHAR(20)),
--        planificateur (INT, FK, PK), ingredient (INT, FK, PK)
INSERT INTO Stock VALUES (500, '2025-12-31', 'Sec', 1, 6);
INSERT INTO Stock VALUES (100, '2025-12-31', 'Sec', 1, 18);
INSERT INTO Stock VALUES (NULL, NULL, 'Robinet', 1, 21);
INSERT INTO Stock VALUES (200, '2024-12-31', 'Cru', 1, 22);
INSERT INTO Stock VALUES (6, '2024-01-31', 'Cru', 1, 24);
INSERT INTO Stock VALUES (100, '2024-01-31', 'Cru', 1, 20);
INSERT INTO Stock VALUES (100, '2025-12-31', 'Cru', 1, 19);
INSERT INTO Stock VALUES (5, NULL, 'Cru', 1, 11);
INSERT INTO Stock VALUES (150, '2024-12-31', 'Cru', 1, 23);
INSERT INTO Stock VALUES (500, '2025-12-31', 'Sec', 1, 28);
INSERT INTO Stock VALUES (500, '2025-12-31', 'Sec', 1, 29);
INSERT INTO Stock VALUES (500, '2025-12-31', 'Sec', 1, 30);

INSERT INTO Stock VALUES (500, '2025-12-31', 'Sec', 2, 6);
INSERT INTO Stock VALUES (100, '2025-12-31', 'Sec', 2, 18);
INSERT INTO Stock VALUES (999999999, NULL, 'Robinet', 2, 21);
INSERT INTO Stock VALUES (200, '2024-12-31', 'Cru', 2, 22);
INSERT INTO Stock VALUES (6, '2024-01-31', 'Cru', 2, 24);
INSERT INTO Stock VALUES (100, '2024-01-31', 'Cru', 2, 20);
INSERT INTO Stock VALUES (100, '2025-12-31', 'Cru', 2, 19);
INSERT INTO Stock VALUES (5, NULL, 'Cru', 2, 11);
INSERT INTO Stock VALUES (150, '2024-12-31', 'Cru', 2, 23);
INSERT INTO Stock VALUES (500, '2025-12-31', 'Sec', 2, 28);
INSERT INTO Stock VALUES (500, '2025-12-31', 'Sec', 2, 29);
INSERT INTO Stock VALUES (500, '2025-12-31', 'Sec', 2, 30);

-- Commande: nombre (FLOAT), etat (VARCHAR(20)), planificateur (INT, FK, PK), ingredient (INT, FK, PK)
INSERT INTO Commande VALUES (500, 'Bouteille', 1, 5);
INSERT INTO Commande VALUES (500, 'Bouteille', 2, 4);

-- Aime_recette: utilisateur (VARCHAR(100), FK, PK), recette (INT, FK, PK)
INSERT INTO aime_recette VALUES ('homer@simpson.com', 1);
INSERT INTO aime_recette VALUES ('homer@simpson.com', 2);
INSERT INTO aime_recette VALUES ('bart@simpson.com', 2);
INSERT INTO aime_recette VALUES ('bart@simpson.com', 3);

-- Utilise_recette: id (INT, PK), date (DATE), menage (INT, FK), recette (INT, FK)
INSERT INTO utilise_recette VALUES (1, '2023-12-15', 1, 1);
INSERT INTO utilise_recette VALUES (2, '2023-12-15', 1, 2);

INSERT INTO utilise_recette VALUES (3, '2023-12-15', 2, 3);
INSERT INTO utilise_recette VALUES (4, '2023-12-15', 2, 2);

-- Utilise_ingredient: utilise_recette (INT, FK, PK), ingredient (INT, FK, PK),
--                     nombre (FLOAT)
INSERT INTO utilise_ingredient VALUES (1, 3, 100);
INSERT INTO utilise_ingredient VALUES (3, 22, 60);

-- Ingredient_principal: id (INT, PK), recette (INT, FK), ingredient (INT, FK), nombre (FLOAT)
INSERT INTO ingredient_principal VALUES (1, 1, 9, 20);
INSERT INTO ingredient_principal VALUES (2, 1, 10, 0.25);
INSERT INTO ingredient_principal VALUES (3, 1, 11, 1);
INSERT INTO ingredient_principal VALUES (4, 1, 1, 1);
INSERT INTO ingredient_principal VALUES (5, 1, 3, 100);
INSERT INTO ingredient_principal VALUES (6, 1, 2, 2);
INSERT INTO ingredient_principal VALUES (7, 1, 13, 50);
INSERT INTO ingredient_principal VALUES (8, 1, 14, 80);
INSERT INTO ingredient_principal VALUES (9, 1, 15, 0.25);
INSERT INTO ingredient_principal VALUES (10, 1, 16, 1);
INSERT INTO ingredient_principal VALUES (11, 1, 17, 0.25);
INSERT INTO ingredient_principal VALUES (12, 1, 18, 1.5);
INSERT INTO ingredient_principal VALUES (13, 1, 19, 0.5);
INSERT INTO ingredient_principal VALUES (14, 1, 20, 20);

INSERT INTO ingredient_principal VALUES (15, 2, 6, 150);
INSERT INTO ingredient_principal VALUES (16, 2, 18, 20);
INSERT INTO ingredient_principal VALUES (17, 2, 21, 1000);

INSERT INTO ingredient_principal VALUES (18, 3, 22, 20);
INSERT INTO ingredient_principal VALUES (19, 3, 24, 1);
INSERT INTO ingredient_principal VALUES (20, 3, 20, 20);
INSERT INTO ingredient_principal VALUES (21, 3, 19, 0.5);
INSERT INTO ingredient_principal VALUES (22, 3, 11, 1);
INSERT INTO ingredient_principal VALUES (23, 3, 9, 15);
INSERT INTO ingredient_principal VALUES (24, 3, 25, 1);

-- Ingredient_substitue: recette (INT, FK, PK), ingredient_principal (INT, FK, PK),
--                       ingredient_substitue (INT, FK, PK), nombre (FLOAT, pour ingredient_substitue)
INSERT INTO Ingredient_substitue VALUES (1, 3, 26, 100);
INSERT INTO Ingredient_substitue VALUES (1, 3, 27, 100);

INSERT INTO Ingredient_substitue VALUES (1, 1, 0, NULL);
INSERT INTO Ingredient_substitue VALUES (1, 11, 0, NULL);
INSERT INTO Ingredient_substitue VALUES (1, 13, 0, NULL);
INSERT INTO Ingredient_substitue VALUES (1, 15, 0, NULL);
INSERT INTO Ingredient_substitue VALUES (1, 16, 0, NULL);
INSERT INTO Ingredient_substitue VALUES (1, 17, 0, NULL);
INSERT INTO Ingredient_substitue VALUES (1, 20, 0, NULL);

INSERT INTO Ingredient_substitue VALUES (2, 6, 28, 150);
INSERT INTO Ingredient_substitue VALUES (2, 6, 29, 150);
INSERT INTO Ingredient_substitue VALUES (2, 6, 30, 150);

INSERT INTO Ingredient_substitue VALUES (3, 22, 23, 20);
INSERT INTO Ingredient_substitue VALUES (3, 20, 31, 10);

INSERT INTO Ingredient_substitue VALUES (3, 24, 0, NULL);
INSERT INTO Ingredient_substitue VALUES (3, 20, 0, NULL);
INSERT INTO Ingredient_substitue VALUES (3, 19, 0, NULL);
INSERT INTO Ingredient_substitue VALUES (3, 11, 0, NULL);

-- Recette_liee: recette (INT, FK, PK), recette_liee (INT, FK, PK)
INSERT INTO Recette_liee VALUES (1, 2);
INSERT INTO Recette_liee VALUES (3, 2);
INSERT INTO Recette_liee VALUES (2, 1);
INSERT INTO Recette_liee VALUES (2, 3);