-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS orbit CASCADE;
DROP TABLE IF EXISTS celestial_body CASCADE;
DROP TABLE IF EXISTS celestial_body_type CASCADE;


-- 1. Celestial body types
CREATE TABLE celestial_body_type (
id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL UNIQUE
);


-- 2. Celestial bodies
CREATE TABLE celestial_body (
id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
type_id INT NOT NULL,
parent_id INT,
mass_kg DOUBLE PRECISION,
radius_km DOUBLE PRECISION,
distance_km DOUBLE PRECISION,
discovered_year INT,
CONSTRAINT fk_type
FOREIGN KEY (type_id) REFERENCES celestial_body_type(id),
CONSTRAINT fk_parent
FOREIGN KEY (parent_id) REFERENCES celestial_body(id)
ON DELETE SET NULL
);


-- 3. Orbit details
CREATE TABLE orbit (
id SERIAL PRIMARY KEY,
body_id INT NOT NULL,
orbital_period_days DOUBLE PRECISION,
eccentricity DOUBLE PRECISION CHECK (eccentricity >= 0 AND eccentricity < 1),
inclination_deg DOUBLE PRECISION,
CONSTRAINT fk_body
FOREIGN KEY (body_id) REFERENCES celestial_body(id)
ON DELETE CASCADE
);


-- 4. Insert body types
INSERT INTO celestial_body_type (name) VALUES
('Star'),
('Planet'),
('Moon');


-- 5. Insert celestial bodies
INSERT INTO celestial_body (name, type_id, mass_kg, radius_km)
VALUES ('Sun', 1, 1.989e30, 696340);


INSERT INTO celestial_body (name, type_id, parent_id, mass_kg, radius_km, distance_km)
VALUES ('Earth', 2, 1, 5.972e24, 6371, 149600000);


INSERT INTO celestial_body (name, type_id, parent_id, mass_kg, radius_km, distance_km)
VALUES ('Moon', 3, 2, 7.35e22, 1737, 384400);


-- 6. Insert orbit data
INSERT INTO orbit (body_id, orbital_period_days, eccentricity, inclination_deg)
VALUES
(2, 365.25, 0.0167, 0.00005),
(3, 27.32, 0.0549, 5.145);
