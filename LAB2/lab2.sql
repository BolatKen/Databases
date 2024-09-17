--1
--CREATE DATABASE lab2;

--2
CREATE TABLE countries (
	country_id serial primary key,
	country_name varchar(255),
	region_id INT,
	population INT
);

--3
INSERT INTO countries
VALUES (default, 'England', 01, 9999);

--4
INSERT INTO countries (country_id, country_name)
VALUES (default, 'Poland');

--5
INSERT INTO countries (region_id)
VALUES (NULL);

--6
INSERT INTO countries(country_name, region_id, population)
VALUES ('Russia',1, 1),
('China', 2, 2),
('USA', 3, 4);

--7
ALTER TABLE countries
ALTER COLUMN country_name set default 'Kazakhstan';

--8
INSERT INTO countries (country_name)
VALUES (default);

--9
INSERT INTO countries (country_id, country_name, region_id, population)
VALUES (default, default, default, default);

--10
CREATE TABLE countries_new(LIKE countries INCLUDING ALL);

--11
INSERT INTO countries_new(country_id, country_name, region_id, population)
SELECT country_id, country_name, region_id, population
FROM countries;

--12
UPDATE countries_new
SET region_id = 1
WHERE region_id IS NULL;

--13
UPDATE countries_new
SET population = population +(population/10)
RETURNING country_name, population AS "NEW Populatoin";

--14
DELETE FROM countries *
WHERE population < 100000
RETURNING *;

--15
DELETE FROM countries_new * as cn
USING countries as c
WHERE c.country_id  = cn.country_id
RETURNING *;

--16
DELETE FROM countries
RETURNING *;
