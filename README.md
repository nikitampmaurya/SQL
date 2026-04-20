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

- Removed five duplicated entries. 
- Removed inconsistencies from company, location, countries, and industry columns.
- Changed the data type and format of the date column.
- Removed 361 rows where null appeared multiple times in the same entry
- Produced a cleaned dataset with 1995 rows. 

## Key Results: Project 2 — Data Exploratory

- Out of 1995 companies, 116 had completely shut down. Surprisingly, some of these weren't just small startups; a few had raised hundreds of millions in funding before closing.
- Amazon, Google, and Meta had the highest total layoffs. United States, India, and the Netherlands were the three most affected countries.
- Consumer and Retail were the hardest-hit industries by total employees laid off.
- 2022 was the worst year for layoffs.
- The top three companies that laid off by year are as follows:
- Uber, Booking.com & Groupon (2020)
- Bytedance, Katerra & Zillow (2021)
- Amazon, Cisco & Google (2022)
- Google, Microsoft & Ericsson (2023)
