insert into colors (name)
select *
from (
         select distinct rtrim(color1)
         from animals
         union
         select distinct rtrim(color2)
         from animals
         where color2 is not null
     );

CREATE table colors
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name varchar(30)
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
    outcome_id       INTEGER PRIMARY KEY AUTOINCREMENT,
    age_upon_outcome VARCHAR(100),
    outcome_subtype  VARCHAR(100),
    outcome_type     VARCHAR(100),
    outcome_month    INTEGER,
    outcome_year     DATE,
    animals_id VARCHAR(100),
    FOREIGN KEY (animals_id) REFERENCES animals(animal_id)
);

INSERT INTO outcomes (age_upon_outcome, outcome_subtype, outcome_type, outcome_month, outcome_year, animals_id)
SELECT DISTINCT  age_upon_outcome, outcome_subtype, outcome_type, outcome_month, outcome_year, animal_id
FROM animals;

CREATE TABLE animal_types
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100)
);

INSERT INTO animal_types(name)
SELECT DISTINCT (animal_type)
FROM animals;

select *
from animal_types;

CREATE TABLE breed
(
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100)
);

INSERT INTO breed(name)
SELECT DISTINCT (breed)
FROM animals;

SELECT *
FROM breed;

CREATE TABLE animal_fin
(
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    animal_id     VARCHAR(100),
    type_id       INTEGER,
    name          VARCHAR(100),
    breed_id      INTEGER,
    date_of_birth DATETIME
);

INSERT INTO animal_fin(animal_id, type_id, name, breed_id, date_of_birth)
SELECT DISTINCT animal_id, animal_types.id, animals.name, breed.id, date_of_birth
FROM animals
         LEFT JOIN animal_types on animals.animal_type = animal_types.name
         LEFT JOIN breed on animals.breed = breed.name;

SELECT *
FROM animal_fin
         LEFT JOIN outcomes on outcomes.animal_id = animal_fin.animal_id
WHERE animal_fin.id = 6


