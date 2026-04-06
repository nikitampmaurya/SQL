-- DATA CLEANING PROJECT
-- DATASET: https://www.kaggle.com/datasets/swaptr/layoffs-2022

/* STEPS:
1. CHECK FOR DUPLICATES AND REMOVE IF ANY
2. STANDARDISE THE DATA 
3. HANDLE NULL VALUES
4. REMOVE IRRELEVANT COLUMNS AND ROWS
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

SET SQL_SAFE_UPDATES = 0; -- to switch off safe mode

DELETE FROM layoffs_staging2
WHERE ROW_NUM > 1; -- then deleting the duplicates

SELECT COUNT(*) FROM layoffs_staging2; -- total 2356 rows in new table

SELECT COUNT(*) FROM layoffs_staging; -- total 2361 rows in old table

