# 📊 Global Superstore Sales Analysis

<p align="center">
  <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white"/>
  <img src="https://img.shields.io/badge/Microsoft_Excel-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white"/>
  <img src="https://img.shields.io/badge/PowerBI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black"/>
  <img src="https://img.shields.io/badge/Status-In%20Progress-orange?style=for-the-badge"/>
</p>

<p align="center">
  End-to-end data analysis of <strong>51,290 global retail orders</strong> across
  7 markets and 4 years — uncovering profit drivers, loss-making products
  and actionable business recommendations using <strong>SQL</strong>, <strong>Excel</strong> and <strong>Power BI</strong>.
</p>
---

## 📌 Key Business Findings

| # |                                    Finding                                          |         Impact        |
|---|-------------------------------------------------------------------------------------|-------------------------|
| 1 | Tables sub-category has **-8.46% profit margin** despite high sales volume          | 🔴 High Priority        |
| 2 | Discounts above **20% produce negative margins** across ALL categories              | 🔴 Policy Change Needed |
| 3 | **57.6% of Tables orders** lose money — highest loss rate of any sub-category       | 🔴 Immediate Review     |
| 4 | **APAC leads revenue** at $3.6M but Canada has best margin at **26.62%**            | 🟡 Strategy Insight     |
| 5 | 2014 growth was **discount-driven** — margin dipped from 11.95% → 11.73%            | 🟡 Risk Flag            |
| 6 | Paper sub-category is most stable — lowest loss order rate at **14.9%**             | 🟢 Best Performer       |
| 7 | Copiers generate highest profit margin — **technology is the strongest category**   | 🟢 Scale Up             |

---

## 🗂️ Project Structure

```
global-superstore-analysis/
│
├── dataset/                              # Original dataset files
│   ├── Global_Superstore2.csv
│   └── Global_Superstore2.xlsx
│
├── queries/                              # SQL scripts
│   └── Superstore_data_analysis.sql      # Complete analysis — 9 sections, 35+ queries
│
├── outputs/                              # Query results & documentation
│   ├── 1_Insights.md                     # Key findings & analysis summary
│   ├── B1_overall_performance.csv
│   ├── B2_yearly_performance.csv
│   ├── C1_market_performance.csv
│   ├── C2_top10_countries.csv
│   ├── D1_category_analysis.csv
│   ├── D2_subcategory_breakdown.csv
│   ├── D3_top10_profitable_products.csv
│   ├── D4_top10_loss_making_products.csv
│   ├── E1_segment_analysis.csv
│   ├── I1_executive_summary.csv
│   └── J1_pareto_top10pct_customers.csv
│
├── Excel/                               # 🔄 In Progress
│   └── coming_soon.md
│
├── PowerBI/                             # 🔄 Yet to start
│   └── coming_soon.md
│
└── README.md
```

---

## 🛠️ Tools & Skills Used

| Tool | Skills Demonstrated |
|------|-------------------|
| **MySQL 8.0** | Aggregate Functions · GROUP BY · HAVING · Subqueries · CTEs · Window Functions (LAG · RANK · DENSE_RANK · SUM OVER) · LOAD DATA INFILE · Date Functions · CASE WHEN · DATEDIFF · STR_TO_DATE |
| **Excel** *(In Progress)* | Pivot Tables · Slicers · Conditional Formatting · Charts · Dashboard Design |
| **Power BI** *(In Progress)* | DAX Measures · Data Modelling · Interactive Visuals · Published Dashboard |

---

## 📂 SQL Analysis — Section Breakdown

| Section | Description | Key Query Type |
|---------|-------------|---------------|
| **A — Exploratory** | Understand data structure, row counts, unique values | Basic SELECT |
| **B — Business Performance** | Overall KPIs, yearly and monthly trends | Aggregation |
| **C — Market & Region** | Market rankings, regional profit analysis | GROUP BY + ORDER BY |
| **D — Product Analysis** | Category, sub-category, top/bottom products | Nested Aggregation |
| **E — Customer & Segment** | Segment profitability, top/bottom customers | Multi-column GROUP BY |
| **F — Shipping & Operations** | Ship mode analysis, priority vs cost | DATEDIFF · AVG |
| **G — Discount Analysis** | Discount buckets, impact on margin | CASE WHEN |
| **H — Advanced Window Functions** | YoY growth, running totals, rankings | LAG · RANK · SUM OVER |
| **I — Executive Summary** | Full business scorecard, loss analysis | CTE · WITH clause |

---

## 📈 Business Recommendations

1. **Cap discounts at 20%** — any discount above this threshold consistently destroys profit margins across all product categories. Orders above 50% discount result in -111% margin collapse
2. **Review Tables pricing immediately** — -8.46% profit margin driven by 29% average discount. Either raise prices, reduce discounts, or discontinue low-margin SKUs
3. **Replicate Canada's low-discount model** — 26.62% margin is the highest of any market. Apply this pricing discipline cautiously across LATAM and EMEA regions
4. **Prioritise top customer retention** — top 15 customers generate disproportionate profit. A dedicated retention or loyalty programme would protect revenue significantly
5. **Investigate LATAM-South urgently** — lowest regional margin at 4.55% with no clear volume compensation. Needs full cost structure and pricing review
6. **Scale Paper and Copiers** — both show strong, stable margins with low loss rates. Increased marketing spend here would yield high ROI

---

## 🗃️ Dataset Details

| Field | Details |
|-------|---------|
| **Source** | Kaggle — Global Superstore Dataset |
| **Total Rows** | 51,290 orders |
| **Period** | 2011 – 2014 (4 years) |
| **Markets** | 7 (APAC · EU · US · LATAM · Africa · EMEA · Canada) |
| **Categories** | 3 (Technology · Furniture · Office Supplies) |
| **Sub-Categories** | 17 |
| **Unique Customers** | 1,590 |
| **Countries** | 147 |

---

## ▶️ How to Run the SQL Project

```sql
-- Step 1: Open MySQL Workbench and create a new schema
CREATE DATABASE superstore_db;
USE superstore_db;

-- Step 2: Run the CREATE TABLE block from the .sql file

-- Step 3: Load data using LOAD DATA LOCAL INFILE
-- (update file path to match your local machine)

-- Step 4: Run each section A through I in order
-- Each section is clearly labelled with comments
```

> ⚠️ **Note:** Enable `local_infile` on both client and server before running LOAD DATA.
> In MySQL Workbench: Edit → Preferences → SQL Editor → check Allow Loading Local Data.
> Then run: `SET GLOBAL local_infile = 1;`

---

## 📊 Sample Output — Business Scorecard (Query I1)

| Metric | Value |
|--------|-------|
| Total Orders | 25,025 |
| Total Customers | 1,590 |
| Countries Served | 147 |
| Total Revenue | $12,642,501 |
| Total Profit | $1,467,457 |
| Overall Margin | 11.61% |
| Avg Discount | 14.3% |
| Avg Ship Days | 4.0 days |
| Loss-Making Orders | ~30% |

---

## 🚧 Project Roadmap

- [x] SQL Analysis — 9 sections, 35+ queries, 11 CSV outputs
- [x] GitHub Repository setup with full documentation
- [ ] Excel Dashboard — Pivot tables, slicers, purple executive theme
- [ ] Power BI Dashboard — DAX measures, interactive report, published link
- [ ] Resume updated with project findings
- [ ] LinkedIn post with dashboard screenshots

---

## 👤 Author

**Shobhith S Kounder**
Aspiring Data Analyst · SQL · Excel · Power BI
📍 Sringeri, Karnataka — Open to relocation anywhere in India

<p>
  <a href="https://www.linkedin.com/in/shobhith-kounder-768859264">
    <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"/>
  </a>
  <a href="https://github.com/Shobhith01">
    <img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white"/>
  </a>
</p>

---

<p align="center">
  <i>This project is part of a 14-day data analyst portfolio challenge —
  building job-ready projects in SQL, Excel and Power BI to land
  a data analyst role in Bengaluru.</i>
</p>
