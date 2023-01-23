/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL
);

ALTER TABLE animals ADD COLUMN species VARCHAR(50);

CREATE TABLE owners (
     id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
     full_name VARCHAR(50) NOT NULL,
     age INT NOT NULL
);

CREATE TABLE species (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) NOT NULL
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vet_id INT,
    specie_id INT
);

ALTER TABLE specializations ADD constraint fk_species FOREIGN KEY (specie_id) REFERENCES species(id);
ALTER TABLE specializations ADD constraint fk_vets FOREIGN KEY (vet_id) REFERENCES vets(id);

CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    date_of_visit DATE DEFAULT NOW()
);

ALTER TABLE visits ADD constraint fk_animals FOREIGN KEY (animal_id) REFERENCES animals(id);
ALTER TABLE visits ADD constraint fk_vets FOREIGN KEY (vet_id) REFERENCES vets(id);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX visits_animal_id ON visits(animal_id);