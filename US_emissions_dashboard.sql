-- =========================================================
-- Databricks SQL
-- Project: US Greenhouse Gas Emissions Dashboard
-- Dataset: emissions_data_2023
-- Description:
--   This file contains all SQL queries used to build the
--   Databricks dashboard visualizing greenhouse gas (GHG)
--   emissions across the United States.
-- =========================================================
-- Databricks SQL
-- 1. Geospatial visualization of greenhouse gas emissions across the United States
-- Source table: default.emissions_data
-- Visualization: Map (latitude/longitude)
-- Metric: GHG emissions (million tons CO2e)

SELECT
    latitude,
    longitude,
    `GHG emissions mtons CO2e` AS emissions_mtons_co2e
FROM default.emissions_data;

-- ---------------------------------------------------------
-- 2. Emissions per Person
-- Visualization: Scatter plot (Emissions vs Population)
-- Metric: GHG emissions per capita (mtons CO2e per person)
-- ---------------------------------------------------------
SELECT
    county_state_name,
    population,
    CAST(REPLACE(`GHG emissions mtons CO2e`, ',', '') AS DOUBLE)
        / CAST(population AS DOUBLE) AS emissions_per_person
FROM emissions_data
WHERE population IS NOT NULL
ORDER BY emissions_per_person DESC;



-- ---------------------------------------------------------
-- 3. Total Emissions per State (Top 10)
-- Visualization: Pie chart
-- Metric: Total GHG emissions by state (mtons CO2e)
-- ---------------------------------------------------------
SELECT
    state_abbr,
    SUM(
        CAST(REPLACE(`GHG emissions mtons CO2e`, ',', '') AS DOUBLE)
    ) AS total_emissions
FROM emissions_data
GROUP BY state_abbr
ORDER BY total_emissions DESC
LIMIT 10;



-- ---------------------------------------------------------
-- 4. County "Shaming" (Top 10 Emitting Counties)
-- Visualization: Bar chart
-- Metric: Total GHG emissions by county (mtons CO2e)
-- ---------------------------------------------------------
SELECT
    county_state_name,
    population,
    CAST(REPLACE(`GHG emissions mtons CO2e`, ',', '') AS DOUBLE)
        AS total_emissions
FROM emissions_data
ORDER BY total_emissions DESC
LIMIT 10;
