library(shiny)
library(sortable)
library(DiagrammeR)
library(htmltools)

ui <- fluidPage(
  
  tags$head(
    tags$style(HTML(".bucket-list-container {min-height: 350px;}"))
  ),
  fluidRow(
    column(
      tags$b("MyFridge"),
      width = 12,
      # style = "background-image: url(https://images.unsplash.com/photo-1583542225715-473a32c9b0ef?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80); background-size: cover;",
      bucket_list(
        header = "You are now in your fridge simulator. On the left, you have a selection of various foods. Pick the ones you bought, and drag them to the fridge on the right in order to put them in the fridge.",
        group_name = "bucket_list_group",
        orientation = "horizontal",
        add_rank_list(
          text = "Drag from here",
          labels = list(
            "apple" = tags$img(src = "pomme.jpg", width = 50, height= 50),
            "banana" = tags$img(src = "banana.jpg", width = 50, height= 50),
            "poultry" = tags$img(src = "chicken.jpg", width = 50, height= 50),
            "pineapple" = tags$img(src = "ananas.jpg", width = 50, height= 50),
            "raspberry" = tags$img(src = "framboise.jpg", width = 50, height= 50)
          ),
          input_id = "rank_list_1"
        ),
        add_rank_list(
          text = "to here",
          labels = NULL,
          input_id = "rank_list_2"
        )
      ),
      tags$style(
        HTML("
          .rank-list-container.custom-sortable {
            background-color: #b4b4b4;
          }
          .custom-sortable .rank-list-item {
            background-color: #BDB;
          }
        ")
      ),
    )
  ),
  fluidRow(
    column(
      width = 12,
      tags$b("Result"),
      column(
        width = 12,
        tags$p("input$rank_list_2"),
        verbatimTextOutput("results_2"),
        tags$p("input$bucket_list_group"),
        verbatimTextOutput("results_3")
      )
    )
  )  #End of fluid row which gives results. can be deleted (?) 
)

server <- function(input, output, session) {
  #output$results_1 <- renderPrint(input$rank_list_1) # This matches the input_id of the first rank list)
  output$results_2 <- renderPrint(input$rank_list_2) # This matches the input_id of the second rank list
  #output$results_3 <- renderPrint(input$bucket_list_group) # Matches the group_name of the bucket list
  
  observeEvent(input$rank_list_2, {
    selected_items <- input$rank_list_2
    item_text <- lapply(selected_items, function(item) {
      switch(
        item,
        "apple" = "Apples usually keep in the fridge 4 to 6 weeks. Once cut, they last for up to 5 days.",
        "banana" = "You dropped a banana.",
        "poultry" = "You dropped poultry.",
        "image" = "You dropped an image.",
        "default" = "Unknown item dropped."
      )
    })
    output$results_2 <- renderText(paste(unlist(item_text), collapse = '\n')) # Collapsing the list into a single character string
  })
}

shinyApp(ui, server)
