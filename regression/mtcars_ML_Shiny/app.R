
library(shiny)

# Define UI 
ui <- fluidPage(

    # Application title
    titlePanel("Miles per Gallon prediction"),

    # Sidebar with a slider input 
    sidebarLayout(
        sidebarPanel(
           h3("Input values"),
           
           sliderInput("disp",
                       "Select the disp:",
                       min = 1,
                       max = 10,
                       value = 5),
           
           sliderInput("hp",
                       "Select the hp:",
                       min = 1,
                       max = 10,
                       value = 5),
           
           sliderInput("wt",
                       "Select the wt:",
                       min = 1,
                       max = 10,
                       value = 5),
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

  model = readRDS("../mtcars_linear_model.RDS")
  
  input_df = reactive({
    data.frame(disp = input$disp,
               hp = input$hp,
               wt = input$wt)
  })
  
  prediction = reactive({
    predict(model, input_df())
  })
  
  output$prediction = renderText({
    prediction()
  })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
