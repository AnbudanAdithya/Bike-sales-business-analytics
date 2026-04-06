# ------------------------------------------------------------------------------ 
# 1. Load required libraries
# dplyr, ggplot2, caret, corrplot, readxl, tidyr, MASS
# ------------------------------------------------------------------------------

library(dplyr)
library(ggplot2)
library(caret)
library(corrplot)
library(tidyr)
library(readxl)
library(patchwork)

# ------------------------------------------------------------------------------ 
# 2. Import the dataset: Bike_Sales
# ------------------------------------------------------------------------------

# Load the excel dataset
Bike_Sales <- read_excel("D:/COLLEGE/MBA/SEMESTERS/II Semester/MBAG - 204 - Business Analytics 1/Master Project/DataSets/Bike_Sales.xlsx")
View(Bike_Sales)

# Assign a name to the dataset 
data <- Bike_Sales

# View initial records
head(data)

# ------------------------------------------------------------------------------ 
# 3. Data Cleaning & Preparation
# ------------------------------------------------------------------------------
 
# Remove Column "ID" - Not useful for analysis
data <- subset(data, select = -ID)

# Check for missing values
colSums(is.na(data))
# No missing values - no need for imputing missing values

# ------------------------------------------------------------------------------ 
# 4. Outlier detection - box plots: Income, Age, No. of children and cars owned 
# ------------------------------------------------------------------------------

# Box Plot for Age
B1 <- ggplot(data, aes(y = Age)) +
  geom_boxplot(fill = "lightblue", color = "black", outlier.color = "red") +
  labs(
    title = "Customer Age",
    y = "Age",
    x = ""
  ) +
  theme_minimal(base_size = 14)+
  theme(plot.title = element_text(size = 12))

# Box Plot for Income
B2 <- ggplot(data, aes(y = Income)) +
  geom_boxplot(fill = "lightgreen", color = "black", outlier.color = "red") +
  labs(
    title = "Customer Income",
    y = "Income (in USD)",
    x = ""
  ) +
  theme_minimal(base_size = 14)+
  theme(plot.title = element_text(size = 12))

# Box Plot for Number of Children
B3 <- ggplot(data, aes(y = Children)) +
  geom_boxplot(fill = "orange", color = "black", outlier.color = "red") +
  labs(
    title = "Number of Children",
    y = "Children",
    x = ""
  ) +
  theme_minimal(base_size = 14)+
  theme(plot.title = element_text(size = 12))

# Box Plot for Number of Cars owned
B4 <- ggplot(data, aes(y = Cars)) +
  geom_boxplot(fill = "pink", color = "black", outlier.color = "red") +
  labs(
    title = "Number of Cars",
    y = "Cars",
    x = ""
  ) +
  theme_minimal(base_size = 14)+
  theme(plot.title = element_text(size = 12))

# Combine all 4 plots in one row (you can customize layout)
combined_plot <- (B1 | B2 | B3 | B4) +
  plot_annotation(title = "Box Plots showing distributions",
                  theme = theme(plot.title = element_text(hjust = 0.5, 
                                                          size = 12)))

# Print the combined plot
combined_plot
# There seems to be no outliers in the dataset. Therefore, no need to remove any

# ------------------------------------------------------------------------------ 
# 5. Data Transformation 
# ------------------------------------------------------------------------------

# Convert categorical variables to factors
data <- data %>% mutate_if(is.character, as.factor)

# Copy and convert factors to numeric (for modelling)
data_numeric <- data %>%
  mutate_if(is.factor, as.numeric)

# ------------------------------------------------------------------------------ 
# 6. Exploratory Data Analysis (EDA)
# ------------------------------------------------------------------------------

# Summary Statistics
summary(data)

# Visualizations 

# Histogram of Age
ggplot(data, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Age", x = "Age", y = "Frequency") +
  geom_text(stat = "bin", binwidth = 5,
            aes(label = ..count..), vjust = -0.5) +
  theme_minimal()

# Histogram for Income Distribution
ggplot(data, aes(x = Income)) +
  geom_histogram(binwidth = 10000, fill = "#2ecc71", color = "black", alpha = 0.8) +
  labs(
    title = "Histogram of Customer Income Distribution",
    x = "Income (in USD)",
    y = "Frequency") +
    geom_text(stat = "bin", binwidth = 10000,
            aes(label = ..count..), vjust = -0.5) +
  theme_minimal(base_size = 14)

# Pie Chart: Ratio of Purchased to not purchased
purchase_counts <- data %>%
  group_by(`Purchased Bike`) %>%
  summarise(Count = n())

# Create the pie chart
ggplot(purchase_counts, aes(x = "", y = Count, fill = `Purchased Bike`)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  coord_polar("y", start = 0) +
  labs(
    title = "Bike Purchase Status",
    fill = "Purchased"
  ) +
  theme_void(base_size = 14) +
  scale_fill_manual(values = c("Yes" = "blue", "No" = "red"))

# Correlation Matrix
corr_matrix <- cor(data_numeric, use = "complete.obs")
corrplot(corr_matrix, method = "color", 
         type = "upper", 
         tl.cex = 0.7,
         addCoef.col = "black",   # add correlation coefficients
         number.cex = 0.5,        # size of correlation numbers
         tl.col = "black", )

# -----------------------------------------------------------------------------
# 7. Predictive Modelling - Logistic Regression
# -----------------------------------------------------------------------------

# Task: Predict whether a customer will buy the bike or not

# Convert Purchased Bike to binary (Yes = 1, No = 0)
data$`Purchased Bike` <- ifelse(data$`Purchased Bike` == "Yes", 1, 0)

# Update the dataset
data_numeric <- data %>%
  mutate_if(is.factor, as.numeric)

# Create training and test data sets (80/20 split)
set.seed(123)  # for reproducibility
splitIndex <- createDataPartition(data$`Purchased Bike`, p = 0.8, list = FALSE)
train_data <- data[splitIndex, ]
test_data <- data[-splitIndex, ]

# Fit the logistic Regression Model
model_bike <- glm(`Purchased Bike` ~ .,data = train_data, family = "binomial")

# Predict class probabilities
pred_probs <-predict(model_bike, newdata=test_data, type = "response")
pred_probs

# Convert to class labels (threshold = 0.5)
pred_class <- ifelse(pred_probs > 0.5, 1, 0)
pred_class

# -----------------------------------------------------------------------------
# 8. Model Evaluation - Accuracy and Confusion Matrix
# -----------------------------------------------------------------------------

# Compute accuracy
accuracy <- mean(pred_class == test_data$`Purchased Bike`)
cat("Accuracy of the logistic regression model:", round(accuracy * 100, 2), "%\n")

# Result: Model is 65.5% accurate

# Confusion Matrix
pred_factor <- as.factor(pred_class)
actual_factor <- as.factor(test_data$`Purchased Bike`)
conf_matrix <- confusionMatrix(pred_factor, actual_factor)
print(conf_matrix)