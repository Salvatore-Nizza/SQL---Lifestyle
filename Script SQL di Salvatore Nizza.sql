-- creazione tabella world_data_2023
-----------------------------------------
CREATE TABLE world_data_2023 (
    Country VARCHAR(255),
    "Density (P/Km2)" DECIMAL(10,2),
    abbreviation VARCHAR(10),
    "Agricultural Land (%)" DECIMAL(10,2),
    "Land Area (Km2)" INTEGER,
    "Armed Forces size" INTEGER,
    "Birth Rate" DECIMAL(10,2),
    "Calling Code" VARCHAR(20),
    "Capital/Major City" VARCHAR(255),
    "Co2-Emissions" INTEGER,
    cpi DECIMAL(10,2),
    "CPI Change (%)" DECIMAL(10,2),
    "Currency-Code" VARCHAR(10),
    "Fertility Rate" DECIMAL(10,2),
    "Forested Area (%)" DECIMAL(10,2),
    "Gasoline Price" DECIMAL(10,2),
    gdp INTEGER,
    "Gross primary education enrollment (%)" DECIMAL(10,2),
    "Gross tertiary education enrollment (%)" DECIMAL(10,2),
    "Infant mortality" DECIMAL(10,2),
    "Largest city" VARCHAR(255),
    "Life expectancy" DECIMAL(10,2),
    "Maternal mortality ratio" INTEGER,
    "Minimum wage" DECIMAL(15,2),
    "Official language" VARCHAR(255),
    "Out of pocket health expenditure percent" DECIMAL(15,2),
    "Physicians per thousand" DECIMAL(10,2),
    population INTEGER,
    "Population: Labor force participation (%)" DECIMAL(10,2),
    "Tax revenue (%)" DECIMAL(10,2),
    "Total tax rate" DECIMAL(10,2),
    "Unemployment rate" DECIMAL(10,2),
    "Urban_population" INTEGER,
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6)
);

SELECT * FROM world_data_2023;

SELECT COUNT(*) AS num_rows_2023 FROM world_data_2023;


-- creazione tabella GMMD
-----------------------------------------------
CREATE TABLE GMMD (
	"Incident Type" VARCHAR(255),
	"Incident year" INTEGER,
	"Reported Month" VARCHAR(255),
	"Region of Origin" VARCHAR(255),
	"Region of Incident" VARCHAR(255),
	"Country of Origin" VARCHAR(255),
	"Number of Dead" INTEGER,
	"Minimum Estimated Number of Missing" INTEGER,
	"Total Number of Dead and Missing" INTEGER,
	"Number of Survivors"INTEGER,
	"Number of Females" INTEGER,
	"Number of Males" INTEGER,
	"Number of Children" INTEGER,
	"Cause of Death" VARCHAR(255),
	"Migration route" VARCHAR(255),
	"Location of death" VARCHAR(255),
	"Information Source" VARCHAR(255),
	Coordinates VARCHAR(255),
	"UNSD Geographical Grouping" VARCHAR(255)
);

SELECT * FROM GMMD;

SELECT COUNT(*) AS num_rows_GMMD FROM GMMD;


-- creazione tabella GDOSE
-----------------------------------------------------------
CREATE TABLE GDOSE (
    Entity VARCHAR(255),
    Year VARCHAR(10),
    "Access to electricity (% of population)" DECIMAL(10,2),
    "Access to clean fuels for cooking" DECIMAL(10,2),
    "Renewable-electricity-generating-capacity-per-capita" DECIMAL(15,2),
    "Financial flows to developing countries (US $)" DECIMAL(20,2),
    "Renewable energy share in the total final energy consumption (%)" DECIMAL(10,2),
    "Electricity from fossil fuels (TWh)" DECIMAL(20,2),
    "Electricity from nuclear (TWh)" DECIMAL(20,2),
    "Electricity from renewables (TWh)" DECIMAL(20,2),
    "Low-carbon electricity (% electricity)" DECIMAL(10,2),
    "Primary energy consumption per capita (kWh/person)" DECIMAL(20,2),
    "Energy intensity level of primary energy (MJ/$2017 PPP GDP)" DECIMAL(20,2),
    Value_co2_emissions_kt_by_country DECIMAL(20,2),
    "Renewables (% equivalent primary energy)" DECIMAL(10,2),
    gdp_growth DECIMAL(10,2),
    gdp_per_capita DECIMAL(20,2),
    "Density(P/Km2)" DECIMAL(10,2),
    "Land Area(Km2)" DECIMAL(20,2),
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6)
);

SELECT * FROM GDOSE;

SELECT COUNT(*) AS num_rows_GDOSE FROM GDOSE;


-- UNIONE TABELLE world_data_2023 e GDOSE
CREATE TABLE comparison_2019_2023 AS   
SELECT DISTINCT
    wd.Country,
    wd."Land Area (Km2)",
    wd."Co2-Emissions" AS "Co2-Emissions-2023",
    wd.gdp AS gdp_2023,
    wd.population,
    g.Value_co2_emissions_kt_by_country AS "Co2-Emissions-2019",
    g.gdp_per_capita AS gdp_per_capita_2019
FROM
    world_data_2023 wd
INNER JOIN
    GDOSE g ON wd.Country = g.Entity
WHERE
    g.Year = 2019;

SELECT * FROM comparison_2019_2023;


-- EMISSIONI CO2
-------------------------------------------------------------------------------------------------------------------------------------------------


-- classifica dei paesi con più di emissioni di CO2 pro capite nel 2023
-- (il moltiplicatore 1000000 serve per poter portare l'unità di misura in kg di CO2 ogni mille abitanti)
-------------------------------------------------------------------------------------------------------------
SELECT DISTINCT Country, "Co2-Emissions", population, 
       "Co2-Emissions" * 1000000 / population AS "Co2-Emissions/per-capita"
FROM world_data_2023
WHERE "Co2-Emissions" IS NOT NULL AND population IS NOT NULL AND population <> 0
ORDER BY "Co2-Emissions/per-capita" DESC;
-- nelle prime 10 posizioni sono presenti ben 5 paesi estrattori di petrolio e gas naturale


-- totale delle emissioni di CO2 nel 2023
--------------------------------------------
SELECT SUM("Co2-Emissions") AS "Total-CO2-Emissions2023"
FROM world_data_2023 wd;
-- Nel 2023 le emissioni di CO2 sono state pari a 33.403.280 tonnellate


-- totale delle emissioni di CO2 per ogni anno dal 2000 al 2020
----------------------------------------------------------------
SELECT Year, CAST(SUM(Value_co2_emissions_kt_by_country) AS integer) AS "Total-CO2-Emissions-by-year"
FROM GDOSE g 
GROUP BY Year
ORDER BY "Total-CO2-Emissions-by-year" DESC;


-- differenza di emissioni di CO2 nel periodo 2000 - 2019 per ogni nazione
-- se la differenza è positiva vuol dire che c'è stato un aumento delle emissioni, viceversa una diminuzione
--------------------------------------------------------------------------------------------------------------
SELECT
    Entity,
    CAST(
        MAX(CASE WHEN Year = 2019 THEN Value_co2_emissions_kt_by_country END) -
        MAX(CASE WHEN Year = 2000 THEN Value_co2_emissions_kt_by_country END)
        AS INTEGER
    ) AS differenza_emissioni_2000_2019
FROM
    GDOSE
WHERE
    Year IN (2019, 2000) AND Value_co2_emissions_kt_by_country IS NOT NULL
GROUP BY
    Entity
ORDER BY
    differenza_emissioni_2000_2019 DESC;
   
   
-- ELETTRICITA'  
-------------------------------------------------------------------------------------------------------------------------------------------------
   
-- differenza della percentuale di popolazione che ha avuto accesso all'elettricità nel periodo 2000 - 2019 per ogni nazione
-------------------------------------------------------------------------------------------------------------------------------
SELECT
    Entity,
    CAST(
        ROUND(MAX(CASE WHEN Year = 2019 THEN "Access to electricity (% of population)" END) -
        MAX(CASE WHEN Year = 2000 THEN "Access to electricity (% of population)" END),
        2) AS DECIMAL(10,2)
    ) AS differenza_access_to_electricity_2000_2019
FROM
    GDOSE
WHERE
    Year IN (2019, 2000) AND "Access to electricity (% of population)" IS NOT NULL
GROUP BY
    Entity
ORDER BY
    differenza_access_to_electricity_2000_2019 DESC;
   

-- totale dell'energia elettrica derivante da combustibili fossili per ogni anno dal 2000 al 2020
---------------------------------------------------
SELECT Year, CAST(SUM("Electricity from fossil fuels (TWh)") AS integer) AS Total_fossil_electricity_by_year
FROM GDOSE g 
GROUP BY Year
ORDER BY Total_fossil_electricity_by_year DESC;

      
-- totale dell'energia elettrica derivante dal nucleare per ogni anno dal 2000 al 2020
---------------------------------------------------
SELECT Year, CAST(SUM("Electricity from nuclear (TWh)") AS integer) AS Total_nuclear_electricity_by_year
FROM GDOSE g 
GROUP BY Year
ORDER BY Total_nuclear_electricity_by_year DESC;   
   

-- totale dell'energia elettrica derivante dalle rinnovabili per ogni anno dal 2000 al 2020
---------------------------------------------------
SELECT Year, CAST(SUM("Electricity from renewables (TWh)") AS integer) AS Total_renewables_electricity_by_year
FROM GDOSE g 
GROUP BY Year
ORDER BY Total_renewables_electricity_by_year DESC;
   


-- differenza di emissioni di CO2 nel periodo 2019 - 2023 per ogni nazione 
-------------------------------------------------------------------------------------------------------------------------------
SELECT
    Country,
    CAST("Co2-Emissions-2023" - "Co2-Emissions-2019" AS INTEGER) AS differenza_emissioni_2019_2023
FROM
    comparison_2019_2023
WHERE
    "Co2-Emissions-2023" IS NOT NULL AND "Co2-Emissions-2019" IS NOT NULL
GROUP BY
    Country
ORDER BY
    differenza_emissioni_2019_2023 DESC;


-- differenza del GDP nel periodo 2019 - 2023 per ogni nazione
-------------------------------------------------------------------------------------------------------------------------------
SELECT
    Country,
    CAST((gdp_2023 / population) - gdp_per_capita_2019 AS INTEGER) AS differenza_gdp_2019_2023
FROM
    comparison_2019_2023
WHERE
    gdp_2023 IS NOT NULL
    AND population IS NOT NULL AND population > 0
    AND gdp_per_capita_2019 IS NOT NULL AND gdp_per_capita_2019 > 0
GROUP BY
    Country
ORDER BY
    differenza_gdp_2019_2023 DESC;


--CORRELAZIONI
-------------------------------------------------------------------------------------------------------------------------------------------------

   
--EMISSIONI - DENSITA' POPOLAZIONE 2023
-------------------------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT Country, "Co2-Emissions", "Density (P/Km2)"
FROM world_data_2023 wd
WHERE "Co2-Emissions" IS NOT NULL AND "Density (P/Km2)" IS NOT NULL
ORDER BY "Density (P/Km2)" DESC;


--EMISSIONI - GDP 2023
-------------------------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT Country, "Co2-Emissions", (gdp / population) AS gdp_per_capita_23
FROM world_data_2023 wd
WHERE "Co2-Emissions" IS NOT NULL AND gdp IS NOT NULL AND population IS NOT NULL
ORDER BY gdp_per_capita_23 DESC;


--CORRELAZIONE GDP - SALUTE 2023
---------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT Country, "Fertility Rate", "Infant mortality", "Life expectancy", "Maternal mortality ratio", 
	gdp/population AS gdp_per_capita_2023
FROM world_data_2023 wd
WHERE gdp IS NOT NULL AND population IS NOT NULL
ORDER BY "Life expectancy" DESC;    -- SOSTITUIBILE CON LE ALTRE COLONNE SELEZIONATE


-------------------------------------------------------------------------------------------------------------------------------------------------


-- GMMD

-- Numero morti, dispersi, sopravvissuti per anno
---------------------------------------------------------------------------------------------------------------------------
SELECT "Incident year",
	SUM("Total Number of Dead and Missing") AS numero_totale_morti_dispersi,
	SUM("Number of Dead") AS numero_morti,
	SUM("Minimum Estimated Number of Missing") AS numero_dispersi,
	SUM("Number of Survivors") AS numero_sopravvissuti
FROM GMMD g 
GROUP BY "Incident year"
ORDER BY "Incident year";


-- Numero morti, dispersi, sopravvissuti in base a rotta migratoria
----------------------------------------------------------------------------------------------------------------------------
SELECT "Migration route",
    SUM("Total Number of Dead and Missing") AS numero_totale_morti_dispersi,
    SUM("Number of Dead") AS numero_morti,
    SUM("Minimum Estimated Number of Missing") AS numero_dispersi,
    SUM("Number of Survivors") AS numero_sopravvissuti
FROM GMMD g 
GROUP BY "Migration route"
ORDER BY numero_totale_morti_dispersi DESC;


-- Numero morti, dispersi, sopravvissuti in base a regione di origine
----------------------------------------------------------------------------------------------------------------------------
SELECT "Region of Origin",
    SUM("Total Number of Dead and Missing") AS numero_totale_morti_dispersi,
    SUM("Number of Dead") AS numero_morti,
    SUM("Minimum Estimated Number of Missing") AS numero_dispersi,
    SUM("Number of Survivors") AS numero_sopravvissuti
FROM GMMD g 
GROUP BY "Region of Origin"
ORDER BY numero_totale_morti_dispersi DESC;


--CORRELAZIONE MORTI - GDP
-------------------------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT Country, (gdp / population) AS gdp_per_capita_23
FROM world_data_2023 wd
WHERE gdp IS NOT NULL AND population
ORDER BY gdp_per_capita_23;
--CONFERMA CHE LE ROTTE MIGRATORIE IN CUI SI HANNO PIù MORTI DERIVANO DALLO SPOSTAMENTO DAI PAESI PIù POVERI