/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
    VALUES ('Agumon', '2020-02-03', 0, true, 10.23),
           ('Gabumon', '2018-11-15', 2, true, 8),
           ('Pikachu', '2021-01-07', 1, false, 15.04),
           ('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals VALUES (DEFAULT, 'Charmander', '2020-02-08', 0, false, -11),
                           (DEFAULT, 'Plantmon', '2021-11-15', 2, true, -5.7),
                           (DEFAULT, 'Squirtle', '1993-04-02', 3, false, -12.13),
                           (DEFAULT, 'Angemon', '2005-06-12', 1, true, -45),
                           (DEFAULT, 'Boarmon', '2005-06-07', 7, true, 20.4),
                           (DEFAULT, 'Blossom', '1998-10-13', 3, true, 17),
                           (DEFAULT, 'Ditto', '2022-05-14', 4, true, 22);

INSERT INTO owners VALUES (DEFAULT, 'Sam Smith', 34),
                           (DEFAULT, 'Jennifer Orwell', 19),
                           (DEFAULT, 'Bob', 45),
                           (DEFAULT, 'Melody Pond', 77),
                           (DEFAULT, 'Dean Winchester', 14),
                           (DEFAULT, 'Jodie Whittaker', 38);

INSERT INTO species VALUES (DEFAULT, 'Pokemon'),
                          (DEFAULT, 'Digimon');

UPDATE animals
SET species_id = CASE
    WHEN name LIKE '%mon'
        THEN 2
        ELSE 1
    END;

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon';
UPDATE animals SET owner_id = 3 WHERE name = 'Plantmon';
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander';
UPDATE animals SET owner_id = 4 WHERE name = 'Squirtle';
UPDATE animals SET owner_id = 4 WHERE name = 'Blossom';
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon';
UPDATE animals SET owner_id = 5 WHERE name = 'Boarmon';
