SELECT * FROM country WHERE Population >= 1000000;

SELECT * FROM country WHERE LifeExpectancy > 45.9;

SELECT * FROM country WHERE Population < 1000000;

SELECT * FROM country WHERE LifeExpectancy <= 45.9;

SELECT * FROM country WHERE Continent <> 'Asia';

SELECT * FROM country WHERE LifeExpectancy BETWEEN 38.3 AND 48.8;

SELECT * FROM country WHERE LifeExpectancy >= 38.3 
AND LifeExpectancy <= 48.8;

SELECT Continent, COUNT(*) FROM country
WHERE LifeExpectancy BETWEEN 38.3 AND 48.8 GROUP BY Continent;

SELECT * FROM country WHERE Continent='Asia'
OR Continent='Africa' OR Continent='North America';

SELECT * FROM country WHERE Continent
IN ('Asia', 'Africa', 'North America');

SELECT * FROM country WHERE IndepYear IS NULL;

SELECT * FROM country WHERE Name='Brunei';
SELECT * FROM country WHERE Name LIKE 'Brunei';
-- Wildcards:
-- _ represent a single letter
-- % represent any number of letters
SELECT * FROM country WHERE Name LIKE 'B%';
SELECT * FROM country WHERE Name LIKE 'B_____';
SELECT * FROM country WHERE Name LIKE 'B_u%';
SELECT * FROM country WHERE Name LIKE '%i';
SELECT * FROM country WHERE Name LIKE '%b%';

-- Country name that has letter 'b' and ends with 'ia'
SELECT * FROM country WHERE Name LIKE '%b%ia';

SELECT * FROM country WHERE Region LIKE '%europe%';

SELECT * FROM country WHERE Name LIKE 'b%' AND Continent='Europe';

SELECT * FROM country WHERE Name LIKE 'b%' OR Continent='Europe';

SELECT * FROM country WHERE Continent NOT IN ('Asia', 'Europe');

SELECT * FROM country WHERE Name NOT LIKE 'b%';

-- Bracket to override Rules of precedence
SELECT * FROM country WHERE (Name Like 'a%' OR Name Like 't%')
AND LifeExpectancy >= 50;

SELECT * FROM country ORDER BY IndepYear, Population DESC;

-- Join tables
SELECT * from country;
SELECT * from city;

SELECT * FROM country, city WHERE country.Code=city.CountryCode;

SELECT country.Code, country.name, country.continent,
city.CountryCode, city.name FROM country, city
WHERE country.Code=city.CountryCode;

SELECT a.Code, a.name, a.continent,
b.CountryCode, b.name FROM country a, city b
WHERE a.Code=b.CountryCode;

SELECT a.Code, a.name, a.continent,
b.CountryCode, b.name,
c.CountryCode, c.language, c.isOfficial
FROM country a, city b, countrylanguage c
WHERE a.Code=b.CountryCode AND a.Code=c.CountryCode
AND c.IsOfficial='T';

SELECT a.Code, a.name, b.CountryCode, b.name
FROM 
(SELECT * FROM country WHERE Name Like 'b%') a,
city b
WHERE a.Code=b.CountryCode;