### 📊 Global Layoffs SQL Analysis  

This project explores a dataset of **global layoffs** using **MySQL** to uncover insights about workforce reductions across companies, industries, and countries.  
It demonstrates **SQL data exploration, stored procedures, CTEs, views, and window functions** while extracting **business-relevant insights**. 

### Key Takeaway and Business Insights 

### 1. Layoffs are highly concentrated in a small number of companies and industries  
- Risk is **industry-specific** (e.g., tech, retail, finance).  
- Investors should **diversify portfolios** across industries.  
- Companies must **rethink operating models** for efficiency and resilience.  

### 2. Some countries experienced significantly higher layoffs  
- Governments may need **policy interventions** such as retraining programs.  
- Businesses planning global expansion should assess **workforce stability** in target countries.  
- HR teams can shift **hiring hubs** to more stable regions.  

### 3. Layoffs span multiple years, showing sustained disruption  
- Indicates **structural change**, not a one-off event (automation, digital transformation, cost-cutting).  
- Companies should build **long-term workforce strategies**.  
- Training providers can step in to **reskill displaced workers**.  

### 4. Rolling totals reveal cumulative workforce reduction trends  
- Helps executives track the **pace of layoffs** (accelerating or stabilizing).  
- Steep cumulative totals may signal **market contraction** and reduced consumer spending.  
- Enables **scenario planning** for when industries may stabilize.  

### 5. Company rankings per year show recurring layoffs  
- Recurring layoffs highlight **organizational instability**.  
- Competitors can **attract laid-off talent** to strengthen their teams.  
- Investors can flag repeatedly affected companies as **high-risk**.

### Dataset  
- **Database**: `global_layoffs`  
- **Table**: `layoffs_staging_dedup`  
- Contains records of company layoffs with details such as `company`, `industry`, `country`, `date`, and `total_laid_off`.  

### SQL Techniques Used  
- Aggregations (`SUM`, `AVG`, `MIN`, `MAX`)  
- Grouping & Filtering (`GROUP BY`, `WHERE`)  
- Stored Procedure for parameterized queries  
- Window Functions (`ROW_NUMBER`, `DENSE_RANK`, `OVER`)  
- Common Table Expressions (CTEs)  
- Views for reusability and cleaner analysis  
