library(shiny)
library(vembedr)
library(htmltools)
library(stringr)
library(dplyr)
library(leaflet)
library(geosphere)
library(opencage)
library(shinythemes)
library(ggplot2)
library(plotly)
library(sortable)
library(DiagrammeR)

#Background for recipe
ingredients <- c("avocado", "bacon", "bread", "butter", "cheese", "egg", "mushroom", "pasta", "potato", "tomato")
load("recipe.rda")

#Backgrund for map
n_stores <- 47
load("stores.rda")
Sys.setenv("OPENCAGE_KEY" = "b081a91d4d9e44b194bdd32d631335f9")


#Background for fridge
load("ingredient_list.rda")


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel(title = "Our nice fridge"),
  
  #navigation bar
  navbarPage(
    title = img(src = "fridge_logo.png", height = 30),
    id = "main_navbar",
    footer = includeHTML("www/footer.html"),
    theme = "style.css",
    
    #Tabs
    tabPanel("Home", value = "home",
             #Carousel
             tags$div(
               id = "myCarousel",
               class = "carousel slide",
               "data-ride" = "carousel",
               tags$ol(
                 class = "carousel-indicators",
                 tags$li(
                   class = "active",
                   "data-target" = "#myCarousel",
                   "data-slide-to" = "0"
                 ),
                 tags$li(
                   "data-target" = "#myCarousel",
                   "data-slide-to" = "1"
                 ),
                 tags$li(
                   "data-target" = "#myCarousel",
                   "data-slide-to" = "2"
                 ),
                 tags$li(
                   "data-target" = "#myCarousel",
                   "data-slide-to" = "3"
                 )
               ),
               tags$div(
                 class = "carousel-inner",
                 tags$div(
                   class = "item active",
                   tags$img(src = "fridge_q.png", alt = "1", height = "1024px", width = "100%"),
                   tags$div(
                     class = "container",
                     tags$div(
                       class = "carousel-caption",
                       tags$h1(class = "fit-head", "Welcome to My Fridge!"),
                       tags$p(
                         class = "fit-text",
                         "Don't want to be stressed while shopping? Then take a tour in our App!"
                       ),
                       tags$p(
                         tags$a(
                           class = "btn btn-lg btn-primary",
                           onclick = "$('li:eq(1) a').tab('show');",
                           role = "button",
                           "Get started now »"
                         )
                       )
                     )
                   )
                 ),
                 tags$div(
                   class = "item",
                   tags$img(src = "recipe.jpg", alt = "2", height = "1024px", width = "100%"),
                   tags$div(
                     class = "container",
                     tags$div(
                       class = "carousel-caption",
                       tags$h1(class = "fit-head", "No idea what to eat for dinner?"),
                       tags$p(
                         class = "fit-text",
                         "Check out our proposed recipes that are both tasty and help you use up the leftover food in your fridge"
                       ),
                       tags$a(
                         class = "btn btn-lg btn-primary",
                         onclick = "$('li:eq(2) a').tab('show');",
                         role = "button",
                         "Get started now »"
                       )
                     )
                   )
                 ),
                 tags$div(
                   class = "item",
                   tags$img(src = "calories.jpg", alt = "3", height = "1024px", width = "100%"),
                   tags$div(
                     class = "container",
                     tags$div(
                       class = "carousel-caption",
                       tags$h1(class = "fit-head", "No idea what to eat for dinner?"),
                       tags$p(
                         class = "fit-text",
                         "Check out our proposed recipes that are both tasty and help you use up the leftover food in your fridge"
                       ),
                       tags$p(
                         tags$a(
                           class = "btn btn-lg btn-primary",
                           onclick = "$('li:eq(3) a').tab('show');",
                           role = "button",
                           "Get started now »"
                         )
                       )
                     )
                   )
                 ),
                 tags$div(
                   class = "item",
                   tags$img(src = "shops.jpg", alt = "4", height = "1024px", width = "100%"),
                   tags$div(
                     class = "container",
                     tags$div(
                       class = "carousel-caption",
                       tags$h1(class = "fit-head", "You want to live more sustainaly?"),
                       tags$p(
                         class = "fit-text",
                         "Learn how long your food actually lasts, and how to reduce food waste."
                       ),
                       tags$p(
                         tags$a(
                           class = "btn btn-lg btn-primary",
                           onclick = "$('li:eq(4) a').tab('show');",
                           role = "button",
                           "Get started now »"
                         )
                       )
                     )
                   )
                 )
                 
               ),
               tags$a(
                 class = "left carousel-control",
                 href = "#myCarousel",
                 "data-slide" = "prev",
                 tags$span(class = "glyphicon glyphicon-chevron-left")
               ),
               tags$a(
                 class = "right carousel-control",
                 href = "#myCarousel",
                 "data-slide" = "next",
                 tags$span(class = "glyphicon glyphicon-chevron-right")
               )
             ),
             
             #HTML TEXT? 
             fluidRow(
               style = "height:50px;",
               column(6),
               column(
                 12,
                 tags$h1(
                   style = "text-align: center;",
                   "Description of the project"
                 ),
                 tags$h5(
                   style = "text-align: center;",
                   "An interactive tool to help you explore the actual paths employees have taken during their County careers. With information about the popularity of certain paths, salary differences, and more, you can build your own path based on what is meaningful to you."
                 )
               ),
               column(6)
             ),
             
             HTML("<br><br>"),
             
             #Embed video and spotify
             fluidRow(
               style = "height:50px;",
               column(6),
               column(
                 12,
                 tags$h1(
                   style = "text-align: center;",
                   "Useful Video"
                 )
               ),
               column(12,
                      # Video Carousel
                      tags$head(
                        tags$style(HTML('#myCarouselv {width: 500px; height: 300px; margin: 0 auto;}'))
                      ),
                      tags$div(
                        id = "myCarouselv",
                        class = "carousel slide",
                        "data-ride" = "carousel",
                        style = "position: relative;",
                        tags$ol(
                          class = "carousel-indicators",
                          tags$li(
                            class = "active",
                            "data-target" = "#myCarouselv",
                            "data-slide-to" = "0"
                          ),
                          tags$li(
                            "data-target" = "#myCarouselv",
                            "data-slide-to" = "1"
                          ),
                          tags$li(
                            "data-target" = "#myCarouselv",
                            "data-slide-to" = "2"
                          )
                        ),
                        tags$div(
                          class = "carousel-inner",
                          style = "position: absolute; top: 0; left: 0; right: 0; bottom: 0;",
                          tags$div(
                            class = "item active",
                            style = "text-align: center;",
                            embed_url("https://youtu.be/0Ix8hIqB_8k") %>%
                              use_align("center") %>%
                              use_rounded(radius = 10)
                          ),
                          tags$div(
                            class = "item",
                            style = "text-align: center;",
                            embed_url("https://youtu.be/2WecH55oT88") %>%
                              use_align("center") %>%
                              use_rounded(radius = 10)
                          ),
                          tags$div(
                            class = "item",
                            style = "text-align: center;",
                            embed_url("https://youtu.be/LhbyjTybuXs") %>%
                              use_align("center") %>%
                              use_rounded(radius = 10)
                          )
                        ),
                        tags$a(
                          class = "left carousel-control",
                          href = "#myCarouselv",
                          "data-slide" = "prev",
                          tags$span(class = "glyphicon glyphicon-chevron-left")
                        ),
                        tags$a(
                          class = "right carousel-control",
                          href = "#myCarouselv",
                          "data-slide" = "next",
                          tags$span(class = "glyphicon glyphicon-chevron-right")
                        )
                      )
               ),
               column(6)
             ),
             
             HTML("<br><br>"),
             
             fluidRow(
               column(6),
               column(
                 12,
                 tags$h1(
                   style = "text-align: center;",
                   "Background Music"
                 )
               ),
               tags$iframe(
                 style="border-radius:12px", 
                 src="https://open.spotify.com/embed/playlist/7yWS4mNsIXUYtm71xDIWe8", 
                 width="100%", 
                 height="350", 
                 frameBorder="0", 
                 allowfullscreen="", 
                 allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture", 
                 loading="lazy")
             ),
             
    ),
    tabPanel("Myfridge",
             
             tags$head(
               tags$style(HTML(".bucket-list-container {min-height: 450px;}
                    h2 {font-size: 30px;}
                    #results_2 {
                      background-color: #FFFF99;
                      color: #333;
                      font-size: 16px;
                      padding: 20px;
                      border-radius: 10px;
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
                 width = 12,
                 div(id = "explanations",
                     tags$h2("Explanations"),
                     tags$p("According to a study conducted in 2020 by", tags$a("Eurostat", href = "https://ec.europa.eu/eurostat/statistics-explained/index.php?title=Food_waste_and_food_waste_prevention_-_estimates#Amounts_of_food_waste_at_EU_level"), ", the average european household wasted around 70 kilos of perfectly fine food in the year 2020."),
                     tags$p("We want to help you reduce the foodwaste you produce. In orderto do so, we crated a virtual fridge, which gives you indications on how long each food keeps."),
                     tags$p("Most Foods keep for way longer than it is indicated on their original packaging. This Fridge aims to help you keep these foods for longer, and helps you to stay organized and have an overview of what is left in your fridge.")
                 )
               )
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
                 width = 6,
                 tags$h3("Result"),
                 tags$div(style = "white-space: normal", htmlOutput("results_2"))
               ),
               column(
                 width = 6,
                 tags$h3("My refrigerator contains:"),
                 tags$div(class = "fridge-container", uiOutput("fridgeItems"))
               )
             ),
             
             fluidRow(
               column(
                 width = 12,
                 uiOutput("downloadSummary")
               )
             ),
             
             tags$br(),
             tags$br()
             
             ),
    tabPanel("Give Me a Recipe!",
             
             sidebarLayout(
               sidebarPanel(
                 width = 3,
                 
                 checkboxGroupInput("checkgroup", label = h4("Choose your ingredients up to 2"), 
                                    choices = ingredients)
                 
               ),
               mainPanel(
                 
                 htmlOutput("content")
                 
               )
             )
             
             
             ),
    
    tabPanel("Caloric calculator",
             
             tags$h1("Calories you need"),
             
             
             # Add gif at the beginning of the page
             tags$div(
               style = "text-align: center;",
               tags$img(src = "https://media4.giphy.com/media/t9811uoqdhx9pQZx3z/giphy.gif?cid=ecf05e474rwgefqvkp8ra3w0fomhaet9bjans2r60ryip0gn&ep=v1_gifs_related&rid=giphy.gif&ct=g",
                        style = 'height: 100%; width: 500; object-fit: contain; margin: auto;'
               )
             ),
             
             HTML("<br><br><br>"),
             
             sidebarLayout(
               sidebarPanel(
                 sliderInput("weight",
                             "Your weight (kg):",
                             min = 40, max = 200, value = 70),
                 
                 sliderInput("height",
                             "Your height (cm):",
                             min = 140, max = 210, value = 175),
                 
                 sliderInput("age",
                             "Your age (years):",
                             min = 10, max = 100, value = 25),
                 
                 radioButtons("sex",
                              "Sex:",
                              choices = list("Male" = 1,
                                             "Female" = 2),
                              selected = 1),
                 
                 radioButtons("activity",
                              "Physical activity level:",
                              choices = list("Sedentary" = 1.2,
                                             "Light Activity" = 1.375,
                                             "Moderate Activity" = 1.55,
                                             "Intense Activity" = 1.725,
                                             "Very Intense Activity" = 1.9),
                              selected = 1.2),
                 
                 actionButton("reset", "Reset")
               ),
               
               mainPanel(
                 tags$h2("Result"),
                 textOutput("needs"),
                 plotlyOutput("needsPlot"), # change to plotlyOutput
                 HTML("<br><br>")
                 
               )
             ),
             
             fluidRow(
               column(6),
               column(12,
                      tags$h3("Information"),
                      tags$p("Caloric needs are calculated based on your weight, height, age, sex, and physical activity level. They represent the estimated number of calories you need each day to maintain your current weight."),
                      HTML("<br><br>")),
               column(6)
             ),

             
             ),
    
    tabPanel("Usefull Maps",
             
             tags$h1("Find your nearest green shop"),
             
             sidebarLayout(
               sidebarPanel(
                 sliderInput("max_distance", "Maximum distance (in meters):",
                             min = 0, max = 10000, value = 10000, step = 100),
                 textInput("address", "Enter your address:"),
                 selectInput("store_type", "Choose a location type:", choices = c("All", unique(stores$type))),
                 selectInput("opening_hours", "Choose Opening Hours:", choices = c("All", unique(stores$opening_hours))), # New input for Opening Hours
                 actionButton("enter", "Enter")  # 'Enter' button moved here
               ),
               mainPanel(
                 leafletOutput("map")
               )
             )
             
             )
    
    #Fin
  ),
)








# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$results_2 <- renderPrint(input$rank_list_2) # This matches the input_id of the second rank list
  
  observeEvent(input$rank_list_2, {
    selected_items <- input$rank_list_2
    item_text <- lapply(selected_items, function(item) {
      switch(
        item,
        "apple" = "Apples usually keep in the fridge 4 to 6 weeks. If brown spots appear, you can cut around them. Once cut, they last for up to 5 days. Calories: 52 per 100g. Protein: 0.3 per 100g. Carbs: 13.8 per 100g. Fiber: 2.4 per 100g.",
        "banana" = "Bananas are best stored at room temperature and can last for up to a week. Even if they start having bronw spots, they are still safe to eat. They have about 96 calories per 100g. Carbs: 22 per 100g. Protein: 1.1 per 100g. Fiber: 2.6 per 100g.",
        "pineapple" = "A whole pineapple stored in the fridge can last for 1 to 4 weeks depending on ripeness; cut pieces can last for 3 to 4 days. It has about 50 calories per 100g. Carbs: 13.1 per 100g. Protein: 0.5 per 100g. Fiber: 1.4 per 100g.",
        "raspberry" = "Raspberries can be refrigerated for 2 to 3 days. They have about 52 calories per 100g. Carbs: 11.9 per 100g. Protein: 1.2 per 100g. Fiber: 6.5 per 100g.",
        "pear" = "Pears can be kept in the fridge for up to 2 weeks. They have about 57 calories per 100g. Carbs: 15.2 per 100g. Protein: 0.4 per 100g. Fiber: 3.1 per 100g.",
        "oorange" = "Oranges can be stored in the fridge for up to 2 weeks, but they can also be kept at room temperature for up to 2 weeks. They have about 43 calories per 100g. Carbs: 8.3 per 100g. Protein: 0.9 per 100g. Fiber: 2.4 per 100g.",
        "strawberry" = "Strawberries can be refrigerated for 5 to 7 days. They have about 32 calories per 100g. Carbs: 7.7 per 100g. Protein: 0.7 per 100g. Fiber: 2.0 per 100g.",
        "lemon" = "Lemons can last in the fridge and in room temperature for up to 4 weeks. They have about 29 calories per 100g. Carbs: 9.3 per 100g. Protein: 1.1 per 100g. Fiber: 2.8 per 100g.",
        "mango" = "A ripe mango can last in the fridge for up to 5 days. It has about 60 calories per 100g. Carbs: 14.98 per 100g. Protein: 0.82 per 100g. Fiber: 1.6 per 100g.",
        "poultry" = "Raw poultry can be stored in the fridge for 3-4 days after first buying it. It's high in protein and contains varying amounts of fat and cholesterol depending on the cut.",
        "butter" = "Butter can be stored in the fridge for up to 1 month. It's high in fat and calories, with about 717 calories per 100g. Carbs: 0.06 per 100g. Protein: 0.85 per 100g. Fiber: 0 per 100g.",
        "cheese0" = "Different cheeses have different shelf lives, but most will last 1-4 weeks in the fridge. Hard cheese can usually be kept for way longer, and as long as they are not moldy, they are safe to eat. They are high in calcium and protein, with caloric content varying widely.",
        "cheese1" = "Mozzarella and soft cheese can be stored in the fridge for up to 1 week. It has about 280 calories per 100g. Carbs: 2.2 per 100g. Protein: 28.97 per 100g. Fiber: 0 per 100g.",
        "milk" = "Milk should be consumed within 1 week of opening, but can last up to 2 weeks. It has about 42 calories per 100g. Carbs: 4.7 per 100g. Protein: 3.3 per 100g. Fiber: 0 per 100g.",
        "yaourt" = "Yogurt can be stored in the fridge for up to 2 weeks, but even after, it is safe to eat as long as it is not moldy. It has about 59 calories per 100g. Carbs: 3.6 per 100g. Protein: 10.1 per 100g. Fiber: 0 per 100g.",
        "salad" = "Salad greens can last in the fridge for up to a week. They contain about 5 calories per 100g. Carbs: 1 per 100g. Protein: 0.6 per 100g. Fiber: 1.1 per 100g.",
        "cucumber" = "Cucumbers can be stored in the fridge for up to a week. They contain about 15 calories per 100g. Carbs: 3.63 per 100g. Protein: 0.65 per 100g. Fiber: 0.5 per 100g.",
        "carot" = "Carrots can be kept in the fridge for up to 2-3 weeks. They contain about 41 calories per 100g. Carbs: 9.58 per 100g. Protein: 0.93 per 100g. Fiber: 2.8 per 100g.",
        "tomahtoh" = "Tomatoes are best stored at room temperature and can last for up to 2 weeks, depending on their ripeness. They contain about 18 calories per 100g. Carbs: 3.9 per 100g. Protein: 0.9 per 100g. Fiber: 1.2 per 100g.",
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
          "apple" = "Apples usually keep in the fridge 4 to 6 weeks. Once cut, they last for up to 5 days. Calories: 52 per 100g. Protein: 0.3 per 100g. Carbs: 13.8 per 100g. Fiber: 2.4 per 100g.",
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

  output$img2 <- renderImage({
    # Use the 'img2' file in the www directory
    filename <- "First_Attempt/www/try cat.png"
    path <- paste(getwd(), "/", filename, sep="")
    # Return a list containing the filename
    list(src = path, alt = "First_Attempt/www/try cat.png")
  }, deleteFile = FALSE)
  
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
        filter(all(sapply(checkgroup, function(x) any(str_detect(ingredient, x))))) %>%
        filter(! duplicated(item))
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
                             filtered_items$content[i], "<br><br>",
                             "<hr>"
        )
      }
      HTML(output_html)
    }
  })
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      setView(lng = 6.1432, lat = 46.2044, zoom = 13)
  })
  
  observeEvent(input$enter, {  
    max_distance <- input$max_distance
    address <- input$address
    store_type <- input$store_type
    opening_hours <- input$opening_hours  # get the selected opening_hours
    
    # Filter data based on store_type
    if (store_type == "All") {
      filtered_data <- stores
    } else {
      filtered_data <- stores %>% filter(type == store_type)
    }
    
    # Further filter data based on opening_hours
    if (opening_hours != "All") {
      filtered_data <- filtered_data %>% filter(opening_hours == opening_hours)
    }
    
    if (address != "") {
      geocoded_address <- oc_forward_df(placename = address)
      
      if (!is.null(geocoded_address$oc_lat)) {
        center_point <- c(geocoded_address$oc_lat, geocoded_address$oc_lng)
        filtered_data <- filtered_data %>%
          mutate(distance = distVincentySphere(cbind(latitude, longitude), center_point)) %>%
          filter(distance <= max_distance)
      }
    }
    
    leafletProxy("map") %>%
      clearMarkers() %>%
      addCircleMarkers(data = filtered_data,
                       lng = ~longitude,
                       lat = ~latitude,
                       popup = ~name,
                       color = "green",
                       stroke = FALSE, fillOpacity = 0.8) %>%
      addMarkers(geocoded_address$oc_lng, geocoded_address$oc_lat, popup = "Your location")
  })
  
  observeEvent(input$reset, {
    updateSliderInput(session, "weight", value = 70)
    updateSliderInput(session, "height", value = 175)
    updateSliderInput(session, "age", value = 25)
    updateRadioButtons(session, "sex", selected = 1)
    updateRadioButtons(session, "activity", selected = 1.2)
  })
  
  output$needs <- renderText({
    if(input$sex == 1){
      needs <- 66 + (13.75 * input$weight) + (5 * input$height) - (6.75 * input$age)
    }else{
      needs <- 655 + (9.56 * input$weight) + (1.85 * input$height) - (4.68 * input$age)
    }
    
    needs <- needs * as.numeric(input$activity)
    
    return(paste0("Your daily caloric needs are approximately ", round(needs), " calories."))
  })
  
  output$needsPlot <- renderPlotly({ # change to renderPlotly
    age_range <- seq(10, 100, by = 1)
    
    if(input$sex == 1){
      needs_range <- 66 + (13.75 * input$weight) + (5 * input$height) - (6.75 * age_range)
    }else{
      needs_range <- 655 + (9.56 * input$weight) + (1.85 * input$height) - (4.68 * age_range)
    }
    
    needs_range <- needs_range * as.numeric(input$activity)
    
    data <- data.frame(Age = age_range, Needs = needs_range)
    
    p <- ggplot(data, aes(x = Age, y = Needs)) +
      geom_line(color = "#b4d3ba", size = 1.5) +
      geom_point(aes(x = input$age, y = needs_range[which(age_range == input$age)]), color = "#3F2204", size = 4) +
      geom_vline(xintercept = input$age, color = "#3F2204", linetype = "dashed") +
      labs(title = "Caloric needs as a function of age",
           x = "Age", y = "Caloric needs") +
      theme_minimal() +
      theme(plot.background = element_rect(fill = '#fdfefd'),
            panel.grid.major = element_line(color = "#666666"),
            panel.grid.minor = element_line(color = "#666666"),
            panel.background = element_rect(fill = '#fdfefd'),
            axis.text = element_text(color = "black"),
            axis.title = element_text(color = "black"),
            plot.title = element_text(color = "black"))
    
    ggplotly(p, tooltip = "y") # Convert ggplot to plotly for interactive plot
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
