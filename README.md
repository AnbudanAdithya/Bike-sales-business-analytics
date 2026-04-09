[![Kaggle](https://img.shields.io/badge/Kaggle-View_Live_Notebook-20BEFF?logo=Kaggle&logoColor=white)](https://www.kaggle.com/code/anbudanadithya05/bike-sales-r)
# 🚲 Bike Sales Business Analytics & Predictive Modeling

## 📌 Project Overview
This repository contains the complete analytical workflow for the **MBAG-204 Master Project**, focusing on customer behavior and purchase drivers in the retail bicycle market. 

By applying exploratory data analysis (EDA) and predictive modeling in R, this project identifies the demographic and financial factors that most heavily influence a customer's likelihood to purchase a bike. The insights generated are designed to inform targeted marketing strategies and optimize inventory planning.

## 🎯 Business Objectives
* **Customer Segmentation:** Identify the core demographic profile of a typical bike buyer (age, income, occupation, region).
* **Purchase Prediction:** Build a predictive model to classify whether a prospect is likely to purchase a bike based on historical data.
* **Strategic Insights:** Translate statistical findings into actionable business recommendations.

## 📂 Repository Structure
* `MBAG - 204 - Master Project - Bike Sales.R`: The core R script containing data cleaning, transformation, EDA, and the predictive modeling pipeline (Logistic Regression).
* `Bike_Buyers.xlsx`: The raw dataset containing customer demographics, commute distances, and purchase history.

## 🛠️ Tech Stack & Methodologies
* **Language:** R
* **Libraries Used:** `dplyr`, `ggplot2`, `caret`, `corrplot`, `tidyr`, `readxl`, `patchwork`
* **Techniques:** * Data Wrangling & Outlier Detection
  * Exploratory Data Analysis (EDA) & Data Visualization
  * Correlation Analysis
  * Predictive Classification Modeling

## 📊 Key Business Insights
* **[Insight 1]:** *e.g., Customers with a commute distance of 0-1 miles are X% more likely to purchase a bike compared to those commuting 5+ miles.*
* **[Insight 2]:** *e.g., The 'Professional' occupation segment showed the highest conversion rate across all regions.*
* **[Model Performance]:** *e.g., The predictive model achieved an accuracy of X% in identifying future buyers, providing a reliable tool for lead scoring.*

*(For a deep dive into the methodology and strategic recommendations, please refer to the attached `Bike_Sales Analytics.pdf`)*

## 🚀 How to Run the Code
1. Clone this repository to your local machine.
2. Ensure you have R and the required packages installed.
3. Update the file path in the R script to point to the `Bike_Buyers.csv` file.
4. Run the script sequentially to view the data transformations, generate the visualizations, and evaluate the model.
