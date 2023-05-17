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
      bucket_list(
        header = "You are now in your fridge simulator. On the left, you have a selection of various foods. Pick the ones you bought, and drag them to the fridge on the right in order to put them in the fridge.",
        group_name = "bucket_list_group",
        orientation = "horizontal",
        add_rank_list(
          text = "Drag from here",
          labels = c("apple", "banana", "poultry", "image", "Complex html tag without a name", "five"),
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
        tags$p("input$rank_list_1"),
        verbatimTextOutput("results_1"),
        tags$p("input$rank_list_2"),
        verbatimTextOutput("results_2"),
        tags$p("input$bucket_list_group"),
        verbatimTextOutput("results_3")
      )
    )
  )  #End of fluid row which gives results. can be deleted (?) 
)

server <- function(input, output, session) {
  output$results_1 <- renderPrint(input$rank_list_1) # This matches the input_id of the first rank list)
  output$results_2 <- renderPrint(input$rank_list_2) # This matches the input_id of the second rank list
  output$results_3 <- renderPrint(input$bucket_list_group) # Matches the group_name of the bucket list
  
  observeEvent(input$rank_list_2, {
    selected_items <- input$rank_list_2
    item_text <- lapply(selected_items, function(item) {
      switch(
        item,
        "apple" = "You dropped an apple.",
        "banana" = "You dropped a banana.",
        "poultry" = "You dropped poultry.",
        "image" = "You dropped an image.",
        "five" = "You dropped the complex HTML tag with name 'five'.",
        "Complex html tag without a name" = "You dropped the complex HTML tag without a name.",
        "default" = "Unknown item dropped."
      )
    })
    output$results_2 <- renderText(paste(unlist(item_text), collapse = '\n')) # Collapsing the list into a single character string
  })
}

shinyApp(ui, server)
