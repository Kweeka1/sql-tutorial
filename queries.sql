-- Queries

SELECT * from animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name from animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name = 'Agumon' or name = 'Pikachu';
SELECT (name, escape_attempts) from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Transaction

BEGIN TRANSACTION;

UPDATE animals SET species = 'unspecified';
SELECT * from animals WHERE species = 'unspecified';

ROLLBACK;

SELECT * from animals WHERE species = '';

-- Transaction

BEGIN TRANSACTION;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species = '';

COMMIT;

SELECT * from animals WHERE species = 'digimon';
SELECT * from animals WHERE species = 'pokemon';

-- Transaction

BEGIN TRANSACTION;

DELETE FROM animals;

ROLLBACK;

SELECT * from animals;

-- Transaction

BEGIN TRANSACTION;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT delete_2022_animals;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK To delete_2022_animals;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;

-- Queries

SELECT count(*) FROM animals;
SELECT count(*) FROM animals WHERE escape_attempts = 0;
SELECT avg(weight_kg) FROM animals;

SELECT CASE WHEN neutered THEN 'neutered' ELSE 'not neutered' END as escapes_most FROM animals
GROUP BY neutered
ORDER BY SUM(escape_attempts) DESC
LIMIT 1;

SELECT species, min(weight_kg), max(weight_kg) FROM animals GROUP BY species;

SELECT species, COALESCE(AVG(
    CASE
        WHEN date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
            THEN escape_attempts
    END), 0)
FROM animals
GROUP BY species;

-- Queries

SELECT animals.* FROM animals
LEFT JOIN owners owner on owner.id = animals.owner_id
WHERE owner.full_name = 'Melody Pond';

SELECT animals.* FROM animals
JOIN species specie on specie.id = animals.species_id
WHERE specie.name = 'Pokemon';

SELECT * FROM animals
RIGHT JOIN owners owner ON owner.id = animals.owner_id;

SELECT specie.name AS specie_name, COUNT(animals.species_id) AS count
FROM animals
JOIN species specie on specie.id = animals.species_id
GROUP BY specie.name;

SELECT animals.*
FROM animals
LEFT JOIN owners owner on owner.id = animals.owner_id
JOIN species specie on specie.id = animals.species_id
WHERE specie.name = 'Digimon' AND owner.full_name = 'Jennifer Orwell';

SELECT animals.*
FROM animals
LEFT JOIN owners owner on owner.id = animals.owner_id
WHERE animals.escape_attempts = 0 AND owner.full_name = 'Dean Winchester';

SELECT owner.full_name, COUNT(animals.owner_id) AS owned_animals
FROM animals
LEFT JOIN owners owner on owner.id = animals.owner_id
GROUP BY owner.full_name
ORDER BY COUNT(animals.owner_id) DESC
LIMIT 1;
