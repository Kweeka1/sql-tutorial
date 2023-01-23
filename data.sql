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

INSERT INTO vets VALUES (DEFAULT, 'William Tatcher', 45, '2000-04-23'),
                        (DEFAULT, 'Maisy Smith', 26, '2019-01-17'),
                        (DEFAULT, 'Stephanie Mendez', 64, '1981-05-04'),
                        (DEFAULT, 'Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),
       ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon')),
       ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
       ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));

-- Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO visits
SELECT animal.id, vet.id, '2020-05-24' FROM animals animal
JOIN vets vet ON vet.name = 'William Tatcher'
WHERE animal.Name = 'Agumon';

-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
INSERT INTO visits
SELECT animal.id, vet.id, '2020-07-22' FROM animals animal
JOIN vets vet ON vet.name = 'Stephanie Mendez'
WHERE animal.Name = 'Agumon';

-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
INSERT INTO visits
SELECT animal.id, vet.id, '2021-02-02' FROM animals animal
JOIN vets vet ON vet.name = 'Jack Harkness'
WHERE animal.Name = 'Gabumon';

-- Pikachu visited Maisy Smith on Jan 5th, 2020.
INSERT INTO visits
SELECT animal.id, vet.id, '2020-01-05' FROM animals animal
JOIN vets vet ON vet.name = 'Maisy Smith'
WHERE animal.Name = 'Pikachu';

-- Pikachu visited Maisy Smith on Mar 8th, 2020.
INSERT INTO visits
SELECT animal.id, vet.id, '2020-03-08' FROM animals animal
JOIN vets vet ON vet.name = 'Maisy Smith'
WHERE animal.Name = 'Pikachu';

-- Pikachu visited Maisy Smith on May 14th, 2020.
INSERT INTO visits
SELECT animal.id, vet.id, '2020-05-14' FROM animals animal
JOIN vets vet ON vet.name = 'Maisy Smith'
WHERE animal.Name = 'Pikachu';

-- Devimon visited Stephanie Mendez on May 4th, 2021.
INSERT INTO visits
SELECT animal.id, vet.id, '2021-05-04' FROM animals animal
JOIN vets vet ON vet.name = 'Stephanie Mendez'
WHERE animal.Name = 'Devimon';

-- Charmander visited Jack Harkness on Feb 24th, 2021.
INSERT INTO visits
SELECT animal.id, vet.id, '2021-02-24' FROM animals animal
JOIN vets vet ON vet.name = 'Jack Harkness'
WHERE animal.Name = 'Charmander';

-- Plantmon visited Maisy Smith on Dec 21st, 2019.
INSERT INTO visits
SELECT animal.id, vet.id, '2019-12-21' FROM animals animal
JOIN vets vet ON vet.name = 'Maisy Smith'
WHERE animal.Name = 'Plantmon';

-- Plantmon visited William Tatcher on Aug 10th, 2020.
INSERT INTO visits
SELECT animal.id, vet.id, '2020-08-10' FROM animals animal
JOIN vets vet ON vet.name = 'William Tatcher'
WHERE animal.Name = 'Plantmon';

-- Plantmon visited Maisy Smith on Apr 7th, 2021.
INSERT INTO visits
SELECT animal.id, vet.id, '2021-04-07' FROM animals animal
JOIN vets vet ON vet.name = 'Maisy Smith'
WHERE animal.Name = 'Plantmon';

-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
INSERT INTO visits
SELECT animal.id, vet.id, '2019-09-29' FROM animals animal
JOIN vets vet ON vet.name = 'Stephanie Mendez'
WHERE animal.Name = 'Squirtle';

-- Angemon visited Jack Harkness on Oct 3rd, 2020.
INSERT INTO visits
SELECT animal.id, vet.id, '2020-10-03' FROM animals animal
JOIN vets vet ON vet.name = 'Jack Harkness'
WHERE animal.Name = 'Angemon';

-- Angemon visited Jack Harkness on Nov 4th, 2020.
INSERT INTO visits
SELECT animal.id, vet.id, '2020-11-04' FROM animals animal
JOIN vets vet ON vet.name = 'Jack Harkness'
WHERE animal.Name = 'Angemon';

-- Boarmon visited Maisy Smith on Jan 24th, 2019.
INSERT INTO visits
SELECT animal.id, vet.id, '2019-01-24' FROM animals animal
JOIN vets vet ON vet.name = 'Maisy Smith'
WHERE animal.Name = 'Boarmon';

-- Boarmon visited Maisy Smith on May 15th, 2019.
INSERT INTO visits
SELECT animal.id, vet.id, '2019-05-15' FROM animals animal
JOIN vets vet ON vet.name = 'Maisy Smith'
WHERE animal.Name = 'Boarmon';

-- Boarmon visited Maisy Smith on Feb 27th, 2020.
INSERT INTO visits
SELECT animal.id, vet.id, '2020-02-27' FROM animals animal
JOIN vets vet ON vet.name = 'Maisy Smith'
WHERE animal.Name = 'Boarmon';

-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
INSERT INTO visits
SELECT animal.id, vet.id, '2020-08-03' FROM animals animal
JOIN vets vet ON vet.name = 'Maisy Smith'
WHERE animal.Name = 'Boarmon';

-- Blossom visited Stephanie Mendez on May 24th, 2020.
INSERT INTO visits
SELECT animal.id, vet.id, '2020-05-24' FROM animals animal
JOIN vets vet ON vet.name = 'Stephanie Mendez'
WHERE animal.Name = 'Blossom';

-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits
SELECT animal.id, vet.id, '2021-01-11' FROM animals animal
JOIN vets vet ON vet.name = 'William Tatcher'
WHERE animal.Name = 'Blossom';

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT * FROM (SELECT id FROM animals) animal_ids,
              (SELECT id FROM vets) vets_ids,
              generate_series('1980-01-01'::TIMESTAMP, '2021-01-01', '4 hours') visit_timestamp;

INSERT INTO owners (full_name, age, email)
SELECT 'Owner ' || generate_series(1,2500000),
FLOOR(RANDOM()*(70-14)+14),
'owner_' || generate_series(1,2500000) || '@mail.com';
