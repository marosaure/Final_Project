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

#Background for recipe
ingredients <- c("avocado", "bacon", "bread", "butter", "cheese", "egg", "mushroom", "pasta", "potato", "tomato")
load("recipe.rda")

#Backgrund for map
n_stores <- 47
load("stores.rda")
Sys.setenv("OPENCAGE_KEY" = "b081a91d4d9e44b194bdd32d631335f9")



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
                   tags$img(src = "fruits_m.png", alt = "2", height = "1024px", width = "100%"),
                   tags$div(
                     class = "container",
                     tags$div(
                       class = "carousel-caption",
                       tags$h1(class = "fit-head", "You want to live more sustainaly?"),
                       tags$p(
                         class = "fit-text",
                         "Learn how long your food actually lasts, and how to reduce food waste."
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
                   tags$img(src = "legume_p.png", alt = "3", height = "2000px", width = "100%"),
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
                           onclick = "$('li:eq(1) a').tab('show');",
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
               column(12,
                      shiny::HTML("<br><br><center> <h1>Description of the project</h1> </center><br>"),
                      shiny::HTML("<h5>An interactive tool to help you explore the actual paths employees 
                                                   have taken during their County careers. With information about the 
                                                   popularity of certain paths, salary differences, and more, you can 
                                                   build your own path based on what is meaningful to you.</h5>")
               ),
               column(3)
             ),
             
             HTML("<br>"),
             
             #Embed video and spotify
             fluidRow(
               column(6),
               embed_url("https://youtu.be/0Ix8hIqB_8k") %>%
                 use_align("center") %>%
                 use_rounded(radius = 10),
               
               #Video Carousel
               tags$head(
                 tags$style(HTML('#myCarouselv {width: 500px; height: 300px; margin: 0 auto;}'))
               ),
               
               
               
               tags$div(
                 id = "myCarouselv",
                 class = "carousel slide",
                 "data-ride" = "carousel",
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
                   tags$div(
                     class = "item active",
                     embed_url("https://youtu.be/0Ix8hIqB_8k") %>%
                       use_align("center") %>%
                       use_rounded(radius = 10),
                     
                   ),
                   tags$div(
                     class = "item",
                     embed_url("https://youtu.be/2WecH55oT88") %>%
                       use_align("center") %>%
                       use_rounded(radius = 10),
                     
                   ),
                   tags$div(
                     class = "item",
                     embed_url("https://youtu.be/LhbyjTybuXs") %>%
                       use_align("center") %>%
                       use_rounded(radius = 10),
                     
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
               ),
               
             ),
             
             fluidRow(
               column(6),
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
    tabPanel("Myfridge"),
    tabPanel("Give Me a Recipe!",
             
             sidebarLayout(
               sidebarPanel(
                 width = 3,
                 
                 checkboxGroupInput("checkgroup", label = h4("Choose your ingredients up to 2"), 
                                    choices = ingredients),
                 
                 actionButton("refresh", "Refresh")
                 
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
                 tags$h3("Information"),
                 tags$p("Caloric needs are calculated based on your weight, height, age, sex, and physical activity level. They represent the estimated number of calories you need each day to maintain your current weight.")
               )
             )
             
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
      geom_line(color = "white", size = 1.5) +
      geom_point(aes(x = input$age, y = needs_range[which(age_range == input$age)]), color = "#3F2204", size = 4) +
      geom_vline(xintercept = input$age, color = "#3F2204", linetype = "dashed") +
      labs(title = "Caloric needs as a function of age",
           x = "Age", y = "Caloric needs") +
      theme_minimal() +
      theme(plot.background = element_rect(fill = '#9AD06E'),
            panel.grid.major = element_line(color = "#666666"),
            panel.grid.minor = element_line(color = "#666666"),
            panel.background = element_rect(fill = '#9AD06E'),
            axis.text = element_text(color = "black"),
            axis.title = element_text(color = "black"),
            plot.title = element_text(color = "black"))
    
    ggplotly(p, tooltip = "y") # Convert ggplot to plotly for interactive plot
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
