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
            "pineapple" = tags$img(src = "ananas.jpg", width = 50, height= 50),
            "raspberry" = tags$img(src = "framboise.jpg", width = 50, height= 50),
            "pear"= tags$img(src = "pear.jpg", width = 50, height= 50),
            "oorange"= tags$img(src = "orange.jpg", width = 50, height= 50),
            "strawberry"= tags$img(src = "strawberry.jpg", width = 50, height= 50),
            "lemon"= tags$img(src = "lemon.jpg", width = 50, height= 50),
            "mango"= tags$img(src = "mangue.jpg", width = 50, height= 50),
            "poultry" = tags$img(src = "chicken.jpg", width = 50, height= 50),
            "butter" = tags$img(src = "butter-gc94092df4_640.jpg", width = 50, height= 50),
            "cheese0" = tags$img(src = "fromage.jpg", width = 50, height= 50),
            "cheese1" = tags$img(src = "mozzarella-g0cb07633a_640.jpg", width = 50, height= 50),
            "milk" = tags$img(src = "milk.jpg", width = 50, height= 50),
            "yaourt" = tags$img(src = "yogut.jpg", width = 50, height= 50)
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
        "banana" = "Bananas are best stored at room temperature and can last for up to a week. They have about 96 calories per 100g and are high in potassium and vitamin B6.",
        "pineapple" = "A whole pineapple stored in the fridge can last up to 1 week, cut pieces can last for 3 to 4 days. It has about 50 calories per 100g and is rich in vitamin C and manganese.",
        "raspberry" = "Raspberries can be refrigerated for 2 to 3 days. They have about 52 calories per 100g and are high in dietary fiber and vitamin C.",
        "pear" = "Pears can be kept in the fridge for up to 2 weeks. They have about 57 calories per 100g and are a good source of dietary fiber.",
        "oorange" = "Oranges can be stored in the fridge for up to 2 weeks. They have about 43 calories per 100g and are very high in vitamin C.",
        "strawberry" = "Strawberries can be refrigerated for 5 to 7 days. They have about 32 calories per 100g and are high in vitamin C.",
        "lemon" = "Lemons can last in the fridge for up to 4 weeks. They have about 29 calories per 100g and are very high in vitamin C.",
        "mango" = "A ripe mango can last in the fridge for up to 5 days. It has about 60 calories per 100g and is high in vitamin C and vitamin A.",
        "poultry" = "Raw poultry can be stored in the fridge for 1-2 days. It's high in protein and contains varying amounts of fat and cholesterol depending on the cut.",
        "butter" = "Butter can be stored in the fridge for up to 1 month. It's high in fat and calories, with about 717 calories per 100g.",
        "cheese0" = "Different cheeses have different shelf lives, but most will last 1-4 weeks in the fridge. They are high in calcium and protein, with caloric content varying widely.",
        "cheese1" = "Mozzarella can be stored in the fridge for up to 1 week. It has about 280 calories per 100g and is a good source of protein and calcium.",
        "milk" = "Milk should be consumed within 1 week of opening, but can last up to 2 weeks. It has about 42 calories per 100g and is a good source of calcium and vitamin D.",
        "yaourt" = "Yogurt can be stored in the fridge for up to 2 weeks. It has about 59 calories per 100g and is high in protein and calcium.",
        "image" = "You dropped an image.",
        
        "default" = "Unknown item dropped."
      )
    })
    output$results_2 <- renderText(paste(unlist(item_text), collapse = '\n')) # Collapsing the list into a single character string
  })
}





shinyApp(ui, server)
