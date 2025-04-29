# Car Data Extraction and Analysis Project

## 1. Project Overview

This project focuses on **extracting**, **cleaning**, **analyzing**, and **visualizing** car sale data from a website using **R**, **Shiny**, and **Plotly**.  
The final product is a **Shiny web app** offering various insights into the car sales data in Qatar.

---

## 2. Data Extraction and Cleaning

- We first created a script `Extract_Car_Details.R` that:
  - Scraped data from `https://qatarsale.com/en/products/cars_for_sale`
  - Extracted information about each car: **Brand**, **Model**, **Seller**, **Year**, **Gear Type**, **Cylinder**, **Mileage**, **Price**, and **Currency**
  - Cleaned the data: transforming types, removing missing values.
  
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
| Land Rover    | Range Rover Vogue SE Super charged       | Personal | 2017 | Automatic | 8        | 122000   | 109000 | Q.R      |
| GMC    | Yukon XL        | Personal         | 2015 | Automatic | 8        | 145000   | 53000 | Q.R      |
| Mercedes-Benz     | GLE 53 AMG Coupe                  | Personal | 2023 | Automatic | 6       | 19000   | 377000 | Q.R      |
| ...       | ...                     | ...            | ...  | ...       | ...      | ...     | ...    | ...      |

---

## 4. Deployment of the Shiny App

We created an app by:
- Renaming `Car_Data_Insights.R` into `app.R`
- Modifying it to directly load the dataset via:

```r
car_dataset <- readRDS("car_dataset.rds")
```

- I created a new folder named CarApp where I copied the files car_dataset.rds and app.R. Then, I set the R working directory to this location and made the deployment using:

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

#### - Boxplots of Prices and Mileage by Brand

- **Purpose**: Shows the distribution of car prices for each brand. Displays the mileage (in kilometers) distribution for each car brand.
- **Insight**: You can see the **median**, **interquartile range**, and **outliers** of car prices for brands like Toyota, Nissan, Lexus, etc.
- Helps understand which brands tend to have lower or higher mileage.

![Price Boxplot Example](https://github.com/limamelhadjbrahim/car_data_analysis_deployed/blob/main/Boxplots.png)



















---
















### 5.2 Scatter Plots

#### -Scatter Plots of Mileage vs. Price and Year of Manufacture vs. Price

- **Purpose**: Shows the relationship between **mileage** and **price**.
- Visualizes how the **year of manufacture** correlates with **price**.
- **Insight**: Generally, cars with **lower mileage** tend to have **higher prices**.
- **Newer cars** (recent years) have **higher prices** compared to older cars.

![Mileage vs Price Scatter](https://github.com/limamelhadjbrahim/car_data_analysis_deployed/blob/main/scatter%20.png)





















---



















### 5.3 Pie Chart

#### - Proportion of Cars Sold by Different Sellers

- **Purpose**: Displays the share of car sales by different types of sellers (e.g., private sellers vs dealers).
- **Insight**: Understands market share distribution among different sellers.

![Seller Pie Chart Example](https://github.com/limamelhadjbrahim/car_data_analysis_deployed/blob/main/proportions%20car%20seller%20.png)





















---

### 5.4 Histograms

#### - Histograms of Prices by Brand and Year

- **Purpose**: Shows the distribution of car prices for each brand.
- Shows price distribution grouped by car's manufacturing year.
- **Insight**: Allows you to see the **most common price ranges** for each brand.
- Reveals how prices are spread across different years.

![Price by Brand Histogram](https://github.com/limamelhadjbrahim/car_data_analysis_deployed/blob/main/Histograms.png)





















---



### 5.5 Bar Charts

#### - Counts of Cars by Gear Type and by Seller

- **Purpose**: Number of cars categorized by gear type (e.g., Automatic vs Manual).
- Number of cars by seller.
- **Insight**: Helps see which transmission type is more common.
- Identifies the most active sellers in the market.

![Gear Type Bar Chart](https://github.com/limamelhadjbrahim/car_data_analysis_deployed/blob/main/Bar%20charts.png)





















---






### 5.6 Cylinder vs Price Bar Chart

- **Purpose**: Shows the **average car price** grouped by **cylinder count**.
- **Insight**: Typically, cars with **more cylinders** are **more expensive**.

![Cylinder vs Price Chart](https://github.com/limamelhadjbrahim/car_data_analysis_deployed/blob/main/Price%20vs%20Cylinder%20count.png)





















---

## 6. Conclusion

Through this project, I:
- **Extracted**, **processed**, and **analyzed** car sales data from a real-world website.
- Created **interactive visualizations** to understand trends in price, mileage, seller type, and car specifications.
- Built and deployed a fully functional **Shiny application** to make this analysis accessible online.

---


