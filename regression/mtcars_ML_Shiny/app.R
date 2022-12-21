
library(shiny)

# Define UI 
ui <- fluidPage(

    # Application title
    titlePanel("Miles per Gallon prediction"),

    # Sidebar with a slider for user input 
    sidebarLayout(
        sidebarPanel(
           h3("Input values for Linear Regression model"),
           
           sliderInput("disp",
                       "Select the disp:",
                       min = 71.1,
                       max = 472,
                       value = 100),
           
           sliderInput("hp",
                       "Select the hp:",
                       min = 52,
                       max = 335,
                       value = 100),
           
           sliderInput("wt",
                       "Select the wt:",
                       min = 1.513,
                       max = 5.424,
                       value = 3),
        ),

        
        mainPanel(
           
          h3("The predicted MPG is:"),
          br(),
          textOutput("prediction")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  # read in trained ML model
  model = readRDS("../mtcars_linear_model.RDS")
  
  #save user input into a new dataframe
  input_df = reactive({
    data.frame(disp = input$disp,
               hp = input$hp,
               wt = input$wt)
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
