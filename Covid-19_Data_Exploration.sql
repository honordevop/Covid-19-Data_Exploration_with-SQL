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