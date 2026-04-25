# SQL Analysis — Key Insights & Findings

## Dataset Overview
|       Metric     |       Value      |
|------------------|------------------|
| Total Orders     |            25,025|
| Total Rows       |            51,290|
| Total Revenue    |       $12,642,501|
| Total Profit     |        $1,467,457|
| Profit Margin    |            11.61%|
| Years Covered    |       2011 – 2014|
| Markets          | 7 Global Markets |
| Countries        | 147 Countries    |

---

## B1 — Overall Business Performance
**File:** `B1_overall_performance.csv`

**What this query does:** Calculates the all-time business scorecard —
total orders, revenue, profit, units sold, average discount and margin.

**Key Finding:** The business generated $12.6M revenue with an 11.61%
profit margin. Average discount of 14.3% is eating into margins.

---

## B2 — Yearly Performance
**File:** `B2_yearly_performance.csv`

**What this query does:** Breaks down sales and profit year by year
to show business growth trend.

**Key Finding:** 2014 had the highest sales but profit margin dipped
from 11.95% (2013) to 11.73% — suggesting growth is being driven
by discounting rather than organic demand. Unsustainable long term.

---

## C1 — Market Performance
**File:** `C1_market_performance.csv`

**What this query does:** Compares all 7 markets by sales, profit,
margin and shipping cost.

**Key Finding:** APAC leads in revenue ($3.6M) but Canada has the
highest profit margin due to minimal discounting. EMEA and LATAM
have the weakest margins and need pricing strategy review.

---

## C2 — Top 10 Countries
**File:** `C2_top10_countries.csv`

**What this query does:** Ranks countries by total sales revenue.

**Key Finding:** United States, Australia and France are top 3.
These markets should be prioritized for growth investment.

---

## D1 — Category Analysis
**File:** `D1_category_analysis.csv`

**What this query does:** Breaks down performance by the 3 main
product categories — Technology, Furniture, Office Supplies.

**Key Finding:** Technology has highest sales and margin.
Furniture has highest revenue but lowest margin — driven by
Tables and Bookcases losses.

---

## D2 — Sub-Category Breakdown ⭐ MOST IMPORTANT
**File:** `D2_subcategory_breakdown.csv`

**What this query does:** Drills into all 17 sub-categories to
find exactly which products are profitable and which lose money.

**Key Finding:**
- Tables: -8.46% margin · 29% avg discount · LOSS-MAKING
- Bookcases: -3.2% margin · LOSS-MAKING
- Copiers: +38.7% margin · BEST PERFORMER
- Paper: +27.3% margin · MOST STABLE
- Phones: +16.5% margin · HIGH VOLUME + GOOD MARGIN

**Business Recommendation:** Immediately review discount policy
for Tables and Bookcases. Consider minimum price floors.

---

## D3 — Top 10 Profitable Products
**File:** `D3_top10_profitable_products.csv`

**What this query does:** Finds the 10 individual products
generating the most profit.

**Key Finding:** Canon and Cisco products dominate the top
profitable list — Technology sub-categories are star performers.

---

## D4 — Top 10 Loss-Making Products
**File:** `D4_top10_loss_making_products.csv`

**What this query does:** Finds the 10 individual products
losing the most money.

**Key Finding:** Heavy discounting on specific Furniture and
Technology products creates concentrated losses. These specific
SKUs should be either repriced or discontinued.

---

## E1 — Segment Analysis
**File:** `E1_segment_analysis.csv`

**What this query does:** Compares Consumer, Corporate and
Home Office segments by all key metrics.

**Key Finding:**
- Consumer: highest sales volume and total profit
- Home Office: highest profit margin %
- Corporate: highest average order value
- Recommendation: Target Home Office segment for margin growth

---

## I1 — Executive Summary Scorecard
**File:** `I1_executive_summary.csv`

**What this query does:** Single-row CTE that produces a complete
business health scorecard — the CEO-level view.

**Key Finding:** Business is profitable overall but 30%+ of orders
lose money. Average shipping time and discount rate are key levers
to improve profitability without needing more sales volume.

---

## J1 — Pareto Analysis (Top 10% Customers)
**File:** `J1_pareto_top10pct_customers.csv`

**What this query does:** Identifies what percentage of profit
comes from the top 10% of customers (Pareto principle).

**Key Finding:** A small number of customers generate a
disproportionate share of profit — these are your VIP customers
and should receive priority service and retention focus.

---
