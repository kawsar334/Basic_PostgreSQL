CREATE DATABASE forest

-- PostgreSQL_Assignment.sql

-- 🛠️ Drop tables if they exist
DROP TABLE IF EXISTS sightings;

DROP TABLE IF EXISTS rangers;

DROP TABLE IF EXISTS species;

CREATE Table rangers (
    ranger_id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50),
    region TEXT NOT NULL
);

INSERT INTO
    rangers (name, region)
VALUES (
        'Alice Green',
        'Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King',
        'Mountain Range'
    ),
    ('Neela', 'Sundarbans'),
    ('Ababil', 'Cox’s Bazar'),
    ('Ratul', 'Rajshahi Dry Zone'),
    ('Moyna', 'Sylhet Forest'),
    (
        'Kabir',
        'Dinajpur Wildlife Sanctuary'
    ),
    (
        'Shapla',
        'Mymensingh Reserve'
    ),
    ('Anondo', 'Rangamati Hills'),
    ('Borsha', 'Barisal Wetlands'),
    ('Hayat', 'Khulna Delta');

-- species table
CREATE Table species (
    species_id SERIAL NOT NULL PRIMARY KEY,
    common_name TEXT NOT null,
    scientific_name VARCHAR(50),
    discovery_date TIMESTAMP,
    conservation_status VARCHAR(100)
)

INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    ),
    (
        'African Elephant',
        'Loxodonta africana',
        '1900-01-01',
        'Vulnerable'
    ),
    (
        'Bald Eagle',
        'Haliaeetus leucocephalus',
        '1782-06-20',
        'Least Concern'
    ),
    (
        'Blue Whale',
        'Balaenoptera musculus',
        '1899-05-15',
        'Endangered'
    ),
    (
        'Giant Panda',
        'Ailuropoda melanoleuca',
        '1869-03-11',
        'Vulnerable'
    ),
    (
        'Snow Leopard',
        'Panthera uncia',
        '1775-08-01',
        'Vulnerable'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-12-01',
        'Endangered'
    ),
    (
        'Komodo Dragon',
        'Varanus komodoensis',
        '1910-04-01',
        'Endangered'
    ),
    (
        'Tasmanian Devil',
        'Sarcophilus harrisii',
        '1808-09-01',
        'Endangered'
    ),
    (
        'Great White Shark',
        'Carcharodon carcharias',
        '1758-07-01',
        'Vulnerable'
    ),
    (
        'Axolotl',
        'Ambystoma mexicanum',
        '1863-11-30',
        'Critically Endangered'
    );

--  sightings table
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

INSERT INTO
    sightings (
        ranger_id,
        species_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        'Peak Ridge',
        '2024-05-10 07:45:00',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        'Bankwood Area',
        '2024-05-12 16:20:00',
        'Juvenile seen'
    ),
    (
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00',
        'Feeding observed'
    ),
    (
        4,
        1,
        'Snowfall Pass',
        '2024-05-18 18:30:00',
        NULL
    ),
    (
        5,
        2,
        'Green Valley',
        '2024-05-20 14:00:00',
        'Elephants moving in a group.'
    ),
    (
        6,
        6,
        'Rocky Hills',
        '2024-05-22 09:30:00',
        'Bald eagle perched on a cliff.'
    ),
    (
        7,
        7,
        'Ocean Shore',
        '2024-05-23 17:45:00',
        'Blue whale spotted near shore.'
    ),
    (
        8,
        9,
        'Forest Edge',
        '2024-05-24 12:15:00',
        NULL
    ),
    (
        9,
        10,
        'Coral Bay',
        '2024-05-25 10:10:00',
        'Great white shark fin visible in water.'
    );

-- problem-01
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- problem-02
SELECT count(DISTINCT common_name) as unique_species_count
FROM species;

-- problem-03
SELECT * FROM sightings WHERE location ILIKE '%Pass%';

-- problem-04
SELECT name, count(sighting_id) as total_sightings
FROM rangers
    join sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY
    name;

-- problem-05
SELECT common_name
FROM species
WHERE
    species_id NOT IN (
        SELECT DISTINCT
            species_id
        FROM sightings
    );

-- problem-06
SELECT common_name, sighting_time, name
FROM
    sightings
    JOIN rangers ON sightings.ranger_id = rangers.ranger_id
    JOIN species ON sightings.species_id = species.species_id
ORDER BY sighting_time DESC
LIMIT 2;

-- problem- 07
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    discovery_date < '1800-01-01';

-- problem-08
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

-- problem-09
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