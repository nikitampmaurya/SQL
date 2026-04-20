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

- ## Steps Performed
1. Checked for duplicates and removed them.
2. Standardised text fields and dates.
3. Handled NULL values.
4. Removed irrelevant columns.
