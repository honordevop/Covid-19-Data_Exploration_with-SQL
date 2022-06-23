--Checking Out the data content randomly
-- First Table CovidDeaths (Has records related to Covid-19 Impact with respect to Death Count)
select
    *
from
    CovidDeaths
where
    continent is not null
order by
    3,
    4;

-- Second Table - CovidVaccinations (Has records related to Covid-19 detailing vaccination statistics)
select
    *
from
    CovidVaccinations
order by
    3,
    4;
select
    location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
from
    ProjectPortfolio..CovidDeaths
order by
    1,
    2;

--Exploratory Analysis

--Checkout Total Cases VS Total Death stating Percentage chances of dieing if contracted covid in your country
select
    location,
    date,
    total_cases,
    total_deaths,
    (total_deaths / total_cases) * 100 AS DeathPercentage
from
    ProjectPortfolio..CovidDeaths
order by
    1,
    2;

--Total cases VS Population
--Shows what percentage of the of pulation has covid
select
    location,
    date,
    population,
    total_cases,
    (total_cases / population) * 100 AS CasePerPopulationPercentage
from
    ProjectPortfolio..CovidDeaths
order by
    1,
    2;

--Checkout highest infection rate of a country compared to the population
select
    location,
    population,
    MAX(total_cases) as HighestInfectionCount,
    MAX((total_cases / population)) * 100 AS PercentagePopulationInfected
from
    ProjectPortfolio..CovidDeaths --where location like '%russ%'
GROUP BY
    location,
    population
order by
    4 DESC;

--Showing highest death count recorded per each country
select
    location,
    MAX(cast (total_deaths as int)) as HighestDeathCount
from
    ProjectPortfolio..CovidDeaths 
where
    continent is not null
GROUP BY
    location
order by
    2 DESC;

--Showing highest death count recorded based on continent
select
    continent,
    MAX(cast (total_deaths as int)) as HighestDeathCount
from
    ProjectPortfolio..CovidDeaths
where
    continent is not null
GROUP BY
    continent
order by
    2 DESC;


--Applying subquery method in getting global numbers to improve accuracy
SELECT
    date,
    SUM(new_cases) as total_cases,
    SUM(CAST(new_deaths as int)) as total_deaths,
    SUM(CAST(new_deaths as int)) / SUM(New_cases) * 100 as Deathpercentage
from
    ProjectPortfolio..CovidDeaths
where
    continent is not null
GROUP BY
    date
ORDER BY
    1,
    2;


--Personal Global numbers
Select
    SUM(population) AS world_population,
    SUM(total_cases) AS total_world_cases,
    SUM(total_deaths) AS total_world_deaths,
    (SUM(total_deaths) / SUM(total_cases)) * 100 AS world_Deathpercentage
FROM
    (
        SELECT
            location,
            population,
            SUM(new_cases) as total_cases,
            SUM(CAST(new_deaths as int)) as total_deaths,
            SUM(CAST(new_deaths as int)) / SUM(New_cases) * 100 as Deathpercentage
        from
            ProjectPortfolio..CovidDeaths
        where
            continent is not null
        GROUP BY
            location,
            population
    ) AS t1;


-- Lookint at Total Population vs Vaccinations
--Common Table Expression format
With PopsVac (
    Continent,
    location,
    date,
    population,
    new_vaccinations,
    running_total_vacinated
) as (
    Select
        cvd.continent,
        cvv.location,
        cvd.date,
        cvd.population,
        cvv.new_vaccinations,
        SUM(cast(cvv.new_vaccinations AS bigint)) OVER (
            PARTITION BY cvd.location
            ORDER BY
                cvd.location,
                cvd.date
        ) as running_total_vacinated
    FROM
        ProjectPortfolio..CovidDeaths AS cvd
        JOIN ProjectPortfolio..CovidVaccinations AS cvv ON cvd.location = cvv.location
        AND cvd.date = cvv.date
    where
        cvd.continent is not null
)