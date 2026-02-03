# Finance Dashboard Portfolio Project

## Executive Summary

A comprehensive FP&A (Financial Planning & Analysis) dashboard built to demonstrate data modeling, SQL, and business intelligence skills. This project simulates a realistic corporate finance scenario for **NovaTech Solutions**, a mid-market technology company selling software and hardware products across North American regions.

---

## Business Context

### Company Profile
- **Company**: NovaTech Solutions (fictional)
- **Industry**: Technology (Software & Hardware)
- **Revenue Range**: $50-100M annually
- **Time Period**: January 2022 – December 2024 (3 years, monthly data)

### Stakeholders
| Role | Key Questions |
|------|---------------|
| **CFO** | Are we on track to hit annual targets? Where are the biggest variances? |
| **FP&A Analyst** | Which products/regions are driving over/under performance? |
| **Sales Leader** | How is my region performing vs. budget? What's the trend? |

### Decisions Supported
1. **Budget Reforecast**: Identify if mid-year adjustments are needed
2. **Margin Improvement**: Pinpoint products or regions with eroding margins
3. **Regional Performance**: Evaluate sales team effectiveness by geography
4. **Product Strategy**: Determine which products to invest in or phase out

---

### Grain Definition
- **Fact_Actuals**: Monthly grain (aggregated from transactions) by Product × Region × Customer
- **Fact_Budget**: Monthly grain by Product × Region

---

## KPI Dictionary

| KPI | Formula | Business Meaning |
|-----|---------|------------------|
| **Revenue** | Units × Unit Price | Total sales value |
| **COGS** | Units × Unit Cost | Cost of Goods Sold |
| **Gross Profit** | Revenue − COGS | Profit before operating expenses |
| **Gross Margin %** | Gross Profit ÷ Revenue × 100 | Profitability efficiency metric |
| **Operating Expenses (Opex)** | Allocated costs | SG&A, Marketing, etc. |
| **Operating Income** | Gross Profit − Opex | Profit from core operations |
| **Budget Variance ($)** | Actual − Budget | Dollar difference from plan |
| **Budget Variance (%)** | (Actual − Budget) ÷ Budget × 100 | Percentage difference from plan |
| **YoY Growth %** | (Current Year − Prior Year) ÷ Prior Year × 100 | Year-over-year change |
| **MoM Growth %** | (Current Month − Prior Month) ÷ Prior Month × 100 | Month-over-month change |
| **YTD Revenue** | SUM(Revenue) from Jan to Current Month | Cumulative year-to-date |

---

## Project Structure

```
finance-dashboard/
├── data/
│   ├── dim_date.csv
│   ├── dim_product.csv
│   ├── dim_region.csv
│   ├── dim_customer.csv
│   ├── fact_actuals.csv
│   └── fact_budget.csv
├── sql/
│   ├── schema.sql          # Table definitions
│   └── views.sql           # Analytical views
├── bi/
│   └── finance_dashboard.pbix  # Interactive dashboard
├── docs/
│   └── data_dictionary.md
└── README.md
```

---

## Key Insights

1. **Budget Miss Driven by West Region**: Company missed overall revenue budget by $9.9M (-8.7%), with the West region contributing disproportionately at -13.0% variance vs. ~7.4% for other regions.

2. **Strong Growth Momentum**: Despite budget miss, YoY growth remained healthy at 33% (2022→2023) and 27% (2023→2024), indicating solid market demand.

3. **EdgeCompute Device is Star Product**: 42% YoY growth trajectory makes it the fastest-growing product, suggesting strong market fit for edge computing solutions.

4. **Q2 2023 Cost Shock Impact**: Supply chain disruption caused gross margin to drop 8.6 percentage points in Q2 2023 (47.0% vs. 55.6% normal). Full recovery achieved by Q3.

5. **Margin Improvement Trend**: Gross margins improved from 53.7% (2022) to 55.2% (2024), reflecting operational efficiency gains and pricing power.

6. **SecureNode Hardware Lagging**: Slowest growth at 17% YoY while other hardware (EdgeCompute) grows at 42% - indicates potential product lifecycle issues.

7. **Software Margins Under Pressure**: CloudSync Pro has lowest GM at 49.8% despite being a software product, suggesting pricing or cost structure review needed.

---

## Recommendations

1. **West Region Action Plan**: Conduct deep-dive with Emily Rodriguez to identify root causes. Consider territory realignment, additional sales resources, or competitive analysis. The -13% variance significantly impacts company performance.

2. **Double Down on EdgeCompute**: Allocate additional R&D and marketing resources to EdgeCompute Device given 42% growth trajectory. Explore expansion into adjacent markets.

3. **SecureNode Product Review**: Initiate product lifecycle assessment - consider refresh, repositioning, or gradual phase-out in favor of higher-growth alternatives.

4. **Supply Chain Risk Mitigation**: Q2 2023 cost shock demonstrates vulnerability. Recommend diversifying suppliers and implementing cost hedging strategies.

5. **CloudSync Pro Pricing Analysis**: At 49.8% GM (lowest in portfolio), review pricing strategy and cost structure for margin improvement opportunities. 

---

## Technical Stack

- **Database**: SQLite (portable, easy to demonstrate)
- **Data Generation**: Python (pandas, numpy)
- **BI Tool**: Power BI
- **Version Control**: Git

---

## How to Use This Project

1. **Review the Data Model**: See `docs/data_dictionary.md` for detailed field descriptions
2. **Explore the Database**: Run `sql/schema.sql` then `sql/views.sql` in any SQLite client
3. **Open the Dashboard**: `bi/finance_dashboard.pbix` contains the interactive reports

---

## Author

Portfolio project demonstrating FP&A analytics capabilities including data modeling, SQL, and business intelligence dashboard development.
