#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyglide)

#UI
ui <- fluidPage(
  
  # Application title
  titlePanel("Our nice fridge"),
  
  #navigation bar
  navbarPage(
    title = img(src = "fridge_logo.png", height = 30),
    id = "main_navbar",
    theme = "style.css",
    
    
    tabPanel("Myfridge",
             
             sidebarLayout(
               sidebarPanel(
                 width = 3,
                 
                 uiOutput("selected_stops_UI"),
                 actionButton("refresh", "Refresh")
                 
               ),
               mainPanel(DT::dataTableOutput("bus_table"))
             ),

             ),
    tabPanel("Give Me a Recipe!",
             
             glide(
               id = "plot-glide",
               height = "450px",
               controls_position = "top",
               
               
               
               screen(
                 p("Please choose the ingredients up to 2."),
                 numericInput("n", "n :", value = 100)
               ),
               screen(
                 p("Here is your amazing recipe!"),
                 plotOutput("plot")
               )
             )
             
             
             ),
    tabPanel("Usefull Maps")
  ),
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$plot <- renderPlot({
    hist(rnorm(input$n), main = paste("n =", input$n))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
