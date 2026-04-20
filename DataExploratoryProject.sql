USE world_layoffs; -- to use our previous database

SELECT * from layoffs_staging2; -- to use cleaned dataset/table

SELECT MAX(total_laid_off)
FROM layoffs_staging2; -- to find max no of people laid off

SELECT MAX(percentage_laid_off), MIN(percentage_laid_off)
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL; -- to identify max and min percent of lay off
-- there are companies with 0% and 100% lay offs 

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1; -- these companies could be start ups that got completely shut down

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1; -- total 116 no of companies that were completely shut down

SELECT count(company)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC; -- to identify how big these companies were

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC; -- these company (amazon, google meta are among top 3) had the biggest layoffs

SELECT country, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY 2 DESC; -- in these country (US, India, Netherlands are among top 3) the most lay off were witnessed

SELECT *
FROM layoffs_staging2
WHERE date IS NULL; -- there is one row where date is not given

SELECT YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
WHERE date IS NOT NULL
GROUP BY YEAR(date)
ORDER BY 1; -- major layoffs occured in 2022 followed by 2023.

DESCRIBE layoffs_staging2; -- to view changes to date column

SELECT YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(date)
ORDER BY 2 DESC; -- to identify which year had most lay offs


SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC; -- to identify which industry has most lay offs
-- Consumer and retail

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC; -- to identify which stage had most lay offs
-- Post-IPO stage has most laid  layoffs

WITH Company_Year AS
(
  SELECT company, YEAR(date) as years, SUM(total_laid_off) as total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(date)
),
Company_Year_Rank AS (
SELECT company, years, total_laid_off, 
DENSE_RANK () OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;

-- creating first table to calculate total layoffs per company per year
-- creating anoter table to rank companies within each year
-- to print only top three ranking companies in each year
-- in 2020, uber, booking.com and groupon had most lay offs
-- in 2021, bytedance, katerra and zillow
-- in 2022, amazon, cisco and google
-- in 2023, google, microsoft and ericsson 

WITH DATE_CTE AS 
(
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE date IS NOT NULL
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) as rolling_total_layoffs
FROM DATE_CTE;

-- first we extract year and month (YYYY-MM) from the date column
-- then we calculate total layoffs for each month

-- this info is stored in a temporary table

-- then we calculate total of layoffs over time
-- using a window function ordered by month in ascending order