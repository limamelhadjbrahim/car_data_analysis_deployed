# Load libraries
library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)

car_dataset <- readRDS("car_dataset.rds")

# Define UI for the app
ui <- navbarPage("Car Data Analysis",
                 tabPanel("Overview",
                          fluidPage(
                            titlePanel("Overview of the Car Data Analysis App"),
                            p("This app provides various visualizations to analyze car data. Below is a brief description of each page:"),
                            tags$ul(
                              tags$li("Boxplots: Interactive boxplots of car prices and mileage by brand."),
                              tags$li("Scatter Plots: Interactive scatter plots showing the relationship between mileage and price, and year of manufacture and price."),
                              tags$li("Pie Chart: Proportion of cars sold by different sellers."),
                              tags$li("Histograms: Distribution of car prices and mileage."),
                              tags$li("Bar Charts: Count of cars by gear type and seller."),
                              tags$li("Cylinder vs Price Bar Chart: Average car price by cylinder count.")
                            )
                          )
                 ),
                 tabPanel("Boxplots",
                          fluidPage(
                            titlePanel("Interactive Boxplots of Prices and Mileage by Brand"),
                            fluidRow(
                              column(6, plotlyOutput("priceBoxplot")),
                              column(6, plotlyOutput("mileageBoxplot"))
                            ),
                            fluidRow(
                              column(6, p("This boxplot shows the distribution of car prices by brand in Qatari Riyal (Q.R).")),
                              column(6, p("This boxplot shows the distribution of car mileage by brand."))
                            )
                          )
                 ),
                 tabPanel("Scatter Plots",
                          fluidPage(
                            titlePanel("Interactive Scatter Plots"),
                            fluidRow(
                              column(6, plotlyOutput("mileagePriceScatter")),
                              column(6, plotlyOutput("yearPriceScatter"))
                            ),
                            fluidRow(
                              column(6, p("This scatter plot shows the relationship between car mileage and price in Qatari Riyal (Q.R).")),
                              column(6, p("This scatter plot shows the relationship between the year of manufacture and car price in Qatari Riyal (Q.R)."))
                            )
                          )
                 ),
                 tabPanel("Pie Chart",
                          fluidPage(
                            titlePanel("Proportion of Cars Sold by Different Sellers"),
                            plotlyOutput("pieChart"),
                            p("This pie chart shows the proportion of cars sold by different sellers.")
                          )
                 ),
                 tabPanel("Histograms",
                          fluidPage(
                            titlePanel("Distribution of Car Prices and Mileage"),
                            fluidRow(
                              column(6, plotlyOutput("priceHistogramBrand")),
                              column(6, plotlyOutput("priceHistogramYear"))
                            ),
                            fluidRow(
                              column(6, p("This histogram shows the distribution of car prices by brand in Qatari Riyal (Q.R).")),
                              column(6, p("This histogram shows the distribution of car prices by year in Qatari Riyal (Q.R)."))
                            )
                          )
                 ),
                 tabPanel("Bar Charts",
                          fluidPage(
                            titlePanel("Count of Cars by Gear Type and Seller"),
                            fluidRow(
                              column(6, plotlyOutput("gearTypeBarChart")),
                              column(6, plotlyOutput("sellerBarChart"))
                            ),
                            fluidRow(
                              column(6, p("This bar chart shows the count of cars by gear type.")),
                              column(6, p("This bar chart shows the number of cars sold by each seller."))
                            )
                          )
                 ),
                 tabPanel("Cylinder vs Price Bar Chart",
                          fluidPage(
                            titlePanel("Average Car Price by Cylinder Count"),
                            plotlyOutput("cylinderPriceBarChart"),
                            p("This bar chart shows the average car price by cylinder count in Qatari Riyal (Q.R).")
                          )
                 )
)

# Define server logic for the app
server <- function(input, output) {
  output$priceBoxplot <- renderPlotly({
    # Filter the dataset for the currency Qatari riyal
    filtered_data <- car_dataset[car_dataset$Currency == "Q.R", ]
    
    # Create the boxplot for prices
    p <- ggplot(filtered_data, aes(x = Brand, y = Price)) +
      geom_boxplot() +
      labs(title = "Boxplot of Prices by Brand(Q.R)", x = "Brand", y = "Price (Qatari Riyal)") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    ggplotly(p) %>%
      layout(yaxis = list(tickformat = ".0f"))  # Ensure complete numbers are shown on y-axis
  })
  
  output$mileageBoxplot <- renderPlotly({
    # Create the boxplot for mileage
    p <- ggplot(car_dataset, aes(x = Brand, y = Mileage)) +
      geom_boxplot() +
      labs(title = "Boxplot of Mileage by Brand", x = "Brand", y = "Mileage (Kilometers)") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    ggplotly(p) %>%
      layout(yaxis = list(tickformat = ".0f"))  # Ensure complete numbers are shown on y-axis
  })
  
  output$mileagePriceScatter <- renderPlotly({
    # Filter the dataset for the currency Qatari riyal
    filtered_data <- car_dataset[car_dataset$Currency == "Q.R", ]
    # Create the scatter plot for mileage vs. price
    p <- ggplot(filtered_data, aes(x = Mileage, y = Price, color = Brand, text = Model)) +
      geom_point() +
      labs(title = "Mileage vs. Price(Q.R)", x = "Mileage (Kilometers)", y = "Price (Qatari Riyal)") +
      theme_minimal()
    
    ggplotly(p)
  })
  
  output$yearPriceScatter <- renderPlotly({
    # Filter the dataset for the currency Qatari riyal
    filtered_data <- car_dataset[car_dataset$Currency == "Q.R", ]
    # Create the scatter plot for year  vs. price
    p <- ggplot(filtered_data, aes(x = Year, y = Price, color = Brand, text = Model)) +
      geom_point() +
      labs(title = "Year of Manufacture vs. Price(Q.R)", x = "Year of Manufacture", y = "Price (Qatari Riyal)") +
      theme_minimal()
    
    ggplotly(p)
  })
  
  output$pieChart <- renderPlotly({
    seller_data <- car_dataset %>%
      group_by(Seller) %>%
      summarise(Count = n())
    p <- plot_ly(seller_data, labels = ~Seller, values = ~Count, type = 'pie') %>%
      layout(title = 'Proportion of Cars Sold by Different Sellers')
    p
  })
  
  output$priceHistogramBrand <- renderPlotly({
    # Filter the dataset for the currency Qatari riyal
    filtered_data <- car_dataset[car_dataset$Currency == "Q.R", ]
    p <- ggplot(filtered_data, aes(x = Price, fill = Brand)) +
      geom_histogram(binwidth = 1000) +
      labs(title = "Distribution of Car Prices by Brand", x = "Price (Qatari Riyal)", y = "Count") +
      theme_minimal()
    ggplotly(p)
  })
  
  output$priceHistogramYear <- renderPlotly({
    # Filter the dataset for the currency Qatari riyal
    filtered_data <- car_dataset[car_dataset$Currency == "Q.R", ]
    
    p <- ggplot(filtered_data, aes(x = Price, fill = Year)) +
      geom_histogram(binwidth = 1000) +
      labs(title = "Distribution of Car Prices by Year", x = "Price (Qatari Riyal)", y = "Count") +
      theme_minimal()
    ggplotly(p)
  })
  
  output$gearTypeBarChart <- renderPlotly({
    gear_data <- car_dataset %>%
      group_by(Gear_Type) %>%
      summarise(Count = n())
    p <- ggplot(gear_data, aes(x = Gear_Type, y = Count, fill = Gear_Type)) +
      geom_bar(stat = "identity") +
      labs(title = "Count of Cars by Gear Type", x = "Gear Type", y = "Count") +
      theme_minimal()
    ggplotly(p)
  })
  
  output$sellerBarChart <- renderPlotly({
    seller_data <- car_dataset %>%
      group_by(Seller) %>%
      summarise(Count = n())
    p <- ggplot(seller_data, aes(x = Seller, y = Count, fill = Seller)) +
      geom_bar(stat = "identity") +
      labs(title = "Number of Cars Sold by Each Seller", x = "Seller", y = "Count") +
      theme_minimal()
    ggplotly(p)
  })
  
  output$cylinderPriceBarChart <- renderPlotly({
    # Filter the dataset for the currency Qatari riyal
    filtered_data <- car_dataset[car_dataset$Currency == "Q.R", ]
    
    cylinder_data <- filtered_data %>%
      group_by(Cylinder) %>%
      summarise(AveragePrice = mean(Price))
    p <- ggplot(cylinder_data, aes(x = Cylinder, y = AveragePrice, fill = Cylinder)) +
      geom_bar(stat = "identity") +
      labs(title = "Cylinder Count vs. Price", x = "Cylinder Count", y = "Average Price (Qatari Riyal)") +
      theme_minimal()
    ggplotly(p)
  })
}

# Run the application
shinyApp(ui = ui, server = server)


      