#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(stringr)
library(png)
library(htmltools)

# Define UI for application that draws a histogram
ui <- navbarPage(title = "Welcome to fridge!", 
                 id = "main_navbar",
                 footer = includeHTML("www/footer.html"),
                 
                 tabPanel("Home", value = "home",
                          fluidRow(
                            img(src = "refrigerator.png", height = 70)
                          ),
                          
                          tags$hr(),
                          
                          fluidRow(
                            column(3),
                            column(12,
                                   shiny::HTML("<br><br><center> <h1>Where it came from</h1> </center><br>"),
                                   shiny::HTML("<h5>Our team analyzed over 500 thousand County employee records 
                                                   from the past 30 years and transformed them into the information 
                                                   you will see in the Career PathFinder.</h5>")
                            ),
                            column(3)
                          ),
                          
                          fluidRow(
                            tags$embed(src = "https://youtu.be/0Ix8hIqB_8k", width = "640", height = "360")
                          ),
                          
                          tags$hr(),
                          ),
                
                 tabPanel("MyFridge", value = "myfridge",
                          fluidRow(
                            column(3),
                            column(12,
                                   shiny::HTML("<br><br><center> <h1>What you'll find here</h1> </center><br>"),
                                   shiny::HTML("<h5>An interactive tool to help you explore the actual paths employees 
                                                   have taken during their County careers. With information about the 
                                                   popularity of certain paths, salary differences, and more, you can 
                                                   build your own path based on what is meaningful to you.</h5>")
                            ),
                            column(3)
                            ),
                            ),
                 
                 tabPanel("Give Me a Recipe!", value = "recipe",
                          fluidRow(
                            column(3),
                            column(12,
                                   shiny::HTML("<br><br><center> <h1>What you'll find here</h1> </center><br>"),
                                   shiny::HTML("<h5>An interactive tool to help you explore the actual paths employees 
                                                   have taken during their County careers. With information about the 
                                                   popularity of certain paths, salary differences, and more, you can 
                                                   build your own path based on what is meaningful to you.</h5>")
                            ),
                            column(3)
                          ),
                          ),
                 
                 tabPanel("Usefull Maps", value = "map",
                          fluidRow(
                            column(3),
                            column(12,
                                   shiny::HTML("<br><br><center> <h1>Wt you'll find here</h1> </center><br>"),
                                   shiny::HTML("<h5>An interactive tool to help you explore the actual paths employees 
                                                   have taken during their County careers. With information about the 
                                                   popularity of certain paths, salary differences, and more, you can 
                                                   build your own path based on what is meaningful to you.</h5>")
                            ),
                            column(3)
                          ),
                          ),
                 
)

server <- function(input, output){
  output$img1 = renderImage({
    list(src = "refrigerator.png")
  }, deleteFile = FALSE)
  
}

shinyApp(ui = ui, server = server)

