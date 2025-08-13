-- Create first staging table from raw table
/*  CREATE TABLE layoffs_staging
	LIKE layoffs; */

-- Copy data from raw table into staging table
/* INSERT INTO layoffs_staging
SELECT * FROM layoffs; */

-- Identify duplicate values using CTE
/* WITH duplicate_val_cte as (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
) as row_num
FROM layoffs_staging
)
DELETE FROM duplicate_val_cte WHERE row_num > 1; */

-- Cannot delete duplicate entry using CTE
-- Creating another staging table
-- CREATE TABLE layoffs_staging_dedup AS
-- SELECT DISTINCT * FROM layoffs_staging;

/* SELECT COUNT(*) FROM layoffs_staging;
SELECT COUNT(*) FROM layoffs_staging_dedup;

SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging_dedup;

SELECT * from layoffs_staging_dedup order by company; */



DELETE FROM layoffs_staging_dedup2
WHERE row_num > 1;





