-- We need the values for total_laid_ off and percentage_laid_off to not both be NULL at the same time. These are two key columns for our analysis
-- ONLY one can be NULL at a time
SELECT * 
FROM layoffs_staging_dedup 
WHERE total_laid_off IS NULL and percentage_laid_off IS NULL; -- gives the rows where both columns are NULL

SELECT COUNT(*) 
FROM layoffs_staging_dedup
WHERE total_laid_off IS NULL and percentage_laid_off IS NULL; -- 361 entries fit this criteria

DELETE FROM layoffs_staging_dedup
WHERE total_laid_off IS NULL and percentage_laid_off IS NULL; -- Deleting 361 rows we do not need

-- Our data is now ready for some analysis. There are still some NULL values in our table. We will leave them for now (Depending on the stakeholder criteria we can remove entries with NULL values).
-- lets check table again
Select * from layoffs_staging_dedup; 
