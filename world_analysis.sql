USE world;

-- Question 1: Count how many cities are there in each country

SELECT
c.Name AS Country,
COUNT(ci.ID) AS City_Count
FROM Country c
LEFT JOIN City ci
ON c.Code = ci.CountryCode
GROUP BY c.Name
ORDER BY City_Count DESC
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/q1_cities_per_country.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


-- Question 2: Continents having more than 30 countries

SELECT
Continent,
COUNT(*) AS Country_Count
FROM Country
GROUP BY Continent
HAVING COUNT(*) > 30
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/q2_continents_30_plus.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


-- Question 3: Regions with total population > 200 million

SELECT
Region,
SUM(Population) AS Total_Population
FROM Country
GROUP BY Region
HAVING SUM(Population) > 200000000
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/q3_regions_population.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


-- Question 4: Top 5 continents by average GNP per country

SELECT
Continent,
AVG(GNP) AS Avg_GNP
FROM Country
WHERE GNP IS NOT NULL
GROUP BY Continent
ORDER BY Avg_GNP DESC
LIMIT 5
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/q4_top5_avg_gnp.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


-- Question 5: Total number of official languages per continent

SELECT
c.Continent,
COUNT(DISTINCT cl.Language) AS Official_Languages
FROM Country c
JOIN CountryLanguage cl
ON c.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T'
GROUP BY c.Continent
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/q5_official_languages.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


-- Question 6: Maximum and minimum GNP per continent

SELECT
Continent,
MAX(GNP) AS Max_GNP,
MIN(GNP) AS Min_GNP
FROM Country
WHERE GNP IS NOT NULL
GROUP BY Continent
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/q6_min_max_gnp.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


-- Question 7: Country with highest average city population

SELECT
c.Name AS Country,
AVG(ci.Population) AS Avg_City_Population
FROM Country c
JOIN City ci
ON c.Code = ci.CountryCode
GROUP BY c.Name
ORDER BY Avg_City_Population DESC
LIMIT 1
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/q7_highest_avg_city_pop.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


-- Question 8: Continents where average city population > 200,000

SELECT
c.Continent,
AVG(ci.Population) AS Avg_City_Population
FROM Country c
JOIN City ci
ON c.Code = ci.CountryCode
GROUP BY c.Continent
HAVING AVG(ci.Population) > 200000
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/q8_avg_city_pop_200k.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


-- Question 9: Total population & average life expectancy per continent

SELECT
Continent,
SUM(Population) AS Total_Population,
AVG(LifeExpectancy) AS Avg_Life_Expectancy
FROM Country
GROUP BY Continent
ORDER BY Avg_Life_Expectancy DESC
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/q9_population_life_expectancy.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


-- Question 10: Top 3 continents by avg life expectancy
-- (Total population > 200 million)

SELECT
Continent,
AVG(LifeExpectancy) AS Avg_Life_Expectancy,
SUM(Population) AS Total_Population
FROM Country
GROUP BY Continent
HAVING SUM(Population) > 200000000
ORDER BY Avg_Life_Expectancy DESC
LIMIT 3
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/q10_top3_life_expectancy.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
