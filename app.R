#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



library(shiny)
library(ggplot2)
library(tidyverse)
#library(rsconnect)
#rsconnect::setAccountInfo(name='wi20b037', token='4DFB03C6A510B0BDF59222FC835B6D87', secret='mJmUptE8nCI3HjU9Un/2hiiKNwkg4CDeUXeMisGm')


# Load the iris dataset as an example
data(iris)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
        # Show a plot of the generated distribution
        mainPanel(
          numericInput("mpg", "MPG", 20),
          numericInput("cyl", "Cylinders", 4),
          numericInput("disp", "Displacement", 100),
          numericInput("hp", "Horsepower", 80),
          numericInput("drat", "Rear axle ratio", 3.5),
          numericInput("wt", "Weight", 2.0),
          numericInput("qsec", "1/4 mile time", 16.5),
          
          # Button to submit the input values
          actionButton("predict", "Predict"),
          
          # Output displaying the cluster prediction
          textOutput("prediction")
        )
    )

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Load the mtcars data and normalize it
  data <- mtcars %>% 
    select(mpg, cyl, disp, hp, drat, wt, qsec) %>%
    scale()
  
  # Run the k-Means model
  kmeans_model <- reactive({
    kmeans(data, centers = 3)
  })
  
  # Define a reactive value for the cluster prediction
  prediction <- reactiveValues(pred = NULL)
  
  # Make the cluster prediction when the button is clicked
  observeEvent(input$predict, {
    # Define the new data
    new_data <- data.frame(mpg = input$mpg, cyl = input$cyl, disp = input$disp, hp = input$hp, drat = input$drat, wt = input$wt, qsec = input$qsec)
    
    # Normalize the new data
    new_data_scaled <- scale(new_data)
    
    # Make the cluster prediction
    prediction$pred <- predict(kmeans_model(), new_data_scaled)
  })
  
  # Output the cluster prediction
  output$prediction <- renderText({
    if (!is.null(prediction$pred)) {
      paste("Prediction: Cluster", prediction$pred)
    } else {
      "No prediction yet."
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

# Deploy the application
#rsconnect::deployApp()
