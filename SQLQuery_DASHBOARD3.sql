


-- KPI 1: Average Total Cholesterol

SELECT ROUND(AVG(Total_Cholesterol), 2) AS Average_Total_Cholesterol
FROM cleaned_health_data;



-- KPI 2: Average HDL Cholesterol

SELECT ROUND(AVG(HDL_Cholesterol), 2) AS Average_HDL_Cholesterol
FROM cleaned_health_data;



-- KPI 3: Average LDL Cholesterol

SELECT ROUND(AVG(LDL_Cholesterol), 2) AS Average_LDL_Cholesterol
FROM cleaned_health_data;



-- KPI 4: Average Triglycerides

SELECT ROUND(AVG(Triglycerides), 2) AS Average_Triglycerides
FROM cleaned_health_data;



-- KPI 5: Percentage With High LDL (High LDL is defined as LDL above the dataset's average LDL value)
-- Step 1: we save the average LDL in a variable first.
-- Step 2: we use that variable normally in the calculation.
-- =====================================================
DECLARE @Avg_LDL FLOAT;
SELECT @Avg_LDL = AVG(LDL_Cholesterol) FROM cleaned_health_data;

SELECT
    ROUND(
        SUM(CASE WHEN LDL_Cholesterol > @Avg_LDL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS Percentage_With_High_LDL
FROM cleaned_health_data;



--  Question 1 :What is the highest total cholesterol value in the dataset?
SELECT MAX(Total_Cholesterol) AS Highest_Total_Cholesterol
FROM cleaned_health_data;



--  Question 2 :What is the lowest LDL cholesterol value in the dataset?
SELECT MIN(LDL_Cholesterol) AS Lowest_LDL_Cholesterol
FROM cleaned_health_data;



--  Question 3 : How many people have HDL cholesterol below 40?

SELECT COUNT(*) AS Number_Of_People
FROM cleaned_health_data
WHERE HDL_Cholesterol < 40;



--  Question 4 :How many people fall into the Desirable, Borderline High and High total cholesterol categories?
SELECT
    CASE
        WHEN Total_Cholesterol < 200 THEN 'Desirable'
        WHEN Total_Cholesterol BETWEEN 200 AND 239 THEN 'Borderline High'
        ELSE 'High'
    END AS Cholesterol_Category,
    COUNT(*) AS Number_Of_People
FROM cleaned_health_data
GROUP BY
    CASE
        WHEN Total_Cholesterol < 200 THEN 'Desirable'
        WHEN Total_Cholesterol BETWEEN 200 AND 239 THEN 'Borderline High'
        ELSE 'High'
    END;


--  Question 5 : How many people have LDL cholesterol classified as High or Very High? (High: above the dataset average | Very High: more than 5% above the average)
DECLARE @Avg_LDL2 FLOAT;
SELECT @Avg_LDL2 = AVG(LDL_Cholesterol) FROM cleaned_health_data;

SELECT
    CASE
        WHEN LDL_Cholesterol > (@Avg_LDL2 * 1.05) THEN 'Very High'
        ELSE 'High'
    END AS LDL_Category,
    COUNT(*) AS Number_Of_People
FROM cleaned_health_data
WHERE LDL_Cholesterol > @Avg_LDL2
GROUP BY
    CASE
        WHEN LDL_Cholesterol > (@Avg_LDL2 * 1.05) THEN 'Very High'
        ELSE 'High'
    END;


--  Question 6:How does the number of people with high total cholesterol differ between smokers and non-smokers? (High total cholesterol is defined as Total_Cholesterol >= 240)
SELECT Smoking_Status, COUNT(*) AS Number_Of_People_With_High_Cholesterol
FROM cleaned_health_data
WHERE Total_Cholesterol >= 240
GROUP BY Smoking_Status;


--  Question 7 : Which age group has the highest percentage of people with high LDL cholesterol?(High LDL is defined as LDL above the dataset's average LDL value)
DECLARE @Avg_LDL3 FLOAT;
SELECT @Avg_LDL3 = AVG(LDL_Cholesterol) FROM cleaned_health_data;

SELECT
    Age_Group,
    COUNT(*) AS Total_In_Group,
    SUM(CASE WHEN LDL_Cholesterol > @Avg_LDL3 THEN 1 ELSE 0 END) AS High_LDL_Count,
    ROUND(
        SUM(CASE WHEN LDL_Cholesterol > @Avg_LDL3 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS High_LDL_Percentage
FROM cleaned_health_data
GROUP BY Age_Group
ORDER BY High_LDL_Percentage DESC;
