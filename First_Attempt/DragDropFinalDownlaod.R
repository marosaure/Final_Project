library(shiny)
library(sortable)
library(DiagrammeR)
library(htmltools)

ui <- fluidPage(
  
  tags$head(
    tags$style(HTML(".bucket-list-container {min-height: 450px;}
                    h2 {font-size: 30px;}
                    #results_2 {
                      background-color: #FFFF99;
                      color: #333;
                      font-size: 16px;
                      padding: 20px;
                      border-radius: 10px;
                      font-family: Arial, sans-serif;
                    }"))
  ),
  fluidRow(
    column(
      tags$h2("MyFridge"),
      width = 12,
      bucket_list(
        header = "You are now in your fridge simulator. On the left, you have a selection of various foods. Pick the ones you bought, and drag them to the fridge on the right in order to put them in the fridge.",
        group_name = "bucket_list_group",
        orientation = "horizontal",
        add_rank_list(
          text = "Drag from here",
          labels = list(
            "apple" = tags$div(tags$img(src = "pomme.jpg", width = 50, height= 50), "Apple"),
            "banana" = tags$div(tags$img(src = "banana.jpg", width = 50, height= 50), "Banana"),
            "pineapple" = tags$div(tags$img(src = "ananas.jpg", width = 50, height= 50), "Pineapple"),
            "raspberry" = tags$div(tags$img(src = "framboise.jpg", width = 50, height= 50), "Raspeberries"),
            "pear"= tags$div(tags$img(src = "pear.jpg", width = 50, height= 50), "Pears"),
            "oorange"= tags$div(tags$img(src = "orange.jpg", width = 50, height= 50), "Oranges and citrus fruits"),
            "strawberry"= tags$div(tags$img(src = "strawberry.jpg", width = 50, height= 50), "Strawberries"),
            "lemon"= tags$div(tags$img(src = "lemon.jpg", width = 50, height= 50), "Lemons"),
            "mango"= tags$div(tags$img(src = "mangue.jpg", width = 50, height= 50), "Mango"),
            "poultry" = tags$div(tags$img(src = "chicken.jpg", width = 50, height= 50), "Poultry"),
            "butter" = tags$div(tags$img(src = "butter-gc94092df4_640.jpg", width = 50, height= 50), "Butter"),
            "cheese0" = tags$div(tags$img(src = "fromage.jpg", width = 50, height= 50), "Hard Cheeses"),
            "cheese1" = tags$div(tags$img(src = "mozzarella-g0cb07633a_640.jpg", width = 50, height= 50), "Soft Cheeses"),
            "milk" = tags$div(tags$img(src = "milk.jpg", width = 50, height= 50), "Milk"),
            "yaourt" = tags$div(tags$img(src = "yogut.jpg", width = 50, height= 50), "Yogurt"),
            "salad" = tags$div(tags$img(src = "salad.jpg", width = 50, height= 50), "Salad and Leafy Greens"),
            "cucumber" = tags$div(tags$img(src = "cucumber.jpg", width = 50, height= 50), "Cucumber"),
            "carot" = tags$div(tags$img(src = "carotte.jpg", width = 50, height= 50), "Carrot"),
            "tomahtoh" = tags$div(tags$img(src = "tomato.jpg", width = 50, height= 50), "Tomato"),
            "asparagus" = tags$div(tags$img(src = "asparagus.jpg", width = 50, height= 50), "Asparagus"),
            "radish" = tags$div(tags$img(src = "radish.jpg", width = 50, height= 50), "Radish"),
            "onion" = tags$div(tags$img(src = "onion.jpg", width = 50, height= 50), "Onions"),
            "garlic" = tags$div(tags$img(src = "garlic.jpg", width = 50, height= 50), "Garlic"),
            "peppers" = tags$div(tags$img(src = "poivron.jpg", width = 50, height= 50), "Peppers")
          ),
          input_id = "rank_list_1"
        ),
        add_rank_list(
          text = "To here",
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
      downloadButton("downloadData", "Download")
    )
  ),
  fluidRow(
    column(
      width = 12,
      tags$b("Result"),
      column(
        width = 12,
        verbatimTextOutput("results_2")
      )
    )
  )  #End of fluid row which gives results. can be deleted (?) 
)

server <- function(input, output, session) {
  output$results_2 <- renderPrint(input$rank_list_2) # This matches the input_id of the second rank list
  
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
        "salad" = "Salad greens can last in the fridge for up to a week. They contain about 5 calories per 100g and are a good source of dietary fiber.",
        "cucumber" = "Cucumbers can be stored in the fridge for up to a week. They contain about 15 calories per 100g and are high in vitamin K.",
        "carot" = "Carrots can be kept in the fridge for up to 2-3 weeks. They contain about 41 calories per 100g and are high in vitamin A.",
        "tomahtoh" = "Tomatoes are best stored at room temperature and can last for up to a week. They contain about 18 calories per 100g and are high in vitamin C.",
        "asparagus" = "Asparagus can be refrigerated for up to 5 days. They contain about 20 calories per 100g and are a good source of dietary fiber and vitamin K.",
        "radish" = "Radishes can be stored in the fridge for up to 2 weeks. They contain about 16 calories per 100g and are high in vitamin C.",
        "onion" = "Onions can be stored in a cool, dry place for up to 2 months. They contain about 40 calories per 100g and are a good source of dietary fiber.",
        "garlic" = "Garlic can be stored in a cool, dry place for up to 2 months. It contains about 149 calories per 100g and is a good source of vitamin C and vitamin B6.",
        "peppers" = "Peppers can be stored in the fridge for up to 1 week. They contain about 20 calories per 100g and are high in vitamin C.",
        
        "default" = "Unknown item dropped."
      )
    })
    output$results_2 <- renderText(paste(unlist(item_text), collapse = '\n')) # Collapsing the list into a single character string
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("fridge_contents", ".txt", sep = "")
    },
    content = function(file) {
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
          "salad" = "Salad greens can last in the fridge for up to a week. They contain about 5 calories per 100g and are a good source of dietary fiber.",
          "cucumber" = "Cucumbers can be stored in the fridge for up to a week. They contain about 15 calories per 100g and are high in vitamin K.",
          "carot" = "Carrots can be kept in the fridge for up to 2-3 weeks. They contain about 41 calories per 100g and are high in vitamin A.",
          "tomahtoh" = "Tomatoes are best stored at room temperature and can last for up to a week. They contain about 18 calories per 100g and are high in vitamin C.",
          "asparagus" = "Asparagus can be refrigerated for up to 5 days. They contain about 20 calories per 100g and are a good source of dietary fiber and vitamin K.",
          "radish" = "Radishes can be stored in the fridge for up to 2 weeks. They contain about 16 calories per 100g and are high in vitamin C.",
          "onion" = "Onions can be stored in a cool, dry place for up to 2 months. They contain about 40 calories per 100g and are a good source of dietary fiber.",
          "garlic" = "Garlic can be stored in a cool, dry place for up to 2 months. It contains about 149 calories per 100g and is a good source of vitamin C and vitamin B6.",
          "peppers" = "Peppers can be stored in the fridge for up to 1 week. They contain about 20 calories per 100g and are high in vitamin C.",
          
          "default" = "Unknown item dropped."
        )
      })
      writeLines(unlist(item_text), file)
    }
  )
}


shinyApp(ui, server)
