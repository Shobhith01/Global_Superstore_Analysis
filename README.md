# Global Superstore Sales & Profit Analysis

## 📊 Project Overview

Comprehensive **SQL-based business analysis** of the Global Superstore dataset containing **51,290 orders** across 7 global markets from 2011 to 2014.

This project focuses on uncovering key business insights related to **sales performance, profitability, discount impact, product performance, customer segmentation, and operational efficiency** using MySQL.

**Objective**: Identify profit-driving and loss-making areas, evaluate discount strategies, and provide actionable recommendations to improve overall business margins.

## 🛠️ Tools & Technologies
- **MySQL** (Primary)
  - Advanced SQL concepts:
  - Aggregate Functions
  - Window Functions 
  - Common Table Expressions (CTEs)
  - Subqueries and Conditional Logic

## 📁 Project Structure
global-superstore-analysis/
├── dataset/                    # Original dataset files
│   ├── Global_Superstore2.csv
│   └── Global_Superstore2.xlsx
├── queries/                    # SQL scripts
│   ├── Superstore data analysis.sql
│   └── queries.sql
├── outputs/                    # Query results (11 key outputs)
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
└── README.md


## 🔍 Key Insights & Findings

- **Tables** sub-category is a major loss-maker due to high discounts resulting in negative profit margins.
- Discounts **above 20%** consistently lead to losses across almost all categories — strong recommendation to review and cap discount policies.
- **APAC** market generates the highest sales volume but has relatively lower profit margins.
- **Canada** stands out with the highest profit margin (~26.62%).
- **Technology** category (especially **Copiers**) is highly profitable, while **Furniture** (particularly Tables) needs attention to improve margins.
- **Top 10% of customers** contribute approximately **26%** of total profit (Pareto principle) — highlighting the importance of high-value customer retention.
- Some sub-categories lose money on **40-60%** of their orders.

## 📈 Analysis Sections Covered

- Exploratory Data Analysis (Data overview, time period, markets, segments)
- Overall Business Performance (Total sales, profit, margin, yearly growth)
- Market & Region Analysis (Performance by market, top countries, regional profitability)
- Product Category & Sub-category Analysis (**Most important section** — identifies loss-making products)
- Customer & Segment Analysis (Consumer, Corporate, Home Office performance)
- Shipping & Operations Analysis
- Discount Impact Analysis (Critical business insight)
- Advanced SQL (Window functions, ranking, running totals, YoY growth)
- Executive Summary & Loss-making Analysis

## 🚀 How to Run the Project

1. Create the database:
   ```sql
   CREATE DATABASE superstore_db;
   USE superstore_db;

Execute the table creation and data loading script from queries/Superstore data analysis.sql
Run the analysis queries section by section.

Note: Date conversion (Step 1B) is required if importing raw CSV in MySQL.


📋 Key Skills Demonstrated

End-to-end SQL data analysis
Business-oriented problem solving
Identifying actionable insights from raw data
Writing clean, well-commented, and structured SQL code
Using advanced SQL features for deeper insights

🔮 Future Enhancements (Planned)

Excel-based analysis and pivot tables on the same dataset
Interactive Power BI dashboard for visualizations
Customer segmentation using RFM analysis
Sales forecasting models

📄 Documentation
All key query outputs are available in the /outputs folder for quick reference.

Author: Shobhith Kounder
Dataset Source: Kaggle - Global Superstore
Last Updated: 25 April 2026

⭐ If you found this project helpful, please consider starring the repository!
Feel free to reach out for any questions or suggestions.
