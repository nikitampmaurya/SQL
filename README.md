# MySQL Data Cleaning: Layoffs Dataset

## Project Overview

This repository contains two SQL projects built on the global tech layoffs (2022–2023) dataset sourced from Kaggle: [Dataset link](https://www.kaggle.com/datasets/swaptr/layoffs-2022)

Project 1 — Data Cleaning: The raw dataset contained duplicates, inconsistent formatting and missing values. The goal was to produce a clean, analysis-ready dataset using MySQL — without modifying the original table.

Project 2 — Exploratory Data Analysis (EDA): Using the cleaned dataset, this project discovers trends in global tech layoffs between 2020 and 2023 — identifying which companies, industries, countries, and funding stages were most affected, and how layoffs evolved over time.



## Steps Performed
1. Checked for duplicates and removed them.
2. Standardised text fields and dates.
3. Handled NULL values.
4. Removed irrelevant columns.

## Tools
- MySQL 
- Git bash

## File Structure
- `sql/DataCleaningProject.sql` : SQL script containing all cleaning steps.
- `layoffs.csv` : Dataset
