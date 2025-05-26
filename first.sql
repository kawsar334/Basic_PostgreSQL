CREATE DATABASE conservation_db



CREATE Table rangers (
    ranger_id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50),
    region TEXT NOT NULL
);

INSERT INTO
    rangers (name, region)VALUES ('Carol King', 'Mountain Range'),('Bob White', 'River Delta'),('Alice Green', 'Northern Hills' )
    
 
-- species table
 CREATE Table species (
    species_id SERIAL NOT NULL PRIMARY KEY,
    common_name TEXT NOT null,
    scientific_name VARCHAR(50),
    discovery_date TIMESTAMP,
    conservation_status VARCHAR(100)
)

INSERT INTO
    species (common_name,scientific_name,discovery_date,conservation_status)
VALUES ('Snow Leopard','Panthera uncia','1775-01-01','Endangered'),('Bengal Tiger','Panthera tigris tigris','1758-01-01','Endangered'),('Red Panda','Ailurus fulgens','1825-01-01','Vulnerable'),('Asiatic Elephant','Elephas maximus indicus','1758-01-01','Endangered')
  

--=============  sightings table==================
CREATE Table sightings (
    sighting_id SERIAL PRIMARY KEY NOT NULL,
    ranger_id INT,
    species_id INT,
    location TEXT,
    sighting_time TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (ranger_id) REFERENCES rangers (ranger_id),
    FOREIGN KEY (species_id) REFERENCES species (species_id)
);


-- insert intoo sightings--------=========================
INSERT INTO
    sightings (ranger_id,species_id,location,sighting_time,notes)VALUES (1,1,'Peak Ridge','2024-05-10 07:45:00','Camera trap image captured'),(2,2,'Bankwood Area','2024-05-12 16:20:00','Juvenile seen'),(3,3,'Bamboo Grove East','2024-05-15 09:10:00','Feeding observed'),(1,2,'Snowfall Pass','2024-05-18 18:30:00',NULL);

--* * * * * * * * * * * * * * * * * * * * * * * * * *problem-01
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

--* * * * * * * * * * * * * * * * * * * * * * * * * * problem-02
SELECT count(DISTINCT common_name) as unique_species_count
FROM species;

--* * * * * * * * * * * * * * * * * * * * * * * * * * problem-03
SELECT * FROM sightings WHERE location ILIKE '%Pass%';

--* * * * * * * * * * * * * * * * * * * * * * * * * * problem-04
SELECT name, count(sighting_id) as total_sightings
FROM rangers
    join sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY
    name;

--* * * * * * * * * * * * * * * * * * * * * * * * * * problem-05
SELECT common_name
FROM species
WHERE
    species_id NOT IN (
        SELECT DISTINCT
            species_id
        FROM sightings
    );

--* * * * * * * * * * * * * * * * * * * * * * * * * * problem-06
SELECT common_name, sighting_time, name
FROM
    sightings
    JOIN rangers ON sightings.ranger_id = rangers.ranger_id
    JOIN species ON sightings.species_id = species.species_id
ORDER BY sighting_time DESC
LIMIT 2;

--* * * * * * * * * * * * * * * * * * * * * * * * * * problem- 07
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    discovery_date < '1800-01-01';

--* * * * * * * * * * * * * * * * * * * * * * * * * * problem-08
SELECT
    extract(
        HOUR
        FROM sighting_time
    ) as sighting_id,
    CASE
        WHEN extract(
            HOUR
            FROM sighting_time
        ) < 12 THEN 'Morning'
        WHEN extract(
            HOUR
            FROM sighting_time
        ) BETWEEN 12 AND 17  THEN 'Afternoon'
        ELSE 'Evening'
    END as time_of_day
FROM sightings;

--* * * * * * * * * * * * * * * * * * * * * * * * * * problem-09
DELETE FROM rangers
WHERE
    ranger_id NOT IN (
        SELECT DISTINCT
            ranger_id
        FROM sightings
    );

SELECT * FROM rangers;

SELECT * FROM species;

SELECT * FROM sightings