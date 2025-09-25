/*
==========================================
Healthcare Analytics - Massachusetts General Hospital
SQL Analysis for Strategic Decision Making
==========================================

Author: Amirhossein Tonekaboni
Database: MySQL
Dataset: 11 years of hospital operations (2011-2022)
Dataset Source: Maven Analytics Hospital Challenge Dataset
Records: ~1,000 patients, 27,000+ encounters

Analysis Objectives:
1. Encounters Overview - Volume trends and service distribution
2. Cost & Coverage Insights - Financial analysis and payer patterns  
3. Patient Behavior Analysis - Readmission patterns and patient flow

Technical Features:
- Window functions (LEAD) for temporal analysis
- Conditional aggregation (CASE statements) for classification
- Multi-table joins for dimensional analysis
- CTE patterns for complex calculations

Data Attribution: This analysis uses synthetic healthcare data provided by 
Maven Analytics as part of their healthcare analytics challenge.

==========================================
*/

-- Database connection and data exploration
USE hospital_db;
SELECT * FROM encounters;
SELECT DISTINCT ENCOUNTERCLASS FROM encounters;
SELECT * FROM patients;
SELECT * FROM payers;
SELECT * FROM procedures;

-- ==========================================
-- OBJECTIVE 1: ENCOUNTERS OVERVIEW
-- ==========================================

-- Annual encounter volume
SELECT YEAR(START) AS YR, COUNT(Id) AS TOTAL_ENCOUNTERS
FROM encounters
GROUP BY YEAR(START)
ORDER BY YR;

-- Encounter class distribution by year
SELECT	YEAR(START) AS YR,
		ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'ambulatory'	THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS ambulatory,
        ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'outpatient'	THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS outpatient,
        ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'wellness'		THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS wellness,
        ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'urgentcare'	THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS urgentcare,
        ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'emergency' 	THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS emergency,
        ROUND(SUM(CASE WHEN ENCOUNTERCLASS = 'inpatient'	THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS inpatient
FROM encounters
GROUP BY YEAR(START)
ORDER BY YR;

-- Encounter duration analysis (24-hour threshold)
SELECT	ROUND(SUM(CASE WHEN TIMESTAMPDIFF(HOUR, START, STOP) >= 24 THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS over_24,
		ROUND(SUM(CASE WHEN TIMESTAMPDIFF(HOUR, START, STOP) <  24 THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS under_24
FROM encounters;

-- ==========================================
-- OBJECTIVE 2: COST & COVERAGE INSIGHTS
-- ==========================================

-- Zero payer coverage analysis
SELECT
	SUM(CASE WHEN PAYER_COVERAGE = 0 THEN 1 ELSE 0 END) AS zero_coverage,
    ROUND(SUM(CASE WHEN PAYER_COVERAGE = 0 THEN 1 ELSE 0 END) / COUNT(*) * 100.0, 1) AS zero_prct
	FROM encounters;

-- Top 10 most frequent procedures
SELECT CODE, DESCRIPTION, COUNT(CODE) AS total_procedures, AVG(BASE_COST) AS avg_base_cost
FROM procedures
GROUP BY CODE, DESCRIPTION
ORDER BY total_procedures DESC
LIMIT 10;

-- Top 10 highest cost procedures
SELECT CODE, DESCRIPTION, AVG(BASE_COST) AS avg_base_cost, COUNT(CODE) AS total_procedures
FROM procedures
GROUP BY CODE, DESCRIPTION
ORDER BY avg_base_cost DESC
LIMIT 10;

-- Average claim costs by payer
SELECT p.NAME AS payer, AVG(e.TOTAL_CLAIM_COST) AS avg_total_claim_cost
FROM payers p
LEFT JOIN encounters e
ON  p.Id = e.PAYER
GROUP BY p.NAME
ORDER BY AVG(e.TOTAL_CLAIM_COST) DESC;

-- ==========================================
-- OBJECTIVE 3: PATIENT BEHAVIOR ANALYSIS
-- ==========================================

-- Quarterly unique patient admissions
SELECT QUARTER(START) AS qtr, COUNT(DISTINCT PATIENT) AS total_unique_patient
FROM encounters
GROUP BY QUARTER(START)
ORDER BY QUARTER(START);

SELECT YEAR(START) AS yr, QUARTER(START) AS qtr, COUNT(DISTINCT PATIENT) AS total_unique_patient
FROM encounters
GROUP BY YEAR(START), QUARTER(START)
ORDER BY YEAR(START), QUARTER(START);

-- 30-day readmission count
SELECT	PATIENT, START, STOP,
		LEAD(START) OVER(PARTITION BY PATIENT ORDER BY START) AS next_start_date -- START time of the next encounter
FROM encounters
ORDER BY PATIENT, START;

WITH next AS (SELECT	PATIENT, START, STOP,
						LEAD(START) OVER(PARTITION BY PATIENT ORDER BY START) AS next_start_date -- START time of the next encounter
						FROM encounters)
SELECT COUNT(DISTINCT PATIENT) AS num_readmitted_patients
FROM next
WHERE DATEDIFF(next_start_date, stop) < 30;

-- Top 5 patients with most readmissions
WITH next AS (SELECT	PATIENT, START, STOP,
						LEAD(START) OVER(PARTITION BY PATIENT ORDER BY START) AS next_start_date -- START time of the next encounter
						FROM encounters)
SELECT PATIENT, COUNT(*) AS num_readmissions
FROM next
WHERE DATEDIFF(next_start_date, stop) < 30
GROUP BY PATIENT
ORDER BY num_readmissions DESC;

-- Top 5 patients with most readmissions (with patient names)
WITH person AS (
	SELECT e.START, e.STOP, p.Id, p.FIRST, p.LAST
    FROM encounters e
    JOIN patients p ON e.PATIENT = p.Id
),
next AS (
	SELECT	*, LEAD(START) OVER(PARTITION BY Id ORDER BY START) AS next_start_date -- START time of the next encounter
	FROM person
)
SELECT Id, FIRST, LAST, COUNT(*) AS num_readmissions
FROM next
WHERE DATEDIFF(next_start_date, STOP) < 30
GROUP BY Id, FIRST, LAST
ORDER BY num_readmissions DESC
LIMIT 5;
