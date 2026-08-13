

-- 1) KPI Requirements

-- KPI 1: Percentage of Smokers
SELECT 
    ROUND(COUNT(CASE WHEN Smoking_Status = 'smoker' THEN 1 END) * 100.0 / COUNT(*), 2) AS Percentage_of_Smokers
FROM cleaned_health_data;


-- KPI 2: Percentage of people with BMI 25 or higher
SELECT 
    ROUND(COUNT(CASE WHEN BMI >= 25 THEN 1 END) * 100.0 / COUNT(*), 2) AS Percentage_BMI_25_or_Higher
FROM cleaned_health_data;


-- KPI 3: Average BMI
SELECT ROUND(AVG(BMI), 2) AS Average_BMI
FROM cleaned_health_data;


-- KPI 4: Average LDL Cholesterol
SELECT ROUND(AVG(LDL_Cholesterol), 2) AS Average_LDL_Cholesterol
FROM cleaned_health_data;


-- KPI 5: Average Triglycerides
SELECT ROUND(AVG(Triglycerides), 2) AS Average_Triglycerides
FROM cleaned_health_data;



-- 2) Business Questions

-- Q1 : Number of smokers vs non-smokers
SELECT 
    Smoking_Status, 
    COUNT(*) AS Number_of_People
FROM cleaned_health_data
GROUP BY Smoking_Status;


-- Q2 : Number of people in each physical activity level (Low, Moderate, High)
SELECT 
    Physical_Activity_Level, 
    COUNT(*) AS Number_of_People
FROM cleaned_health_data
GROUP BY Physical_Activity_Level;


-- Q3 : Number of people with BMI greater than or equal to 25
SELECT COUNT(*) AS People_With_BMI_25_or_More
FROM cleaned_health_data
WHERE BMI >= 25;


-- Q4 : For each physical activity level, number of people who are Overweight or Obese
SELECT 
    Physical_Activity_Level,
    COUNT(*) AS Overweight_or_Obese_Count
FROM cleaned_health_data
WHERE BMI_Category IN ('Overweight', 'Obese')
GROUP BY Physical_Activity_Level;


-- Q5 : Difference in average LDL between smokers and non-smokers
SELECT 
    Smoking_Status,
    ROUND(AVG(LDL_Cholesterol), 2) AS Average_LDL
FROM cleaned_health_data
GROUP BY Smoking_Status;


-- Q6 : For each physical activity level, number of people with high triglycerides (above 150)
SELECT 
    Physical_Activity_Level,
    COUNT(*) AS High_Triglycerides_Count
FROM cleaned_health_data
WHERE Triglycerides > 150
GROUP BY Physical_Activity_Level;


-- Q7 : Which physical activity level has the highest percentage of people with BMI >= 25
SELECT 
    Physical_Activity_Level,
    ROUND(COUNT(CASE WHEN BMI >= 25 THEN 1 END) * 100.0 / COUNT(*), 2) AS Percentage_BMI_25_or_More
FROM cleaned_health_data
GROUP BY Physical_Activity_Level
ORDER BY Percentage_BMI_25_or_More DESC;
