library(shiny)
library(sortable)
library(DiagrammeR)
library(htmltools)

ingredient_list <- list(
  "apple" = tags$div(tags$img(src = "pomme.jpg", width = 50, height= 50), "Apple"),
  "banana" = tags$div(tags$img(src = "banana.jpg", width = 50, height= 50), "Banana"),
  "pineapple" = tags$div(tags$img(src = "ananas.jpg", width = 50, height= 50), "Pineapple"),
  "raspberry" = tags$div(tags$img(src = "framboise.jpg", width = 50, height= 50), "Raspeberries"),
  "pear"= tags$div(tags$img(src = "pear.jpg", width = 50, height= 50), "Pears"),
  "oorange"= tags$div(tags$img(src = "orange.jpg", width = 50, height= 50), "Oranges and citrus fruits"),
  "strawberry"= tags$div(tags$img(src = "strawberry.jpg", width = 50, height= 50), "Strawberries"),
  "lemon"= tags$div(tags$img(src = "lemon.jpg", width = 50, height= 50), "Lemons"),
  "mango"= tags$div(tags$img(src = "mangue.jpg", width = 50, height= 50), "Mango"),
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
  "peppers" = tags$div(tags$img(src = "poivron.jpg", width = 50, height= 50), "Peppers"),
  "seafood" = tags$div(tags$img(src = "fruits_de_mer.jpg", width = 50, height= 50), "Seafood"),
  "tuna" = tags$div(tags$img(src = "thon.jpg", width = 50, height= 50), "Tuna"),
  "salmonn" = tags$div(tags$img(src = "saumon.jpg", width = 50, height= 50), "Salmon"),
  "pork" = tags$div(tags$img(src = "porc.jpg", width = 50, height= 50), "Pork"),
  "lamb" = tags$div(tags$img(src = "agneau .jpg", width = 50, height= 50), "Lamb"),
  "chicken" = tags$div(tags$img(src = "chicken.jpg", width = 50, height= 50), "Chicken")
)


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
                      border: 10px;
                      font-family: Arial, sans-serif;}
                      
                    #fridgeItems {
                      background-color: #FFFF99;
                      color: #333;
                      font-size: 16px;
                      padding: 20px;
                      border-radius: 10px;
                      border: 10px;
                      font-family: Arial, sans-serif;}"))
  ),
  fluidRow(
    column(
      tags$h2("MyFridge"),
      width = 12,
      bucket_list(
        header = "You are now in your fridge simulator. On the left, you have a selection of various foods. Pick the ones you bought, and drag them to the fridge on the right in order to put them in the fridge. Below, you'll find a button that allows you to download the contents of your virtual firdge, in order for you to keep track of what you have. ",
        group_name = "bucket_list_group",
        orientation = "horizontal",
        add_rank_list(
          text = "Drag from here",
          labels = ingredient_list,
          input_id = "rank_list_1"
        ),
        add_rank_list(
          text = "To here",
          labels = NULL,
          input_id = "rank_list_2"
        )
      ),
      tags$br(),
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
  tags$br(),

  
  fluidRow(
    column(
      width = 12,
      tags$p("The file you can download is a csv file. It allows you to further edit it, by for example adding colors or exact quantities, or the exact best-before date.")
    )
  ),
  tags$br(),

  
  fluidRow(
    column(
      width = 12,
      tags$h3("Result"),
      column(
        width = 12,
        verbatimTextOutput("results_2")
      ),
    )
  ),
  tags$br(),
  tags$br(),
  
  fluidRow(
    column(
      width = 12,
      tags$h3("My refrigerator contains:"),
      column(12, tags$div(class = "fridge-container", uiOutput("fridgeItems")))
    )
  ),
  fluidRow(
    column(
      width = 12,
      uiOutput("downloadSummary")
    )
  )
  
)

server <- function(input, output, session) {
  output$results_2 <- renderPrint(input$rank_list_2) # This matches the input_id of the second rank list
  
  observeEvent(input$rank_list_2, {
    selected_items <- input$rank_list_2
    item_text <- lapply(selected_items, function(item) {
      switch(
        item,
        "apple" = "Apples usually keep in the fridge 4 to 6 weeks. Once cut, they last for up to 5 days.",
        "banana" = "Bananas are best stored at room temperature and can last for up to a week. They have about 96 calories per 100g. Carbs: 22 per 100g. Protein: 1.1 per 100g. Fiber: 2.6 per 100g.",
        "pineapple" = "A whole pineapple stored in the fridge can last up to 1 week, cut pieces can last for 3 to 4 days. It has about 50 calories per 100g. Carbs: 13.1 per 100g. Protein: 0.5 per 100g. Fiber: 1.4 per 100g.",
        "raspberry" = "Raspberries can be refrigerated for 2 to 3 days. They have about 52 calories per 100g. Carbs: 11.9 per 100g. Protein: 1.2 per 100g. Fiber: 6.5 per 100g.",
        "pear" = "Pears can be kept in the fridge for up to 2 weeks. They have about 57 calories per 100g. Carbs: 15.2 per 100g. Protein: 0.4 per 100g. Fiber: 3.1 per 100g.",
        "oorange" = "Oranges can be stored in the fridge for up to 2 weeks. They have about 43 calories per 100g. Carbs: 8.3 per 100g. Protein: 0.9 per 100g. Fiber: 2.4 per 100g.",
        "strawberry" = "Strawberries can be refrigerated for 5 to 7 days. They have about 32 calories per 100g. Carbs: 7.7 per 100g. Protein: 0.7 per 100g. Fiber: 2.0 per 100g.",
        "lemon" = "Lemons can last in the fridge for up to 4 weeks. They have about 29 calories per 100g. Carbs: 9.3 per 100g. Protein: 1.1 per 100g. Fiber: 2.8 per 100g.",
        "mango" = "A ripe mango can last in the fridge for up to 5 days. It has about 60 calories per 100g. Carbs: 14.98 per 100g. Protein: 0.82 per 100g. Fiber: 1.6 per 100g.",
        "poultry" = "Raw poultry can be stored in the fridge for 1-2 days. It's high in protein and contains varying amounts of fat and cholesterol depending on the cut.",
        "butter" = "Butter can be stored in the fridge for up to 1 month. It's high in fat and calories, with about 717 calories per 100g. Carbs: 0.06 per 100g. Protein: 0.85 per 100g. Fiber: 0 per 100g.",
        "cheese0" = "Different cheeses have different shelf lives, but most will last 1-4 weeks in the fridge. They are high in calcium and protein, with caloric content varying widely.",
        "cheese1" = "Mozzarella can be stored in the fridge for up to 1 week. It has about 280 calories per 100g. Carbs: 2.2 per 100g. Protein: 28.97 per 100g. Fiber: 0 per 100g.",
        "milk" = "Milk should be consumed within 1 week of opening, but can last up to 2 weeks. It has about 42 calories per 100g. Carbs: 4.7 per 100g. Protein: 3.3 per 100g. Fiber: 0 per 100g.",
        "yaourt" = "Yogurt can be stored in the fridge for up to 2 weeks. It has about 59 calories per 100g. Carbs: 3.6 per 100g. Protein: 10.1 per 100g. Fiber: 0 per 100g.",
        "salad" = "Salad greens can last in the fridge for up to a week. They contain about 5 calories per 100g. Carbs: 1 per 100g. Protein: 0.6 per 100g. Fiber: 1.1 per 100g.",
        "cucumber" = "Cucumbers can be stored in the fridge for up to a week. They contain about 15 calories per 100g. Carbs: 3.63 per 100g. Protein: 0.65 per 100g. Fiber: 0.5 per 100g.",
        "carot" = "Carrots can be kept in the fridge for up to 2-3 weeks. They contain about 41 calories per 100g. Carbs: 9.58 per 100g. Protein: 0.93 per 100g. Fiber: 2.8 per 100g.",
        "tomahtoh" = "Tomatoes are best stored at room temperature and can last for up to a week. They contain about 18 calories per 100g. Carbs: 3.9 per 100g. Protein: 0.9 per 100g. Fiber: 1.2 per 100g.",
        "asparagus" = "Asparagus can be refrigerated for up to 5 days. They contain about 20 calories per 100g. Carbs: 3.38 per 100g. Protein: 2.2 per 100g. Fiber: 2.1 per 100g.",
        "radish" = "Radishes can be stored in the fridge for up to 2 weeks. They contain about 16 calories per 100g. Carbs: 3.4 per 100g. Protein: 0.7 per 100g. Fiber: 1.6 per 100g.",
        "onion" = "Onions can be stored in a cool, dry place for up to 2 months. They contain about 40 calories per 100g. Carbs: 9.34 per 100g. Protein: 1.1 per 100g. Fiber: 1.7 per 100g.",
        "garlic" = "Garlic can be stored in a cool, dry place for up to 2 months. It contains about 149 calories per 100g. Carbs: 33.06 per 100g. Protein: 6.36 per 100g. Fiber: 2.1 per 100g.",
        "peppers" = "Peppers can be stored in the fridge for up to 1 week. They contain about 20 calories per 100g. Carbs: 4.64 per 100g. Protein: 0.86 per 100g. Fiber: 1.7 per 100g.",
        "tuna" = "Tuna can be stored in the fridge for up to 2 days. It has about 144 calories per 100g. Carbs: 0 per 100g. Protein: 29.91 per 100g. Fiber: 0 per 100g.",
        "seafood" = "Seafood can be stored in the fridge for up to 2 days. It is a good source of protein and omega-3 fatty acids.",
        "salmonn" = "Salmon can be stored in the fridge for up to 2 days. It has about 206 calories per 100g. Carbs: 0 per 100g. Protein: 22.02 per 100g. Fiber: 0 per 100g.",
        "pork" = "Pork can be stored in the fridge for up to 3 days. It has about 143 calories per 100g. Carbs: 0 per 100g. Protein: 20.97 per 100g. Fiber: 0 per 100g.",
        "lamb" = "Lamb can be stored in the fridge for up to 3 days. It has about 250 calories per 100g. Carbs: 0 per 100g. Protein: 25.66 per 100g. Fiber: 0 per 100g.",
        "chicken" = "Chicken can be stored in the fridge for up to 2 days. It has about 165 calories per 100g. Carbs: 0 per 100g. Protein: 31.02 per 100g. Fiber: 0 per 100g."
      
      )
    })
    output$results_2 <- renderText(paste(unlist(item_text), collapse = '\n')) # Collapsing the list into a single character string
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("What is in my Fridge:", ".csv", sep = "")
    },
    content = function(file) {
      selected_items <- input$rank_list_2
      item_text <- lapply(selected_items, function(item) {
        switch(
          item,
          "apple" = "Apples usually keep in the fridge 4 to 6 weeks. Once cut, they last for up to 5 days.",
          "banana" = "Bananas are best stored at room temperature and can last for up to a week. They have about 96 calories per 100g. Carbs: 22 per 100g. Protein: 1.1 per 100g. Fiber: 2.6 per 100g.",
          "pineapple" = "A whole pineapple stored in the fridge can last up to 1 week, cut pieces can last for 3 to 4 days. It has about 50 calories per 100g. Carbs: 13.1 per 100g. Protein: 0.5 per 100g. Fiber: 1.4 per 100g.",
          "raspberry" = "Raspberries can be refrigerated for 2 to 3 days. They have about 52 calories per 100g. Carbs: 11.9 per 100g. Protein: 1.2 per 100g. Fiber: 6.5 per 100g.",
          "pear" = "Pears can be kept in the fridge for up to 2 weeks. They have about 57 calories per 100g. Carbs: 15.2 per 100g. Protein: 0.4 per 100g. Fiber: 3.1 per 100g.",
          "oorange" = "Oranges can be stored in the fridge for up to 2 weeks. They have about 43 calories per 100g. Carbs: 8.3 per 100g. Protein: 0.9 per 100g. Fiber: 2.4 per 100g.",
          "strawberry" = "Strawberries can be refrigerated for 5 to 7 days. They have about 32 calories per 100g. Carbs: 7.7 per 100g. Protein: 0.7 per 100g. Fiber: 2.0 per 100g.",
          "lemon" = "Lemons can last in the fridge for up to 4 weeks. They have about 29 calories per 100g. Carbs: 9.3 per 100g. Protein: 1.1 per 100g. Fiber: 2.8 per 100g.",
          "mango" = "A ripe mango can last in the fridge for up to 5 days. It has about 60 calories per 100g. Carbs: 14.98 per 100g. Protein: 0.82 per 100g. Fiber: 1.6 per 100g.",
          "poultry" = "Raw poultry can be stored in the fridge for 1-2 days. It's high in protein and contains varying amounts of fat and cholesterol depending on the cut.",
          "butter" = "Butter can be stored in the fridge for up to 1 month. It's high in fat and calories, with about 717 calories per 100g. Carbs: 0.06 per 100g. Protein: 0.85 per 100g. Fiber: 0 per 100g.",
          "cheese0" = "Different cheeses have different shelf lives, but most will last 1-4 weeks in the fridge. They are high in calcium and protein, with caloric content varying widely.",
          "cheese1" = "Mozzarella can be stored in the fridge for up to 1 week. It has about 280 calories per 100g. Carbs: 2.2 per 100g. Protein: 28.97 per 100g. Fiber: 0 per 100g.",
          "milk" = "Milk should be consumed within 1 week of opening, but can last up to 2 weeks. It has about 42 calories per 100g. Carbs: 4.7 per 100g. Protein: 3.3 per 100g. Fiber: 0 per 100g.",
          "yaourt" = "Yogurt can be stored in the fridge for up to 2 weeks. It has about 59 calories per 100g. Carbs: 3.6 per 100g. Protein: 10.1 per 100g. Fiber: 0 per 100g.",
          "salad" = "Salad greens can last in the fridge for up to a week. They contain about 5 calories per 100g. Carbs: 1 per 100g. Protein: 0.6 per 100g. Fiber: 1.1 per 100g.",
          "cucumber" = "Cucumbers can be stored in the fridge for up to a week. They contain about 15 calories per 100g. Carbs: 3.63 per 100g. Protein: 0.65 per 100g. Fiber: 0.5 per 100g.",
          "carot" = "Carrots can be kept in the fridge for up to 2-3 weeks. They contain about 41 calories per 100g. Carbs: 9.58 per 100g. Protein: 0.93 per 100g. Fiber: 2.8 per 100g.",
          "tomahtoh" = "Tomatoes are best stored at room temperature and can last for up to a week. They contain about 18 calories per 100g. Carbs: 3.9 per 100g. Protein: 0.9 per 100g. Fiber: 1.2 per 100g.",
          "asparagus" = "Asparagus can be refrigerated for up to 5 days. They contain about 20 calories per 100g. Carbs: 3.38 per 100g. Protein: 2.2 per 100g. Fiber: 2.1 per 100g.",
          "radish" = "Radishes can be stored in the fridge for up to 2 weeks. They contain about 16 calories per 100g. Carbs: 3.4 per 100g. Protein: 0.7 per 100g. Fiber: 1.6 per 100g.",
          "onion" = "Onions can be stored in a cool, dry place for up to 2 months. They contain about 40 calories per 100g. Carbs: 9.34 per 100g. Protein: 1.1 per 100g. Fiber: 1.7 per 100g.",
          "garlic" = "Garlic can be stored in a cool, dry place for up to 2 months. It contains about 149 calories per 100g. Carbs: 33.06 per 100g. Protein: 6.36 per 100g. Fiber: 2.1 per 100g.",
          "peppers" = "Peppers can be stored in the fridge for up to 1 week. They contain about 20 calories per 100g. Carbs: 4.64 per 100g. Protein: 0.86 per 100g. Fiber: 1.7 per 100g.",
          "tuna" = "Tuna can be stored in the fridge for up to 2 days. It has about 144 calories per 100g. Carbs: 0 per 100g. Protein: 29.91 per 100g. Fiber: 0 per 100g.",
          "seafood" = "Seafood can be stored in the fridge for up to 2 days. It is a good source of protein and omega-3 fatty acids.",
          "salmonn" = "Salmon can be stored in the fridge for up to 2 days. It has about 206 calories per 100g. Carbs: 0 per 100g. Protein: 22.02 per 100g. Fiber: 0 per 100g.",
          "pork" = "Pork can be stored in the fridge for up to 3 days. It has about 143 calories per 100g. Carbs: 0 per 100g. Protein: 20.97 per 100g. Fiber: 0 per 100g.",
          "lamb" = "Lamb can be stored in the fridge for up to 3 days. It has about 250 calories per 100g. Carbs: 0 per 100g. Protein: 25.66 per 100g. Fiber: 0 per 100g.",
          "chicken" = "Chicken can be stored in the fridge for up to 2 days. It has about 165 calories per 100g. Carbs: 0 per 100g. Protein: 31.02 per 100g. Fiber: 0 per 100g."
        )
      })
      writeLines(unlist(item_text), file)
      
      
      
    }
  )
  
  output$fridgeItems <- renderUI({
    fridge_items <- input$rank_list_2
    items_html <- lapply(fridge_items, function(item) {
      tags$div(ingredient_list[item])
    })
    tags$div(class = "fridge-container", items_html)
  })
  
}


shinyApp(ui, server)
