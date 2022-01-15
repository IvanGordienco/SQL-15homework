INSERT INTO colors (name)
SELECT *
FROM (
         SELECT DISTINCT rtrim(color1)
         FROM animals
         UNION
         SELECT DISTINCT rtrim(color2)
         FROM animals
         WHERE color2 IS NOT NULL
     );

CREATE TABLE colors
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(30)
);

CREATE TABLE animal_colors
(
    animal_id INTEGER,
    color_id  INTEGER

);

INSERT INTO animal_colors

SELECT animals."index",
       colors.name
FROM animals
         join colors on rtrim(animals.color2) = rtrim(colors.name);

INSERT INTO animal_colors
SELECT animals."index",
       colors.name
FROM animals
         join colors on rtrim(animals.color2) = rtrim(colors.name);

CREATE TABLE outcomes
(
    outcome_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    outcome_subtype VARCHAR(100),
    outcome_type    VARCHAR(100),
    outcome_month   INTEGER,
    outcome_year    DATE
);

INSERT INTO outcomes (outcome_subtype, outcome_type, outcome_month, outcome_year)
SELECT DISTINCT outcome_subtype, outcome_type, outcome_month, outcome_year
FROM animals;

CREATE TABLE animal_types
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100)
);

INSERT INTO animal_types(name)
SELECT DISTINCT (animal_type)
FROM animals;

CREATE TABLE breed
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100)
);

INSERT INTO breed(name)
SELECT DISTINCT (breed)
FROM animals;

CREATE TABLE animal_fin
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT ,
    animal_id VARCHAR(100),
    type_id INTEGER,
    name VARCHAR(100),
    breed_id INTEGER,
    date_of_birth DATE
);

INSERT INTO animal_fin(animal_id, type_id, name, breed_id, date_of_birth)
SELECT DISTINCT animal_id, animal_types.id,animals.name, breed.id, date_of_birth
FROM animals
LEFT JOIN animal_types on animals.animal_type=animal_types.name
LEFT JOIN breed on animals.breed=breed.name;

