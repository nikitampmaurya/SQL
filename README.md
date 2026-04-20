# MySQL Data Cleaning: Layoffs Dataset

## Project Overview

This repository contains two SQL projects built on the global tech layoffs (2022–2023) dataset.

Project 1 — Data Cleaning: The raw dataset contained duplicates, inconsistent formatting and missing values. The goal was to produce a clean, analysis-ready dataset using MySQL — without modifying the original table.

Project 2 — Exploratory Data Analysis (EDA): Using the cleaned dataset, this project discovers trends in global tech layoffs between 2020 and 2023 — identifying which companies, industries, countries, and funding stages were most affected, and how layoffs evolved over time.

## Dataset

1. Source: Global tech layoffs (2022–2023) dataset from Kaggle [Dataset link](https://www.kaggle.com/datasets/swaptr/layoffs-2022)
2. Raw records: 2,361 rows across 9 columns 
3. Fields: Company, location, industry, total laid off, percentage laid off, date, stage, country, funds raised

## Tools
- MySQL 
- Git bash

## File Structure
- `sql/DataCleaningProject.sql` : SQL script containing all cleaning steps.
- `sql/DataExploratoryProject.sql` : SQL script containing all exploratory steps.
- `layoffs.csv` : Dataset

## Key Results: Project 1 — Data Cleaning

- 5 duplicate rows removed.
- Removed inconsistencies from multiple columns (company, location, countries, industry).
- Changes the data type of the date column.
- Removed 361 rows where null appeared multiple times in the same row.
- Cleaned dataset with 1995 rows. 

## Key Results: Project 2 — Data Exploratory

- 2022 and 2023 saw the highest total layoffs, with a sharp spike in early 2023
- Consumer, Retail, and Transportation industries experienced the largest absolute layoffs
- Post-IPO companies accounted for a disproportionate share of total layoffs, suggesting large established tech firms cut heavily
- Several companies that raised hundreds of millions in funding still shut down entirely
- The rolling total reveals layoffs were concentrated in specific months rather than spread evenly
  
