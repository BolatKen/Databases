--1.Create database called "lab4"
CREATE DATABASE lab4;

--2.Create the tables Warehouses and Boxes
CREATE TABLE Warehouses (
    code INTEGER PRIMARY KEY,
    location VARCHAR(255),
    capacity INTEGER
);
CREATE TABLE Boxes (
    code CHAR(4) PRIMARY KEY,
    contents VARCHAR(255),
    value REAL,
    warehouse INTEGER,
    FOREIGN KEY (warehouse) REFERENCES Warehouses(code)
);

--3.Insert the data into Warehouses and Boxes
INSERT INTO Warehouses (code, location, capacity) VALUES
(1, 'Chicago', 3),
(2, 'Chicago', 4),
(3, 'New York', 7),
(4, 'Los Angeles', 2),
(5, 'San Francisco', 8);
INSERT INTO Boxes (code, contents, value, warehouse) VALUES
('OMN7', 'Rocks', 180, 3),
('4HBP', 'Rocks', 250, 1),
('4R73', 'Scissors', 190, 1),
('7G34', 'Rocks', 200, 1),
('8JN6', 'Papers', 75, 1),
('6YU9', 'Papers', 50, 3),
('9J6F', 'Papers', 175, 2),
('LL08', 'Rocks', 140, 4),
('P0H6', 'Scissors', 125, 1),
('P2T6', 'Scissors', 150, 2),
('TU55', 'Papers', 90, 5);

--4.Select all warehouses with all columns
SELECT * FROM Warehouses;

--5.Select all boxes with a value larger than $150
SELECT * FROM boxes WHERE value > 150;

--6.Select all the boxes distinct by contents
SELECT DISTINCT contents FROM Boxes;

--7.Select the warehouse code and the number of the boxes in each warehouse
SELECT warehouse, COUNT(*) AS box_count
FROM Boxes
GROUP BY warehouse;

--8.Select only those warehouses where the number of boxes is greater than 2
SELECT warehouse, COUNT(*) AS box_count
FROM Boxes
GROUP BY warehouse
HAVING COUNT(*) > 2;

--9.Create a new warehouse in New York with a capacity for 3 boxes
INSERT INTO Warehouses (code, location, capacity) VALUES
(6, 'New York', 3);

--10.Create a new box with code "H5RT", containing "Papers" with 
--a value of $200, and located in warehouse 2
INSERT INTO Boxes (code, contents, value, warehouse) 
VALUES ('H5RT', 'Papers', 200, 2);

--11.Reduce the value of the third largest box by 15%
UPDATE Boxes
SET value = value * 0.85
WHERE code = (
    SELECT code FROM Boxes
    ORDER BY value DESC
    OFFSET 2 LIMIT 1
);

--12.Remove all boxes with a value lower than $150
DELETE FROM Boxes
WHERE value < 150;

--13.Remove all boxes located in New York (warehouse 3). 
--The statement should return all deleted data
DELETE FROM Boxes
WHERE warehouse = 3
RETURNING *;