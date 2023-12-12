select * 
    from PortfolioProject..CovidDeath
	order by 3,4


select 
    location,date,
	total_cases,
	new_cases,total_deaths,
	population
from 
    PortfolioProject..CovidDeath
order by 
    1,2


select 
    location,date,
	total_cases,
	total_deaths,
	(total_deaths/total_cases)*100 as DeathPercentage
from 
    PortfolioProject..CovidDeath
order by 
    1,2

SELECT
    location,
    date,
    total_cases,
    total_deaths,
    (CAST(total_deaths AS float) / CAST(total_cases AS float)) * 100 AS DeathPercentage
FROM
    PortfolioProject..CovidDeath
ORDER BY
    location, date;

SELECT
    location,
    date,
    total_cases,
    total_deaths,
    (CAST(total_deaths AS float) / CAST(total_cases AS float)) * 100 AS DeathPercentage
FROM
    PortfolioProject..CovidDeath
where 
   location like '%states%'
ORDER BY
    location, date;



select 
    location,date,
	total_cases,
	population,
	(total_cases/population)*100 as PercentageofPopulation
from 
    PortfolioProject..CovidDeath
order by 
    1,2;

select 
    location,
	date,
	total_cases,
	population,
	(total_cases/population)*100 as PercentageofPopulation

from 
    PortfolioProject..CovidDeath

where 
    location like '%states%'

order by 
    1,2


select 
    location,
	population,
	max(total_cases) as Highestinfection,
	max((total_cases/population))*100 as PercentageofPopulation

from 
    PortfolioProject..CovidDeath

Group by 
    location,population

order by 
    PercentageofPopulation desc


select 
    location,
	max(cast(total_deaths as int)) as HighestDeathCount
from 
    PortfolioProject..CovidDeath
where
    continent is not null
Group by 
    location
order by 
    HighestDeathCount desc


select 
    continent,
	max(cast(total_deaths as int)) as HighestDeathCount
from 
    PortfolioProject..CovidDeath
where
    continent is not null
Group by 
    continent
order by 
    HighestDeathCount desc

select 
    location,
	max(cast(total_deaths as int)) as HighestDeathCount
from 
    PortfolioProject..CovidDeath
where
    continent is null
Group by 
    location
order by 
    HighestDeathCount desc

---Globally

select 
    date,
	total_cases,
	total_deaths,
	(cast(total_cases as int) / cast(total_deaths as int))*100 as PercentageofPopulation
from 
    PortfolioProject..CovidDeath
where 
    continent is not null
order by 
    1,2;

select 
    date,
	sum(new_cases)as Total_New_cases,
	sum(new_deaths) as New_deaths,
	sum(new_deaths)/sum(new_cases)*100 as DeathPercentage
from 
    PortfolioProject..CovidDeath
where 
    continent is not null
group by 
    date
order by 
    1,2;

SELECT 
    date,
    SUM(new_cases) AS Total_New_cases,
    SUM(new_deaths) AS Total_New_deaths,
    case
	   when SUM(new_cases) = 0 then 0
	   else SUM(new_deaths)/SUM(new_cases)*100
	end as DeathPercentage
FROM 
    PortfolioProject..CovidDeath
WHERE 
    continent IS NOT NULL
GROUP BY 
    date
ORDER BY 
    date, Total_New_cases;

---Covid Vaccianation 

select * from 
   PortfolioProject..CovidVaccination


select *
from 
    PortfolioProject..CovidDeath CD
join 
    PortfolioProject..CovidVaccination CV
	on CD.location = CV.location
	and CD.date = CD.date

select 
    CD.continent ,
	CD.location, 
	CD.date, 
	CD.population,
	CV.new_vaccinations
from 
    PortfolioProject..CovidDeath CD
join 
    PortfolioProject..CovidVaccination CV
	on CD.location = CV.location
	and CD.date = CD.date
where
    CD.continent is not null
order by 
    2,3

select 
    CD.continent ,
	CD.location, 
	CD.date, 
	CD.population,
	CV.new_vaccinations,
	sum(convert(int,CV.new_vaccinations)) over (partition by CD.location order by CD.location, CD.date) As Rolling_Total_Vaccinated
from 
    PortfolioProject..CovidDeath CD
join 
    PortfolioProject..CovidVaccination CV
	on CD.location = CV.location
	and CD.date = CD.date
where
    CD.continent is not null
order by 
    2,3



WITH PopvsVac (Continent, Location, Date, Population, new_vaccinations, Rolling_Total_Vaccinated)
AS
(
    SELECT 
        CD.continent,
        CD.location, 
        CD.date, 
        CD.population,
        CV.new_vaccinations,
        SUM(ISNULL(CONVERT(BIGINT, CV.new_vaccinations), 0)) OVER (PARTITION BY CD.location ORDER BY CD.location, CD.date) AS Rolling_Total_Vaccinated
    FROM 
        PortfolioProject..CovidDeath CD
    JOIN 
        PortfolioProject..CovidVaccination CV
    ON CD.location = CV.location
    AND CD.date = CV.date
    WHERE
        CD.continent IS NOT NULL
)

SELECT *, (Rolling_Total_Vaccinated/Population)*100 as Percentage
FROM PopvsVac;


drop table if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
    Continent nvarchar(255),
    Location nvarchar(255),
    Date datetime,
    Population numeric,
    New_vaccination numeric,
    Rolling_Total_Vaccinated numeric
);

INSERT INTO #PercentPopulationVaccinated
SELECT 
    CD.continent,
    CD.location, 
    CD.date, 
    CD.population,
    CV.new_vaccinations,
    SUM(ISNULL(CONVERT(BIGINT, CV.new_vaccinations), 0)) OVER (PARTITION BY CD.location ORDER BY CD.location, CD.date) AS Rolling_Total_Vaccinated
FROM 
    PortfolioProject..CovidDeath CD
JOIN 
    PortfolioProject..CovidVaccination CV
    ON CD.location = CV.location
    AND CD.date = CV.date

--WHERE CD.continent IS NOT NULL;

SELECT *, (Rolling_Total_Vaccinated/Population)*100 AS Percentage
FROM #PercentPopulationVaccinated;



CREATE VIEW dbo.PercentPopulationVaccinated
AS
SELECT 
    CD.continent,
    CD.location, 
    CD.date, 
    CD.population,
    CV.new_vaccinations,
    SUM(ISNULL(CONVERT(BIGINT, CV.new_vaccinations), 0)) OVER (PARTITION BY CD.location ORDER BY CD.location, CD.date) AS Rolling_Total_Vaccinated
FROM 
    PortfolioProject..CovidDeath CD
JOIN 
    PortfolioProject..CovidVaccination CV
    ON CD.location = CV.location
    AND CD.date = CV.date
WHERE 
    CD.continent IS NOT NULL;

select * from PercentPopulationVaccinated


