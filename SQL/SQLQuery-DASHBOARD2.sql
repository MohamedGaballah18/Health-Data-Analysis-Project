
-- KPI 1: Average Systolic Blood Pressure
SELECT ROUND(AVG(Systolic_BP), 2) AS Average_Systolic_BP
FROM cleaned_health_data;

-- KPI 2: Average Diastolic Blood Pressure
SELECT ROUND(AVG(Diastolic_BP), 2) AS Average_Diastolic_BP
FROM cleaned_health_data;

-- KPI 3: Highest Systolic Blood Pressure

SELECT MAX(Systolic_BP) AS Highest_Systolic_BP
FROM cleaned_health_data;

-- KPI 4: Highest Diastolic Blood Pressure

SELECT MAX(Diastolic_BP) AS Highest_Diastolic_BP
FROM cleaned_health_data;

-- KPI 5: Percentage With High Blood Pressure (Using the BP_Risk_Category column that is already in the data)

SELECT
    ROUND(
        SUM(CASE WHEN BP_Risk_Category = 'Elevated / High Risk' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS Percentage_With_High_BP
FROM cleaned_health_data;

-- Question 1:What are the minimum and maximum systolic blood pressure values?

SELECT
    MIN(Systolic_BP) AS Min_Systolic_BP,
    MAX(Systolic_BP) AS Max_Systolic_BP
FROM cleaned_health_data;

--  Question 2 :What are the minimum and maximum diastolic blood pressure values?

SELECT
    MIN(Diastolic_BP) AS Min_Diastolic_BP,
    MAX(Diastolic_BP) AS Max_Diastolic_BP
FROM cleaned_health_data;

--  Question 3 :How many people have systolic blood pressure greater than or equal to 130?

SELECT COUNT(*) AS Number_Of_People
FROM cleaned_health_data
WHERE Systolic_BP >= 130;

--  Question 4 How many people belong to each age group: 18-29, 30-39, 40-49, 50-59, 60+? (Using the Age_Group column already in the data)
-- Note: the data has 60-69 and 70+ as separate groups, so both are shown to cover the "60+" range in the question.

SELECT Age_Group, COUNT(*) AS Number_Of_People
FROM cleaned_health_data
GROUP BY Age_Group;

--  Question 5 :How many people have high blood pressure in each age group?

SELECT Age_Group, COUNT(*) AS Number_Of_People_With_High_BP
FROM cleaned_health_data
WHERE BP_Risk_Category = 'Elevated / High Risk'
GROUP BY Age_Group;

--  Question 6 :How many people have normal blood pressure compared with elevated or high blood pressure?

SELECT BP_Risk_Category, COUNT(*) AS Number_Of_People
FROM cleaned_health_data
GROUP BY BP_Risk_Category;

--  Question 7 :Which age group has the highest percentage of people classified as having high blood pressure?

SELECT
    Age_Group,
    COUNT(*) AS Total_In_Group,
    SUM(CASE WHEN BP_Risk_Category = 'Elevated / High Risk' THEN 1 ELSE 0 END) AS High_BP_Count,
    ROUND(
        SUM(CASE WHEN BP_Risk_Category = 'Elevated / High Risk' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS High_BP_Percentage
FROM cleaned_health_data
GROUP BY Age_Group
ORDER BY High_BP_Percentage DESC;




































