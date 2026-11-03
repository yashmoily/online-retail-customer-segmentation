# Online Retail Customer Segmentation

## Project Overview

This project analyses customer purchasing behaviour using **RFM (Recency, Frequency, Monetary) analysis** and applies **K-Means clustering** to identify meaningful customer segments.

The objective is to understand customer value, identify high-value customers, and develop actionable business recommendations using historical retail transaction data.

## Business Objectives

- Analyse customer purchasing behaviour.
- Identify high-value, regular, one-time and inactive customers.
- Compare feature transformations for clustering.
- Evaluate clustering performance using multiple metrics.
- Translate customer segments into practical business recommendations.

## Dataset

**Source:** [UCI Machine Learning Repository — Online Retail](https://archive.ics.uci.edu/dataset/352/online+retail)

The dataset contains transactions from a UK-based online retailer between December 2010 and December 2011.

The original dataset contains 541,909 transaction records.

## Tools and Technologies

- Python
- Pandas and NumPy
- Matplotlib
- Scikit-learn
- RFM Analysis
- K-Means Clustering
- Google Colab

## Project Workflow

1. **Data Preparation:** Imported and validated SQL-prepared transaction data.
2. **Exploratory Data Analysis:** Examined sales trends, countries and products.
3. **RFM Analysis:** Calculated customer-level Recency, Frequency and Monetary metrics.
4. **Feature Transformation:** Compared Signed Log and Yeo-Johnson transformations.
5. **Clustering Evaluation:** Compared clustering configurations using Silhouette Score, Davies-Bouldin Index and Calinski-Harabasz Score.
6. **Customer Segmentation:** Selected a five-cluster K-Means model.
7. **Model Validation:** Evaluated consistency across different random initialisation seeds.
8. **Business Analysis:** Interpreted customer segments and developed recommendations.

## Customer Segmentation Results

The selected model uses Yeo-Johnson transformed RFM features, StandardScaler and K-Means with five clusters.

| Customer Segment | Customers | Customer Share | Net Monetary Contribution |
|---|---:|---:|---:|
| Regular Customers | 1,169 | 26.97% | 17.78% |
| High-Value Active Customers | 993 | 22.91% | 42.05% |
| Recent One-Time Customers | 983 | 22.68% | 5.24% |
| Lapsed Customers | 1,148 | 26.49% | 5.27% |
| VIP Customers | 41 | 0.95% | 29.67% |

**Total customers analysed:** 4,334

## Key Findings

- VIP customers account for just 0.95% of the customer base but contribute 29.67% of net monetary value.
- High-Value Active customers contribute the largest share at 42.05%.
- Recent One-Time and Lapsed customers together represent approximately 49.17% of customers but contribute only 10.51% of net monetary value.
- The selected five-cluster model achieved a Silhouette Score of approximately 0.363.
- The average Adjusted Rand Index across six alternative random initialisation seeds was approximately 0.9975.

## Business Recommendations

- **VIP Customers:** Prioritise retention through loyalty programmes and personalised service.
- **High-Value Active Customers:** Focus on customer retention and relevant cross-selling opportunities.
- **Regular Customers:** Encourage repeat purchases through targeted campaigns.
- **Recent One-Time Customers:** Develop strategies to encourage a second purchase.
- **Lapsed Customers:** Test targeted reactivation campaigns.

## Important Limitations

- The analysis is based on historical transactions from approximately one year.
- Customer segments are calculated using a fixed reference date of 10 December 2011.
- Monetary value aggregates eligible sales and cancellation lines at customer level; exact original-order cancellation matching has not been established.
- The stability test measures consistency across random initialisations, not stability across different samples or time periods.
- Business recommendations are proposed actions and have not been validated through campaign experiments.

## Repository Contents

- `Online_Retail_Customer_Segmentation.ipynb` — Complete analysis, modelling, evaluation and visualisations.
- `RFM_Segmented.csv` — Final customer-level dataset with assigned segments.
- `README.md` — Project documentation.

## How to Run

1. Download the notebook from this repository.
2. Obtain the original dataset from the UCI Machine Learning Repository.
3. Prepare the three CSV input files expected by the notebook:
   - `RFM_Base.csv`
   - `Product Sales.csv`
   - `Net Sales.csv`
4. Update the dataset paths in the notebook to match your environment.
5. Run the notebook from beginning to end.

The three prepared input CSV files are not included in this repository.

---

**Project Focus:** Customer Analytics | RFM Analysis | Machine Learning | K-Means Clustering