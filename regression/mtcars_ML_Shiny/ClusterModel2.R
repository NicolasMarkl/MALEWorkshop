
library(shiny)
library(tidyverse)
library(e1071)
library(class)
library(caret)

# Define UI 
ui <- fluidPage(
  
  # Application title
  titlePanel("Cluster Prediction"),
  
  sidebarLayout(
    sidebarPanel(
      h3("Input values for KNN model"),
      
      numericInput("Sepal.Length", "Sepal Length", 5.1),
      numericInput("Sepal.Width", "Sepal Width", 3.5),
      numericInput("Petal.Length", "Petal Length", 1.4),
      numericInput("Petal.Width", "Petal Width", 0.2),
    ),
    
    
    mainPanel(
      
      h3("The predicted Cluster is:"),
      br(),
      textOutput("prediction")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # read in trained ML model
  model = readRDS("./mtcars_knn_model.RDS")
  
  #save user input into a new dataframe
  input_df = reactive({
    data.frame(Sepal.Length = input$Sepal.Length, 
               Sepal.Width = input$Sepal.Width,
               Petal.Length = input$Petal.Length, 
               Petal.Width = input$Petal.Width)
  })
  
  # run prediction function when user updates sliders
  prediction = reactive({
    predict(model, input_df())
  })
  
  # output prediction to the mainPanel
  output$prediction = renderText({
    prediction()
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)