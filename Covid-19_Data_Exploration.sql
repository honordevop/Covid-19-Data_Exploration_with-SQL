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