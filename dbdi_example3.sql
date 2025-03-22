SELECT * FROM country;

SELECT * FROM city;

SELECT * FROM countrylanguage;

SELECT Code, Name, Continent FROM country;

SELECT ID, Name, District FROM city;

SELECT * FROM country WHERE Name='Brunei';

SELECT * FROM country WHERE Continent='Asia';

SELECT Code, Name FROM country WHERE Continent='Asia';

SELECT Code, Name, Population FROM country WHERE Continent='Europe';

SELECT Code, Name, IndepYear, 2025-IndepYear
FROM country WHERE Region='Southeast Asia';

SELECT Name, GNP, GNPOld, GNP-GNPOld
FROM country WHERE Region='Southeast Asia';

SELECT Name, GNP, GNPOld, (GNP-GNPOld)/GNPOld*100
FROM country WHERE Region='Southeast Asia';

SELECT Code, Name, IndepYear, 2025-IndepYear AS TotalYearsIndep
FROM country WHERE Region='Southeast Asia';

SELECT Code, Name, IndepYear, 2025-IndepYear 'TotalYearsIndep'
FROM country WHERE Region='Southeast Asia';

SELECT Code, Name, IndepYear 'Independent Year',
2025-IndepYear 'Total Years Independent'
FROM country WHERE Region='Southeast Asia';

SELECT CURDATE();

SELECT YEAR(CURDATE());

SELECT TRIM(" ABC ");

SELECT Code, Name, IndepYear 'Independent Year',
YEAR(CURDATE())-IndepYear 'Total Years Independent'
FROM country WHERE Region='Southeast Asia';

SELECT CONCAT(Code, ' - ', Name) AS 'Code And Name', SurfaceArea
FROM country WHERE Continent='Europe';

SELECT CONCAT(Code, ' - ', Name) AS 'Code And Name',
SurfaceArea*0.38 AS 'Surface Area (miles squared)'
FROM country WHERE Continent='Europe';

SELECT COUNT(*) FROM country;

SELECT * FROM country;

SELECT COUNT(*) FROM country WHERE Continent='Africa';

SELECT * FROM countrylanguage;

SELECT COUNT(*) FROM countrylanguage WHERE Language='English';

SELECT * FROM country;

SELECT DISTINCT Region FROM country;

SELECT COUNT(DISTINCT Region) FROM country;

SELECT COUNT(DISTINCT Continent) FROM country;

SELECT Region FROM country GROUP BY Region;

SELECT Region, COUNT(*) AS 'Number of Countries'
FROM country GROUP BY Region;

SELECT Code, Name, Population FROM country ORDER BY Population DESC;

SELECT Region, SUM(Population) AS 'TotalPopulation'
FROM country GROUP BY Region ORDER BY TotalPopulation DESC;