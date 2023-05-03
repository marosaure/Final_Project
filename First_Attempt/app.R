
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Our nice fridge"),
    
    #navigation bar
    navbarPage(
      "Welcome to fridge!",
      id = "main_navbar",
      
      #Tabs
      tabPanel("MyFridge"),
      tabPanel("Give Me a Recipe!"),
      tabPanel("Usefull Maps")
      
      #Fin
      ),
    

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        
        mainPanel(
           plotOutput("distPlot"),
           
           helpText("Note: while the data view will show only",
                    "the specified number of observations, the",
                    "summary will be based on the full dataset."),
        
        #HTML TEXT? 
        fluidRow(
          style = "height:50px;",
          column(3),
          column(6,
                 shiny::HTML("<br><br><center> <h1>What you'll find here</h1> </center><br>"),
                 shiny::HTML("<h5>An interactive tool to help you explore the actual paths employees 
                                                   have taken during their County careers. With information about the 
                                                   popularity of certain paths, salary differences, and more, you can 
                                                   build your own path based on what is meaningful to you.</h5>")
          ),
          column(3)
        ),
        fluidRow(style = "height:25px;"
        )
        
        
        )
    )
)



# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
