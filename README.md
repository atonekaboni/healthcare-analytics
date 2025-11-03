# Healthcare Data Analysis
**SQL and Excel-based analysis of Massachusetts General Hospital operations for data-driven decision-making and performance reporting.**

[![SQL_Guiude](https://img.shields.io/badge/SQL%20Guide-4f97d6?logo=mysql&logoColor=white)](https://github.com/atonekaboni/healthcare-analytics/raw/refs/heads/main/Healthcare_Data_Analysis_SQL.pdf)
[![Excel_Slides](https://img.shields.io/badge/Excel%20Slide%20Deck-00b050?logo=microsoft-excel&logoColor=white)](https://github.com/atonekaboni/healthcare-analytics/raw/refs/heads/main/Excel/Healthcare_Data_Analysis_Excel.pdf)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?logo=linkedin&logoColor=white)](https://www.linkedin.com/posts/tonekaboni_healthcare-data-analysis-activity-7391035320928022528-4x1A)

## Project Overview

This project analyzes over 10 years of patient data from **Massachusetts General Hospital (2011–2022)**, covering approximately 1,000 patient records and 27,000 encounters. The study investigates **insurance coverage gaps**, **readmission patterns**, and **encounter distribution** across different service lines to identify opportunities for improved financial and operational performance.

The analysis was first conducted in **SQL** and then replicated in **Excel** to visualize the same insights and explore differences in approach and performance between both tools.

The dataset provides insights into operational challenges facing healthcare administrators who must balance cost containment with quality care delivery. By analyzing historical patterns, this investigation reveals actionable findings that support evidence-based decision making for strategic planning and operational improvements.

<p align="center" style="margin:0;"><a href="https://github.com/atonekaboni/healthcare-analytics/raw/refs/heads/main/Excel/Healthcare_Data_Analysis_Excel.pdf" target="_blank"><img width="1907" height="1073" alt="Healthcare_Data_Analysis_Dashboard" src="https://github.com/user-attachments/assets/94ef3ff1-25eb-4c54-a3ba-5256d1afaf30" /></a><small><em>2022 data excluded from Excel analysis and visualizations</em></small></p>

## Database Architecture
The healthcare database connects patient demographics to clinical encounters and financial records through four normalized tables: **patients**, **encounters**, **procedures**, and **payers**. This structure enables multi-dimensional analysis across demographics, encounter types, procedure patterns, and financial performance.

<p align="center"><a href="https://github.com/atonekaboni/healthcare-analytics/raw/refs/heads/main/Healthcare_Data_Analysis_SQL.pdf" target="_blank"><img width="400" height="auto" alt="ERD" src="https://github.com/user-attachments/assets/0e2abe9f-26d0-40c2-90f0-e12c53794fa9" />

## Executive Summary
Massachusetts General Hospital analysis reveals critical revenue risks with 49% of encounters lacking payer coverage, representing potential losses exceeding $75 million annually. Patient volume grew 164% over the decade, but 2021 data shows concerning readmission patterns with 771 patients requiring readmission within 30 days. The analysis identifies actionable opportunities for revenue recovery through pre-visit insurance verification and targeted case management for high-risk patients.

<br>

## Key Findings
### Revenue Coverage Crisis
-	**payer coverage:** 49% of all encounters (13,586 visits) operate without payer coverage, representing substantial revenue exposure affecting nearly half of hospital activity.

<p align="center"><a href="https://github.com/atonekaboni/healthcare-analytics/raw/refs/heads/main/Excel/Healthcare_Data_Analysis_Excel.pdf" target="_blank"><img alt="Share of Encounters by Coverage" src="https://github.com/user-attachments/assets/fa036815-3940-4167-8df5-6f2c658315a7" width="35%" />

-	**Reimbursement:** Payer reimbursement varies dramatically, with Medicaid providing the highest average at $6,205 per encounter, while Dual Eligible patients generate the lowest reimbursement at only $1,696 per encounter. Uninsured patients generate $5,593 in average claims, indicating significant uncollectable receivables. (Visualization below created in Python with SQLAlchemy and Matplotlib.)
  
<p align="center"><a href="https://github.com/atonekaboni/healthcare-analytics/raw/refs/heads/main/Healthcare_Data_Analysis_SQL.pdf" target="_blank"><img width="589" height="390" alt="Payer Performance Chart" src="https://github.com/user-attachments/assets/dfbf8a77-f9ff-4be4-89e2-ef485c4fb991" />
 
### Critical Care Economics
The analysis reveals dramatic cost variations in hospital procedures. ICU admissions dominate at $206,260 per procedure (5 total), representing the most resource-intensive care. However, the most striking finding is electrical cardioversion with 1,383 procedures at $25,903 each (over $35 million) - indicating substantial resource allocation to cardiac emergency procedures.

<p align="center"><a href="https://github.com/atonekaboni/healthcare-analytics/raw/refs/heads/main/Excel/Healthcare_Data_Analysis_Excel.pdf" target="_blank"><img alt="TOP Procedures Total and Average Base Cost" src="https://github.com/user-attachments/assets/28ae171c-2e66-4d35-ae01-4e786575b39d" width="62%" />

<p align="center"><img width="570" height="auto" alt="Average Cost" src="https://github.com/user-attachments/assets/547d07a0-453f-47c3-a2aa-03160057964c" /><br><small><em>Average Cost</em></small></p>

In contrast, high-volume procedures demonstrate standardized operational pricing across routine hospital services. The majority of frequent procedures operate at a consistent $431 cost structure - health assessments (4,596 procedures), hospice care (4,098), depression screening (3,614) all follow this uniform rate. However, renal dialysis emerges as a significant exception with 2,746 procedures at $1,004 each, representing nearly 2.5 times the standard rate and highlighting the resource-intensive nature of chronic kidney disease management.

<p align="center"><img width="570" height="auto" alt="high-volume procedures" src="https://github.com/user-attachments/assets/e53d16ae-6eb3-422e-a244-84c08d0351f5" /><br><small><em>high-volume procedures</em></small></p>

### Patient Safety Concerns
<b>771 patients</b> required readmission within 30 days. The most extreme case shows 1,376 readmissions for a single patient, representing both safety risks and resource consumption.
<p align="center"><img width="659" height="auto" alt="image" src="https://github.com/user-attachments/assets/ab8825c7-b062-4321-a699-10f76d005e26" /><br><small><em>SQL script for calculating patients with highest number of readmissions</em></small></p>

<p align="center"><img width="280" height="auto" alt="Readmission" src="https://github.com/user-attachments/assets/345d9d4f-ed01-459d-892d-3dabf6b9e9f2" /><br><small><em>Readmission</em></small></p>

### Operational Efficiency
<b>Encounter Volume and Patient Flow Analysis:</b> Hospital encounters grew from 1,336 in 2011 to peak at 3,530 in 2021 - a 164% increase over ten years. The quarterly unique patient data reveals that 2021's record encounter volume coincided with dramatic patient spikes in Q1-Q2 (417 and 414 unique patients respectively) before declining to 279 and 223 in Q3-Q4. This pattern shows that 2021's high encounter volume resulted from both increased patient volume and higher visit frequency per patient. (The 2022 data included only first quarter of the year.)

<p align="center"><a href="https://github.com/atonekaboni/healthcare-analytics/blob/main/Excel/Healthcare_Data_Analysis_Excel.pdf" target="_blank"><img alt="image" src="https://github.com/user-attachments/assets/a28c951a-ea37-4a93-ac1b-4bb59289572c" width="61%" /></p>
<br>
<p align="center"><a href="https://github.com/atonekaboni/healthcare-analytics/blob/main/Excel/Healthcare_Data_Analysis_Excel.pdf" target="_blank"><img alt="image" src="https://github.com/user-attachments/assets/d2b4bc14-c9a2-42dd-93d5-6c4173fa6482" width="62%" />

<br><b>Encounter Duration Performance</b> confirms exceptional operational efficiency with 96% of encounters completing within 24 hours, indicating effective patient throughput management and discharge planning protocols across all service lines.

<br><b>Service Line Distribution:</b> Ambulatory care dominated hospital operations, ranging from 36.9% (2021) to 60.3% (2014), while outpatient services spiked to 40.2% in 2021 - suggesting temporary operational shifts. Urgent care increased dramatically from 2.2% (2011) to 17.8% (2019), while emergency care remained stable between 4-11%. Wellness care declined from 13.0% (2011) to 4.4% (2021), and inpatient care consistently declined from 6.2% to 1.6%, reflecting the shift toward ambulatory treatment.

<p align="center"><a href="https://github.com/atonekaboni/healthcare-analytics/blob/main/Excel/Healthcare_Data_Analysis_Excel.pdf" target="_blank"><img alt="Share of Encounters by Class" src="https://github.com/user-attachments/assets/519fee87-b8c6-419e-9638-fd44b0c79220" width="62%" />
 
## Strategic Recommendations

**Revenue Leakage**
With 49% of encounters having no insurance coverage, implement automatic insurance checks 24-48 hours before patient visits. This could recover millions in lost revenue and should be the top priority given how many patients are currently uninsured.

**Target High-Risk Patients** 
Deploy case management for the 771 patients with 30-day readmissions, especially targeting the top 5 patients averaging nearly 800 readmissions each. Better care coordination could significantly reduce both costs and safety risks while improving patient outcomes.

**Improve Insurance Payment Strategy**
Dual Eligible patients pay only $1,696 per encounter while Medicaid pays $6,205 - nearly four times more than the lowest payer. The hospital should focus on attracting patients with better-paying insurance plans and negotiate higher rates with the lowest-paying insurers like Dual Eligible.

 ## Technical Implementation
-	**Database:** `MySQL` with four-table normalized design connecting patient demographics to clinical encounters and financial records.
-	**Core Analysis Methods:** `LEAD` `window function` to track patient readmission intervals, `CASE` statement aggregation for encounter type distribution, and multi-table `joins` linking procedures to cost and coverage data.
-	**Dataset:** 11 years of operational data (2011-2022) covering 1,000+ patient records and 27,000+ encounters sourced from [Maven Analytics Hospital Patient Records](https://mavenanalytics.io/data-playground/hospital-patient-records).

## Project Limitations
-	**Incomplete 2022 data:** Only first quarter available, preventing full-year trend comparison.
-	**Readmission Analysis:** 30-day window follows standard clinical practice but may miss longer-term patterns.
-	**Cost interpretation:** Analysis uses hospital base costs, not actual patient bills or final insurance payments.
-	**Scope:** Single hospital system data may not represent national healthcare patterns or rural facilities.

## Repository Structure
This repository contains the complete healthcare analytics project with the following components:
- **[`hospital_analytics.sql`](hospital_analytics.sql)** - Complete SQL analysis script implementing three analytical objectives
- **[`Healthcare_Data_Analysis_SQL.pdf`](Healthcare_Data_Analysis_SQL.pdf)** - **SQL Analysis Report**
- **[`Hospital_Analytics.xlsx`](Excel/Hospital_Analytics.xlsx)** - Excel Dashboard
- **[`Healthcare_Data_Analysis_Excel.pdf`](Excel/Healthcare_Data_Analysis_Excel.pdf)** - **Excel Analysis Slide Deck** including Visualizations
- **[`dataset.rar`](dataset.rar)** - Massachusetts General Hospital synthetic data (2011-2022) - database file
- **[`README.md`](README.md)** - Comprehensive project documentation with findings and recommendations

## Contact

<p align="center">
  <a href="https://www.linkedin.com/in/tonekaboni/" target="_blank"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"/></a>
  &nbsp;&nbsp;
  <a href="https://github.com/atonekaboni/" target="_blank"><img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/></a>
  &nbsp;&nbsp;
  <a href="https://atonekaboni.github.io/" target="_blank"><img src="https://img.shields.io/badge/Portfolio-D14836?style=for-the-badge&logo=googlechrome&logoColor=white" alt="Portfolio"/></a>
</p>
