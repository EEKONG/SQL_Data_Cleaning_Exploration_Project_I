/*-- Exploring Columns to deal with the NULL and Blank values
-- Setting all columns with blank vlaues to NULL for easier update
-- Industry is the only column with a blank value

UPDATE layoffs_staging_dedup. 
SET industry = NULL
WHERE industry = '';

-- Checking to see if we can find another entry in table for similar country. if we do we can update the blank inputs
SELECT * FROM layoffs_staging_dedup WHERE company = 'Juul'; -- got an entry for Airbnb industry. Input is Travel

-- Confirming which Column entries are similar. We can infer/update the null values of the industry column if they have the same company value.
/*SELECT *
FROM layoffs_staging_dedup t1
JOIN layoffs_staging_dedup t2
	ON t1.company = t2.company
WHERE t1.industry IS NOT NULL AND t2.industry IS NOT NULL;

-- Updating the null values in the industry column
UPDATE layoffs_staging_dedup t1
JOIN layoffs_staging_dedup t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;*/