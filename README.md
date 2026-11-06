# Online Retail Customer Segmentation

## Project Overview

This project uses **RFM (Recency, Frequency, Monetary) analysis and K-Means clustering** to segment customers from an online retail dataset.

The objective is to identify different customer groups based on purchasing behaviour, understand their contribution to overall revenue, and generate actionable business insights.

The project follows an end-to-end data analysis workflow using Microsoft SQL Server, Python and Power BI.

## Business Objectives

- Identify meaningful customer segments based on purchasing behaviour.
- Understand customer recency, purchase frequency and monetary value.
- Identify high-value and potentially inactive customers.
- Analyse revenue contribution across different customer segments.
- Develop data-driven recommendations for customer retention and engagement.

## Tools and Technologies

| Tool | Purpose |
|---|---|
| Microsoft SQL Server | Data preparation, RFM calculations and validation |
| SQL / T-SQL | Data extraction, aggregation and diagnostics |
| Python | Data analysis and customer segmentation |
| Pandas & NumPy | Data manipulation |
| Scikit-learn | Data transformation, K-Means clustering and model evaluation |
| Matplotlib & Seaborn | Exploratory data visualisation |
| Power BI | Interactive dashboard and business reporting |
| Jupyter Notebook | Python development environment |

## Dataset Description

The project uses an online retail transactional dataset containing customer purchases, product details, invoice information and transaction values.

The final customer-level segmentation dataset contains **4,334 unique customers and 7 columns**.

### Final Dataset Schema

| Column Name | Data Type | Description |
|---|---|---|
| CustomerID | Integer | Unique identifier assigned to each customer |
| LastPurchaseDate | Datetime | Date and time of the customer's most recent purchase |
| Frequency | Integer | Number of distinct purchase invoices made by the customer |
| Monetary | Decimal | Customer's net monetary value after accounting for cancellations |
| Recency | Integer | Number of days since the customer's last purchase, measured relative to the analysis reference date |
| Cluster | Integer | Cluster identifier assigned by the K-Means algorithm |
| Segment | String | Business-oriented customer segment name assigned to each cluster |

### RFM Metrics

- **Recency:** Measures how recently a customer made a purchase. Lower values indicate more recent activity.
- **Frequency:** Measures how often a customer purchases, based on distinct invoices.
- **Monetary:** Measures the customer's net spending value.

These metrics provide the foundation for identifying different customer purchasing patterns.

## Project Workflow

The project follows three main stages:

### 1. SQL – Data Preparation and Validation

SQL Server was used to prepare and validate the customer-level RFM dataset.

Key activities:

- Reused existing sales views from the original [Online Retail Sales Analysis](https://github.com/yashmoily/online-retail-sales-analysis) project.
- Calculated customer purchase frequency using distinct invoices.
- Identified each customer's last purchase date.
- Calculated net monetary value using sales and cancellation information.
- Investigated customers with non-positive monetary values.
- Performed validation checks on the resulting RFM dataset.

**Output:** `RFM_Base.csv`

The SQL diagnostics script depends on the following views from the original SQL project:

- `dbo.vw_OnlineRetail_ProductSales`
- `dbo.vw_OnlineRetail_NetSales`

### 2. Python – RFM Analysis and Customer Segmentation

Python was used to transform the RFM dataset, perform clustering and interpret customer behaviour.

Key activities:

- Explored and validated the RFM dataset.
- Analysed Recency, Frequency and Monetary distributions.
- Applied Yeo-Johnson transformation to reduce feature skewness.
- Standardised features using StandardScaler.
- Applied K-Means clustering.
- Evaluated clustering performance and stability.
- Assigned business-oriented names to the resulting customer segments.

**Clustering configuration:**

| Parameter | Value |
|---|---|
| Algorithm | K-Means |
| Number of clusters | 5 |
| Feature transformation | Yeo-Johnson |
| Feature scaling | StandardScaler |
| Silhouette Score | Approximately 0.363 |
| Average Adjusted Rand Index | Approximately 0.9975 |

The Adjusted Rand Index was calculated across six random initialisation seeds to assess clustering stability.

**Output:** `RFM_Segmented.csv`

### 3. Power BI – Dashboard and Business Analysis

Power BI was used to develop an interactive dashboard based on the final customer segmentation output.

The dashboard contains two pages:

**Page 1 – Customer Segmentation Overview**

- Total customers
- Total net monetary value
- Average recency
- Average purchase frequency
- Customer distribution by segment
- Net monetary contribution by segment
- Customer segment performance table

**Page 2 – Customer Segment Analysis**

- Segment-based filtering
- Average recency comparison
- Average purchase frequency comparison
- Average monetary value
- Detailed customer segment performance

## Customer Segmentation Results

The final analysis identified five customer segments across **4,334 customers**.

| Customer Segment | Customers | Customer Share | Revenue Contribution |
|---|---:|---:|---:|
| Regular Customers | 1,169 | 26.97% | 17.78% |
| High-Value Active Customers | 993 | 22.91% | 42.05% |
| Recent One-Time Customers | 983 | 22.68% | 5.24% |
| Lapsed Customers | 1,148 | 26.49% | 5.27% |
| VIP Customers | 41 | 0.95% | 29.67% |

**Total customers:** 4,334

**Total net monetary value:** £8,269,399.91

*Revenue contribution percentages may not add up to exactly 100% due to rounding.*

## Key Business Insights

### 1. High-Value Customers Drive Revenue

High-Value Active Customers represent approximately 22.91% of customers but contribute 42.05% of total net monetary value.

This segment represents an important group for customer retention and loyalty initiatives.

### 2. VIP Customers Have a Significant Revenue Contribution

VIP Customers account for only 0.95% of the customer base but contribute 29.67% of total net monetary value.

Maintaining relationships with these customers should be a business priority.

### 3. Recent One-Time Customers Present an Engagement Opportunity

Recent One-Time Customers account for 22.68% of customers but contribute only 5.24% of monetary value.

Targeted engagement and repeat-purchase campaigns could help encourage further purchases.

### 4. Lapsed Customers May Require Reactivation Strategies

Lapsed Customers represent 26.49% of customers but contribute only 5.27% of monetary value.

Reactivation campaigns and targeted offers could help assess whether these customers can be brought back.

### 5. Revenue Is Concentrated Among High-Value Segments

VIP and High-Value Active Customers together contribute approximately **71.72% of total net monetary value**.

This highlights the importance of retaining high-value customers while developing strategies to improve the purchasing behaviour of other segments.

## Repository Structure

```text
online-retail-customer-segmentation/
│
├── 01_SQL/
│   └── 01_RFM_Data_Validation_Diagnostics.sql
│
├── 02_Python/
│   └── Online_Retail_Customer_Segmentation.ipynb
│
├── 03_PowerBI/
│   ├── Online_Retail_Customer_Segmentation.pbix
│   └── Dashboard_Screenshots/
│       ├── Page_1_Overview.png
│       └── Page_2_Analysis.png
│
├── 04_Output/
│   └── RFM_Segmented.csv
│
├── README.md
└── .gitignore
```

## How to Explore the Project

1. Review the SQL diagnostics script in `01_SQL`.
2. Open the Python notebook in `02_Python` to understand the RFM analysis, feature transformation and clustering process.
3. Review `RFM_Segmented.csv` in `04_Output` for the final customer-level segmentation results.
4. Open the Power BI file in `03_PowerBI` to explore the interactive dashboard.

**Note:** The SQL diagnostics script requires the two SQL views created in the companion Online Retail Sales Analysis project.

## Limitations and Considerations

- Customer-level segmentation requires an identifiable CustomerID. Transactions without a CustomerID cannot be reliably assigned to individual customer segments.
- Non-positive monetary values were investigated and retained rather than automatically removed.
- K-Means is an unsupervised clustering algorithm; the resulting segments are exploratory groups, not guaranteed future customer behaviour.
- Business-oriented segment names are interpretations of the resulting cluster characteristics.
- The clustering results depend on the dataset, feature transformations and selected number of clusters.

## Related Project

**Online Retail Sales Analysis – SQL Server**

[View the companion SQL project](https://github.com/yashmoily/online-retail-sales-analysis)

---

**Project Focus:** SQL Data Analysis | RFM Analysis | Customer Segmentation | Machine Learning | Power BI Dashboard