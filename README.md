# CREDIT RISK ANALYTICS

## Project README & Submission Guide

**Project Area:** Banking & Finance -- Credit Risk Analytics

## Purpose of this document

This README introduces the project, explains the analytical approach and
summarizes the main findings. It also helps the reviewer identify the
purpose of each submitted deliverable.


## 1. Project Title

Credit Risk Analytics -- Analysis of Default of Credit Card Clients.
This project studies historical credit-card repayment and default data
to identify customer segments associated with higher observed default
rates.

## 2. Business Problem

Credit-card issuers need to understand how default experience varies
across customer groups and repayment patterns. Without structured
analysis, it can be difficult to compare segments, identify
concentrations of historical defaults and communicate portfolio risk
clearly. This project examines the available historical dataset; it does
not build or deploy a production credit-scoring system.

## 3. Business Objective

**Primary objective:** 1. Which customer segments have higher default rates?
2. Does credit limit relate to default behaviour?
3. How does repayment behaviour affect default rates?
4. Which age groups show higher risk?
5. How do demographic segments differ in observed default rates?
6. Which customer groups represent the greatest potential credit risk? 

## 4. Stakeholders

**Potential stakeholders:** credit-risk analysts, credit-card portfolio
managers, lending and underwriting teams, risk/compliance teams, and
business decision-makers who monitor portfolio performance. These are
intended users of the analysis, not confirmed project sponsors.

## 5. Dataset Source

The project uses the *Default of Credit Card Clients* dataset from the
UCI Machine Learning Repository:

<https://archive.ics.uci.edu/dataset/350/default+of+credit+card+clients>

The analysed dataset contains 30,000 customer records and 25 original
variables, including credit limit, demographic attributes,
repayment-status fields, bill amounts, payment amounts and the target
indicating default payment in the next month.

## 6. Tools Used

-   **Microsoft Excel:** data preparation, formulas, PivotTables,
    charts, KPI calculations and dashboard.
-   **SQL:** filtering, aggregation, CASE expressions, joins,
    subqueries, CTEs and window/ranking analysis.
-   **Python (Pandas, NumPy, Matplotlib and Seaborn):** data validation,
    exploratory data analysis, statistical summaries and visualizations.
-   **Power BI Desktop:** Power Query preparation, DAX measures and
    calculated columns, interactive report pages, slicers and tooltips.

## 7. Data Cleaning Process

The dataset was checked for column types, missing values, duplicate
records and duplicate customer IDs. The Python validation found 30,000
rows and 25 columns, with no missing values or duplicate records in the
analysed dataset. Categorical codes were interpreted using category
mappings, and analysis fields such as age group, credit-limit category
and default status were created for segment comparisons. In the SQL
import, the header row was treated as a data row by the import process;
queries excluded that extra row by filtering out the record whose ID
value was the text `'ID'`. Outliers were reviewed using the IQR method
and retained because unusually high or low financial values may be valid
observations.

## 8. Key Business Questions

1.  Which customer segments have higher observed default rates?
2.  Does credit limit relate to observed default behaviour?
3.  How does repayment behaviour differ across default outcomes?
4.  Which age groups show higher observed risk?
5.  How do demographic segments differ in observed default rates?
6.  Which customer groups represent greater potential credit-risk
    concentration?

## 9. Major Findings

-   **Overall:** 6,636 of 30,000 customers defaulted, giving an observed
    default rate of **22.12%**.
-   **Credit limit:** the Low credit-limit category had an observed
    default rate of **31.79%**, compared with **23.72%** for Medium and
    **15.64%** for High.
-   **Age:** the Senior group had the highest observed rate at
    **25.30%**; Adults had the lowest at **20.25%**.
-   **Education:** among the main education groups, High School had the
    highest observed rate at **25.16%**.
-   **Repayment status:** positive current repayment-status values
    (PAY_0) generally showed higher observed default rates than
    non-positive values. For example, PAY_0 = 2 had an observed rate of
    approximately **69.14%**.
-   **Interpretation:** these are historical associations and
    descriptive rates. They do not establish that a characteristic
    causes default, and they are not model-generated individual
    predictions.

## 10. Business Recommendations

1.  Monitor the low credit-limit segment more closely because it has a
    higher observed default rate in this dataset.
2.  Include repayment-status patterns in portfolio monitoring and review
    customers with recent payment delays according to the institution's
    approved policies.
3.  Track observed default rates by age, education, gender and
    marital-status segments, while checking sample sizes and avoiding
    unfair or unsupported conclusions about individuals.
4.  Use the dashboards for ongoing portfolio review and investigate
    changes in segment-level rates before taking business action.
5.  Validate findings on newer, representative data and with domain
    experts before using them in credit policy or operational decisions.

## 11. Limitations

The dataset is historical and represents a particular population and
period; its findings may not generalize to current portfolios or other
markets. The data has no actual calendar date column suitable for
time-series or time-intelligence analysis, so repayment-status fields
(PAY_0 to PAY_6) must not be interpreted as calendar dates. The project
is descriptive and does not train or validate a predictive model,
estimate causal effects, or provide calibrated individual default
probabilities. Some category groupings are based on coded source values,
and results depend on those definitions. Outliers were retained where
they could represent genuine financial behaviour. Recommendations
require validation before real-world use.

------------------------------------------------------------------------

**Metric definition:** Observed default rate = number of customers with
the recorded default outcome of 1 divided by the number of customers in
the segment. Rates in this README are calculated from the
30,000-customer analysis dataset and may vary when report filters are
applied.

**Important note for the reviewer:** The Power BI deliverable is the
original `.pbix` project file. It is not expected to preview in Google
Drive; download it and open it using Power BI Desktop to inspect the
interactive report.
