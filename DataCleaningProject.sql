-- DATA CLEANING PROJECT
-- DATASET: https://www.kaggle.com/datasets/swaptr/layoffs-2022

/* STEPS:
1. CHECK FOR DUPLICATES AND REMOVE IF ANY
2. STANDARDISE THE DATA 
3. HANDLE NULL VALUES
4. REMOVE ROWS where most column are null values 
*/

SHOW DATABASES; -- to lists all the databases

USE world_layoffs;

SELECT * FROM layoffs; -- to view the original dataset

-- Let's perform deep cloning 

CREATE TABLE layoffs_staging LIKE layoffs; -- copy of original dataset

INSERT INTO layoffs_staging
SELECT * FROM layoffs; -- copy all the data from the original dataset

SELECT * FROM layoffs_staging; -- to view the clone

DESCRIBE layoffs_staging; -- to view datatypes of each column

SELECT count(*) FROM layoffs_staging; -- total 2361 rows

-- Step 1: 

-- TO FILTER DUPLICATES FROM ORIGINAL TABLE

SELECT *
FROM ( SELECT company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions,
	  ROW_NUMBER() OVER (
      PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
                         ) AS ROW_NUM
      FROM layoffs_staging
      ) DUPLICATES
WHERE ROW_NUM > 1;

-- to create a clone of original table with same structure and ROW_NUM

CREATE TABLE layoffs_staging2 (
company TEXT,
location TEXT,
industry TEXT,
total_laid_off INT,
percentage_laid_off TEXT,
date TEXT,
stage TEXT,
country TEXT,
funds_raised_millions INT,
row_num INT
);

-- to insert all values from original table + calculate row numbers for duplicates

INSERT INTO layoffs_staging2
(company,
location,
industry,
total_laid_off,
percentage_laid_off,
`date`,
stage,
country,
funds_raised_millions,
row_num
)
SELECT company,
location,
industry,
total_laid_off,
percentage_laid_off,
`date`,
stage,
country,
funds_raised_millions,
       ROW_NUMBER() OVER (
       PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
       ) AS ROW_NUM
	FROM layoffs_staging;
    
SELECT * FROM layoffs_staging2; -- to view new table 

SELECT count(*) FROM layoffs_staging2; -- total 2361 rows

SET SQL_SAFE_UPDATES = 0; -- to switch off safe mode

DELETE FROM layoffs_staging2
WHERE ROW_NUM > 1; -- then deleting the duplicates

SELECT COUNT(*) FROM layoffs_staging2; -- total 2356 rows in new table

SELECT COUNT(*) FROM layoffs_staging; -- total 2361 rows in old table

-- Step 2: Standardise the data and Step 3: Handle null values 

SELECT COUNT(*)
FROM layoffs_staging2
WHERE company <> TRIM(company); -- total 10 rows with spaces

UPDATE layoffs_staging2
set company = TRIM(company); -- removed spaces 

SELECT DISTINCT(industry)
FROM layoffs_staging2; -- to view unique industry 

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry IN ('Crypto Currency', 'CryptoCurrency'); -- to keep only type of Crypto industry

-- to check where industry is null or empty 
SELECT *
FROM layoffs_staging2
WHERE industry is NULL
OR industry = ''; 

-- to fill empty row of industry with null
UPDATE layoffs_staging2
SET INDUSTRY = NULL
WHERE INDUSTRY LIKE '';

SELECT DISTINCT(country)
FROM layoffs_staging2; -- to check for inconsistencies within country column

-- to remove dot from the end of country
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country like "United States%";

SELECT DISTINCT(location)
FROM layoffs_staging2; -- to check for inconsistences within location column

UPDATE layoffs_staging2
SET location = "Floripa"
WHERE location like "Flori%";

Update layoffs_staging2
SET location = 'Dusseldorf'
WHERE location = "DÃ¼sseldorf"; 

Update layoffs_staging2
SET location = 'Malmo'
WHERE location = "MalmÃ¶"; 

-- changing date format of date column
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y'); -- convert date to a proper DATE type

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE; -- change date type of data column

-- Step 4: Removing rows with null values

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL; -- to check for null values in total_laid_off column

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL; -- to check for null values in both columns

-- now deleting rows data where value were null for both columns
DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT count(*) 
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT * 
FROM layoffs_staging2;

DESCRIBE layoffs_staging2;
