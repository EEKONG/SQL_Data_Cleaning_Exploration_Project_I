-- Exploring columns for white spaces
SELECT company FROM layoffs_staging_dedup
ORDER BY 1;
SELECT location FROM layoffs_staging_dedup
ORDER BY 1;
SELECT industry FROM layoffs_staging_dedup;
SELECT total_laid_off FROM layoffs_staging_dedup
ORDER BY 1;
SELECT percentage_laid_off FROM layoffs_staging_dedup
ORDER BY 1;
SELECT stage FROM layoffs_staging_dedup
ORDER BY 1;
SELECT country FROM layoffs_staging_dedup
ORDER BY 1;
SELECT funds_raised_millions FROM layoffs_staging_dedup
ORDER BY 1;

-- Removing whitespaces using TRIM
UPDATE layoffs_staging_dedup
SET company = TRIM(company);

UPDATE layoffs_staging_dedup
SET location = TRIM(location);

UPDATE layoffs_staging_dedup
SET industry = TRIM(industry);

UPDATE layoffs_staging_dedup
SET percentage_laid_off = TRIM(percentage_laid_off);

UPDATE layoffs_staging_dedup
SET stage = TRIM(stage);

UPDATE layoffs_staging_dedup
SET country = TRIM(country);

UPDATE layoffs_staging_dedup
SET funds_raised_millions = TRIM(funds_raised_millions);

-- date column was imported as text. Re-formating date format, and then updating column data type to DATE

Select `date`, str_to_date(`date`, '%m/%d/%Y') as reformatted 
from layoffs_staging_dedup; -- comparing two date columns before updating format

-- update date column
 UPDATE layoffs_staging_dedup
SET `date` = str_to_date(`date`, '%m/%d/%Y');

-- Modifying date column from TEXT to DATE

ALTER TABLE layoffs_staging_dedup
MODIFY COLUMN `date` DATE; 

-- Cleaning up other elements of the table

-- input had 'Crypto', 'CryptoCurrency' and 'Crypto Currrency'. Standardizing it to 'Crypto'
UPDATE layoffs_staging_dedup
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%'; 

-- input had 'United States' and 'United States.'. Standardized to only have 'United States'
UPDATE layoffs_staging_dedup
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';





























