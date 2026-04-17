USE world_layoffs; -- to use our previous database

SELECT * from layoffs_staging2; -- to use cleaned dataset/table

SELECT MAX(total_laid_off)
FROM layoffs_staging2; -- to find max no of people laid off

SELECT MAX(percentage_laid_off), MIN(percentage_laid_off)
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL; -- to identify max and min percent of lay off

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1; -- these companies could be start ups that got completely shut down

SELECT count(company)
FROM layoffs_staging2
WHERE percentage_laid_off = 1; -- total no of companies that were completely shut down

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC; -- to identify how big these companies were

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC; -- these company had the biggest layoffs

SELECT country, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY 2 DESC; -- in these country the most lay off were witnessed

SELECT *
FROM layoffs_staging2
WHERE date IS NULL;

SELECT YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
WHERE date IS NOT NULL
GROUP BY YEAR(date)
ORDER BY 1;

SET SQL_SAFE_UPDATES = 0; -- to switch off safe mode

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%d/%m/%Y'); -- to change format

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE; -- to change datatype

DESCRIBE layoffs_staging2; -- to view changes to date column

SELECT YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(date)
ORDER BY 2 DESC; -- to identify which year had most lay offs


SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC; -- to identify which industry has most lay offs

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC; -- to identify which stage had most lay offs

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