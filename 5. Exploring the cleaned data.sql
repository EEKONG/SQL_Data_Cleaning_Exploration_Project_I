use global_layoffs;

-- lets see what we have in the table
SELECT * FROM layoffs_staging_dedup;

-- LETS BEGIN TO EXPLORE!!!

-- 1. Lets see the Top 5 companies with the highest Lay offs
SELECT company, SUM(total_laid_off) as Total_Layoffs 
FROM layoffs_staging_dedup 
GROUP BY company
ORDER BY Total_Layoffs DESC
LIMIT 5;

-- 2. Stored procedure to see total layoffs when country inputted
DROP PROCEDURE IF EXISTS total_layoffs_by_country;
DELIMITER $$
CREATE PROCEDURE total_layoffs_by_country(IN input_country VARCHAR(56))
BEGIN
		SELECT 
			CASE
				WHEN SUM(total_laid_off) IS NULL THEN 'No data available'
                ELSE SUM(total_laid_off)
			END AS Total_Layoffs
        FROM layoffs_staging_dedup
        WHERE country = input_country;
END $$

DELIMITER ;
CALL total_layoffs_by_country('Canada');

-- 3.  Which 3 industries got hit the most with layoffs
SELECT industry, SUM(total_laid_off) as Layoff_By_Industry
FROM layoffs_staging_dedup
GROUP BY industry
ORDER BY 2 DESC
LIMIT 3;

-- 4. Date range of these layoffs
SELECT MIN(`date`) Layoffs_Start, MAX(`date`) Layoffs_End
FROM layoffs_staging_dedup;

-- 5. Average layoff per year
SELECT YEAR(`date`) as `Year`, ROUND(AVG(total_laid_off), 2) as Avg_Total_Laid_Off
FROM layoffs_staging_dedup
WHERE YEAR(`date`) IS NOT NULL
GROUP BY `Year`
ORDER BY `Year`; 

-- 6. Total layoffs per year
SELECT YEAR(`date`) as `Year`, SUM(total_laid_off)as TotalLaidOff
FROM layoffs_staging_dedup
WHERE YEAR(`date`) IS NOT NULL 
GROUP BY `Year`
ORDER BY 1; 

-- 7. Lets see total layoffs per month
SELECT DATE_FORMAT(`date`, '%Y-%b') as `Month`, SUM(total_laid_off) as TotalLaidOff
FROM layoffs_staging_dedup
WHERE `date` IS NOT NULL -- Removing NULL values from result
GROUP BY DATE_FORMAT(`date`, '%Y-%b')
ORDER BY MIN(`date`) ASC;


-- 8. Rolling total using CTE
WITH Rolling_Total AS (
SELECT SUBSTRING(`date`, 1, 7) as `Month`, SUM(total_laid_off) as TotalLaidOff
FROM layoffs_staging_dedup
WHERE `date` IS NOT NULL -- Removing NULL values from result
GROUP BY SUBSTRING(`date`, 1, 7)
ORDER BY 1 ASC
) SELECT `Month`, TotalLaidOff, SUM(TotalLaidOff) OVER(ORDER BY `Month`) AS RollingTotal
FROM Rolling_Total; 

-- 9. Lets See company layoffs by year and get the top 5. We will do this using by creating a view and also using CTE
-- Using a view to check total company layoffs per year
CREATE VIEW CompanyLayoffs_PerYear AS
SELECT company, YEAR(`date`) AS `Year`, SUM(total_laid_off) as TotalLaidOff
FROM layoffs_staging_dedup
GROUP BY company, YEAR(`date`)
ORDER BY `Year` ASC;

-- Now lets rank the companies
SELECT *, 
DENSE_RANK() OVER(PARTITION BY `Year` ORDER BY TotalLaidOFF DESC) as Ranking
FROM CompanyLayoffs_PerYear
WHERE `Year` IS NOT NULL; 

-- Now lets rank the companies Lets see the TOP 5 for each year using CTE
WITH CompanyLayoffs_Top5 AS (
SELECT *, 
DENSE_RANK() OVER(PARTITION BY `Year` ORDER BY TotalLaidOFF DESC) as Ranking
FROM CompanyLayoffs_PerYear
WHERE `Year` IS NOT NULL
)
SELECT * 
FROM CompanyLayoffs_Top5
WHERE Ranking <=5;

