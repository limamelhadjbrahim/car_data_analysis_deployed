# Car Data Extraction and Analysis Project

## 1. Project Overview

This project focuses on **extracting**, **cleaning**, **analyzing**, and **visualizing** car sale data from a website using **R**, **Shiny**, and **Plotly**.  
The final product is a **Shiny web app** offering various insights into the car sales data in Qatar.

---

## 2. Data Extraction and Cleaning

- We first created a script `Extract_Car_Details.R` that:
  - Scraped data from `https://qatarsale.com/en/products/cars_for_sale=`
  - Extracted information about each car: **Brand**, **Model**, **Seller**, **Year**, **Gear Type**, **Cylinder**, **Mileage**, **Price**, and **Currency**
  - Cleaned the data: removing commas, transforming types, removing missing values.
  
- After gathering around **1000 cars**, we saved the resulting dataset as an `.rds` file:

```r
saveRDS(car_dataset, file = "car_dataset.rds")
```

This allowed us to load it quickly later without re-scraping.

---

## 3. Preview of the Car Dataset

After processing and cleaning, the **head** of the `car_dataset` looks like this:

```r
head(car_dataset)
```

Example output:

| Brand     | Model                | Seller         | Year | Gear_Type | Cylinder | Mileage | Price  | Currency |
|-----------|-----------------------|----------------|------|-----------|----------|---------|--------|----------|
| Toyota    | Land Cruiser GXR       | Private Seller | 2018 | Automatic | 6        | 52000   | 220000 | Q.R      |
| Nissan    | Patrol Platinum        | Dealer         | 2019 | Automatic | 8        | 34000   | 270000 | Q.R      |
| Lexus     | LX570                   | Private Seller | 2020 | Automatic | 8        | 12000   | 430000 | Q.R      |
| ...       | ...                     | ...            | ...  | ...       | ...      | ...     | ...    | ...      |

---

## 4. Deployment of the Shiny App

We created an app by:
- Renaming `Car_Data_Insights.R` into `app.R`
- Modifying it to directly load the dataset via:

```r
car_dataset <- readRDS("car_dataset.rds")
```

- Deploying it using:

```r
library(rsconnect)

rsconnect::setAccountInfo(name='my_name',
                          token='my_token',
                          secret='my_secret_code')

deployApp()
```

---

## 5. Visualizations and Their Interpretations

The Shiny app provides several **interactive visualizations** to explore the dataset.

### 5.1 Boxplots

#### - Boxplot of Prices by Brand

- **Purpose**: Shows the distribution of car prices for each brand.
- **Insight**: You can see the **median**, **interquartile range**, and **outliers** of car prices for brands like Toyota, Nissan, Lexus, etc.

![Price Boxplot Example]



















---

#### - Boxplot of Mileage by Brand

- **Purpose**: Displays the mileage (in kilometers) distribution for each car brand.
- **Insight**: Helps understand which brands tend to have lower or higher mileage.

![Mileage Boxplot Example]



















---

### 5.2 Scatter Plots

#### - Mileage vs. Price Scatter Plot

- **Purpose**: Shows the relationship between **mileage** and **price**.
- **Insight**: Generally, cars with **lower mileage** tend to have **higher prices**.

![Mileage vs Price Scatter]





















---

#### - Year of Manufacture vs. Price Scatter Plot

- **Purpose**: Visualizes how the **year of manufacture** correlates with **price**.
- **Insight**: **Newer cars** (recent years) have **higher prices** compared to older cars.

![Year vs Price Scatter]





















---

### 5.3 Pie Chart

#### - Proportion of Cars Sold by Different Sellers

- **Purpose**: Displays the share of car sales by different types of sellers (e.g., private sellers vs dealers).
- **Insight**: Understands market share distribution among different sellers.

![Seller Pie Chart Example]





















---

### 5.4 Histograms

#### - Histogram of Prices by Brand

- **Purpose**: Shows the distribution of car prices for each brand.
- **Insight**: Allows you to see the **most common price ranges** for each brand.

![Price by Brand Histogram]





















---

#### - Histogram of Prices by Year

- **Purpose**: Shows price distribution grouped by car's manufacturing year.
- **Insight**: Reveals how prices are spread across different years.

![Price by Year Histogram]





















---

### 5.5 Bar Charts

#### - Count of Cars by Gear Type

- **Purpose**: Number of cars categorized by gear type (e.g., Automatic vs Manual).
- **Insight**: Helps see which transmission type is more common.

![Gear Type Bar Chart]





















---

#### - Number of Cars Sold by Seller

- **Purpose**: Number of cars sold by each seller.
- **Insight**: Identifies the most active sellers in the market.

![Seller Count Bar Chart]



















---

### 5.6 Cylinder vs Price Bar Chart

- **Purpose**: Shows the **average car price** grouped by **cylinder count**.
- **Insight**: Typically, cars with **more cylinders** are **more expensive**.

![Cylinder vs Price Chart]





















---

## 6. Conclusion

Through this project, we:
- **Extracted**, **processed**, and **analyzed** car sales data from a real-world website.
- Created **interactive visualizations** to understand trends in price, mileage, seller type, and car specifications.
- Built and deployed a fully functional **Shiny application** to make this analysis accessible online.

---


