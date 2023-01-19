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
ORDER BY owned_animals DESC
LIMIT 1;

-- Queries

SELECT animal.* from animals animal
JOIN visits visit
ON visit.vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
AND visit.animal_id = animal.id
ORDER BY visit.date_of_visit DESC
LIMIT 1;

WITH different_animals AS (
    SELECT animal.id FROM animals animal
    JOIN visits visit
    ON visit.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
    AND visit.animal_id = animal.id
    GROUP BY animal.id
)
SELECT COUNT(*) AS different_animals FROM different_animals;

SELECT * FROM vets
LEFT JOIN specializations spec
ON spec.vet_id = id;

SELECT animal.* FROM animals animal
JOIN visits visit
ON visit.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
AND animal.id = visit.animal_id
WHERE visit.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animal.*
FROM visits visit
JOIN animals animal ON animal.id = visit.animal_id
GROUP BY visit.animal_id, animal.id
ORDER BY COUNT(visit.vet_id) DESC
LIMIT 1;

SELECT animal.* FROM visits
JOIN animals animal on animal.id = visits.animal_id
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
GROUP BY animal.id, date_of_visit
ORDER BY date_of_visit
LIMIT 1;
--
SELECT animal.*, vet.name, vet.age, vet.date_of_graduation, visit.date_of_visit FROM visits visit
JOIN vets vet ON vet.id = visit.vet_id
JOIN animals animal ON animal.id = visit.animal_id
ORDER BY visit.date_of_visit DESC
LIMIT 1;

WITH only_one_spec_vets AS (
    SELECT * FROM specializations WHERE vet_id IN (
        SELECT vet_id FROM specializations
        GROUP BY vet_id
        HAVING COUNT(vet_id) = 1
    )
)
SELECT COUNT(*) FROM vets
FULL JOIN only_one_spec_vets spec on vets.id = spec.vet_id
JOIN visits visit on vets.id = visit.vet_id
JOIN animals animal on animal.id = visit.animal_id
WHERE animal.species_id != spec.specie_id OR spec.specie_id IS NULL;

SELECT specie.name AS most_visiting_specie FROM vets
FULL JOIN specializations spec on vets.id = spec.vet_id
JOIN visits visit on vets.id = visit.vet_id
JOIN animals animal on animal.id = visit.animal_id
JOIN species specie ON specie.id = animal.species_id
WHERE spec.specie_id IS NULL
GROUP BY specie.name
ORDER BY COUNT(specie.name) DESC
LIMIT 1;
