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
library(vembedr)

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Our nice fridge"),
  
  navbarPage(title = img(src = "fridge_logo.png", height = 30), 
             theme = "paper.css",
             id = "main_navbar",
             footer = includeHTML("www/footer.html"),
             header = tags$style(
               ".navbar-right {
                       float: right !important;
                       }",
               "body {padding-top: 75px;}"),
             
                 
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
                            embed_url("https://youtu.be/0Ix8hIqB_8k") %>%
                              use_align("center") %>%
                              use_rounded(radius = 10)
                          ),
                          
                          fluidRow(
                            tags$head(
                              tags$script(src = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"),
                              tags$link(href = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css", rel = "stylesheet")
                            ),
                            column(width = 12,
                                   div(class = "carousel slide", id = "myCarousel",
                                       tags$ol(class = "carousel-indicators",
                                               tags$li(data_target = "#myCarousel", data_slide_to = "0", class = "active"),
                                               tags$li(data_target = "#myCarousel", data_slide_to = "1"),
                                               tags$li(data_target = "#myCarousel", data_slide_to = "2")),
                                       div(class = "carousel-inner",
                                           div(class = "item active", tags$iframe(src = "https://www.youtube.com/embed/0Ix8hIqB_8k", alt = "1")),
                                           div(class = "item", tags$iframe(src = "https://www.youtube.com/embed/2WecH55oT88", alt = "2")),
                                           div(class = "item", tags$iframe(src = "https://www.youtube.com/embed/LhbyjTybuXs", alt = "3"))
                                       ),
                                       a(href = "#myCarousel", class = "left carousel-control", data_slide = "prev",
                                         span(class = "glyphicon glyphicon-chevron-left")),
                                       a(href = "#myCarousel", class = "right carousel-control", data_slide = "next",
                                         span(class = "glyphicon glyphicon-chevron-right"))
                                   )
                            )
                          ),
                          
                          fluidRow(
                            tags$iframe(
                              style="border-radius:12px", 
                              src="https://open.spotify.com/embed/artist/3RwQ26hR2tJtA8F9p2n7jG?utm_source=generator", 
                              width="100%", 
                              height="380", 
                              frameBorder="0", 
                              allowfullscreen="", 
                              allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture", 
                              loading="lazy")
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
                 
 ),
)

server <- function(input, output){
  output$img1 = renderImage({
    list(src = "refrigerator.png")
  }, deleteFile = FALSE)
  
}

shinyApp(ui = ui, server = server)

