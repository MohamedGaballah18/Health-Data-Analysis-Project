------KPI 1  :Total Number of People
SELECT COUNT(*) AS Total_Number_Of_People
FROM cleaned_health_data;


------ KPI 2 :Average BMI
SELECT ROUND(AVG(BMI),2) AS AVERAGE_BMI
FROM cleaned_health_data;

-------KPI 3 : Average Systolic Blood Preasure
SELECT ROUND(AVG(Systolic_BP),2) AS Average_Systolic_BP
FROM cleaned_health_data;

-------KPI 4 : Average Diastolic Blood Preasure
SELECT ROUND(AVG(Diastolic_BP),2) AS Average_Diastolic_BP
FROM cleaned_health_data;

-------KPI 5: Average Total Cholesterol
SELECT ROUND(AVG(Total_Cholesterol), 2) AS Average_Total_Cholesterol
FROM cleaned_health_data;

-----------ANALTIC QUESTIONS 
-------- Q1 :How many people are included in the dataset?
SELECT COUNT(*) AS Number_Of_People
FROM cleaned_health_data;

--------- Q2 : How many people are smokers and how many are non-smokers?

SELECT Smoking_Status, COUNT(*) AS Number_Of_People
FROM cleaned_health_data
GROUP BY Smoking_Status;

----- Q3 :How many people belong to each physical activity level?
-- =====================================================
SELECT Physical_Activity_Level, COUNT(*) AS Number_Of_People
FROM cleaned_health_data
GROUP BY Physical_Activity_Level;
------ Q4 : How are people distributed across BMI categories (Underweight, Normal, Overweight, Obese)?
SELECT BMI_Category, COUNT(*) AS Number_Of_People
FROM cleaned_health_data
GROUP BY BMI_Category;
------ Q5 : How many people have desirable total cholesterol and how many have high total cholesterol?(Desirable: less than 200, High: 200 or more)

SELECT
    CASE
        WHEN Total_Cholesterol < 200 THEN 'Desirable'
        ELSE 'High'
    END AS Cholesterol_Level,
    COUNT(*) AS Number_Of_People
FROM cleaned_health_data
GROUP BY
    CASE
        WHEN Total_Cholesterol < 200 THEN 'Desirable'
        ELSE 'High'
    END;


------- Q6 : How many people have normal systolic blood pressure and how many have elevated or high systolic blood pressure?(Using the BP_Risk_Category column that is already in the data)
SELECT BP_Risk_Category, COUNT(*) AS Number_Of_People
FROM cleaned_health_data
GROUP BY BP_Risk_Category;

------- Q7 : What percentage of the population falls into each BMI-based health category?

SELECT
    BMI_Category,
    COUNT(*) AS Number_Of_People,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM cleaned_health_data), 2) AS Percentage
FROM cleaned_health_data
GROUP BY BMI_Category;



