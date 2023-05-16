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
library(dplyr)
library(stringr)

ingredients <- c("avocado", "bacon", "bread", "butter", "cheese", "egg", "mushroom", "pasta", "potato", "tomato")
load("recipe.rda")

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
             
             ),
    tabPanel("Give Me a Recipe!",
             
             sidebarLayout(
               sidebarPanel(
                 width = 3,
                 
                 checkboxGroupInput("checkgroup", label = h4("Choose your ingredients"), 
                                    choices = ingredients),
                 
                 actionButton("refresh", "Refresh")
                 
               ),
               mainPanel(
                 
                 htmlOutput("content")
                 
               )
             ),
             
             ),
    tabPanel("Usefull Maps")
  ),
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  observe({
    checkgroup <- input$checkgroup
    if (length(checkgroup) > 2) {
      checkgroup <- checkgroup[1:2]
      updateCheckboxGroupInput(
        session = getDefaultReactiveDomain(),
        inputId = "checkgroup",
        selected = tail(input$checkgroup ,2)
      )
    }
  })
  
  output$content <- renderUI({
    checkgroup <- input$checkgroup
    
    filtered_items <- data.frame()
    
    if (length(checkgroup) == 0){
      HTML("No recipes found.")
    } else {
      filtered_items <- recipe %>% 
        group_by(item) %>% 
        filter(str_detect(ingredient, paste(checkgroup, collapse = "|")))
    }
    
    if (nrow(filtered_items) == 0) {
      HTML("No recipes found.")
    } else {
      output_html <- ""
      for (i in 1:nrow(filtered_items)) {
        output_html <- paste(output_html, "<h1>", filtered_items$item[i], "</h1>", "<br>",
                             "<h4>", "Cook_time : ", "</h4>","<br><br>",
                             filtered_items$cook_time[i], "<br><br>",
                             tags$img(src = filtered_items$image[i], width = 200), "<br><br>",
                             "<h4>", "Ingredients : ", "</h4>", "<br><br>",
                             filtered_items$preparation[i], "<br><br>",
                             "<h4>", "Recipe : ", "</h4>", "<br><br>",
                             filtered_items$content[i], "<br><br>"
                             )
      }
      HTML(output_html)
    }
  })
  

  

}

# Run the application 
shinyApp(ui = ui, server = server)
