

-- creating  a databse ----------conservation_db---------------
CREATE DATABASE conservation_db


-- create rangers table ----------------------------
CREATE Table rangers (
    ranger_id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(55),
    region TEXT NOT NULL
);


--create  species table
CREATE Table species (
    species_id SERIAL NOT NULL PRIMARY KEY,
    common_name TEXT NOT null,
    scientific_name VARCHAR(55),
    discovery_date TIMESTAMP,
    conservation_status VARCHAR(100)
)


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

-- insert dummy data into rangers table-----
INSERT INTO
    rangers (name, region)VALUES ('Carol King', 'Mountain Range'),('Bob White', 'River Delta'),('Alice Green', 'Northern Hills' )
    
 

-- insert dummy data in to  species
INSERT INTO
    species (common_name,scientific_name,discovery_date,conservation_status)
VALUES ('Snow Leopard','Panthera uncia','1775-01-01','Endangered'),('Bengal Tiger','Panthera tigris tigris','1758-01-01','Endangered'),('Red Panda','Ailurus fulgens','1825-01-01','Vulnerable'),('Asiatic Elephant','Elephas maximus indicus','1758-01-01','Endangered')
   



-- insert dummy data intoo sightings-----
INSERT INTO 
sightings (ranger_id,species_id,location,sighting_time,notes)VALUES (1,1,'Peak Ridge','2024-05-10 07:45:00','Camera trap image captured'),(2,2,'Bankwood Area','2024-05-12 16:20:00','Juvenile seen'),(3,3,'Bamboo Grove East','2024-05-15 09:10:00','Feeding observed'),(1,2,'Snowfall Pass','2024-05-18 18:30:00',NULL);

--*problem-01______Insert A ranger 'Derek Fox'
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- problem-02 Count the number of unique species sighted
SELECT count(DISTINCT common_name) as unique_species_count
FROM species;

-- problem-03_____Find all sightings where location contains the word 'Pass'
SELECT * FROM sightings WHERE location ILIKE '%Pass%';

-- problem-04____ Show total number of sightings made by each ranger
SELECT name, count(sighting_id) as total_sightings
FROM rangers
    join sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY
    name;

-- problem-05____List species that have not been sighted yet
SELECT common_name
FROM species
WHERE
    species_id NOT IN (
        SELECT DISTINCT
            species_id
        FROM sightings
    );

-- problem-06__Show the latest 2 sightings with species name, time, and ranger name
SELECT common_name, sighting_time, name
FROM
    sightings
    JOIN rangers ON sightings.ranger_id = rangers.ranger_id
    JOIN species ON sightings.species_id = species.species_id
ORDER BY sighting_time DESC
LIMIT 2;

-- problem- 07__Update conservation status to 'Historic' for species discovered before 1800
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    discovery_date < '1800-01-01';

-- problem-08____________Classify sightings into Morning, Afternoon, and Evening based on time
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

-- problem-09____Delete rangers who have no recorded sightings
DELETE FROM rangers
WHERE
    ranger_id NOT IN (
        SELECT DISTINCT
            ranger_id
        FROM sightings
    );


    -- ____________Verification queries______________

SELECT * FROM rangers;

SELECT * FROM species;

SELECT * FROM sightings