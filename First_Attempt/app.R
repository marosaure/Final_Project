
library(shiny)
library(vembedr)
library(htmltools)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Our nice fridge"),
    
    #navigation bar
    navbarPage(
      "Welcome to fridge!",
      id = "main_navbar",
      
      #Tabs
      tabPanel("MyFridge"),
      tabPanel("Give Me a Recipe!"),
      tabPanel("Usefull Maps")
      
      #Fin
      ),
    
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
          tags$img(src = "fridge_image.png", alt = "1", height = "1024px", width = "100%"),
          tags$div(
            class = "container",
            tags$div(
              class = "carousel-caption",
              tags$h1(class = "fit-head", "Don't want to be stressed when shopping?"),
              tags$p(
                class = "fit-text",
                "Use Intelligentsia's interactive map to identify pockets of opportunity."
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
          tags$img(src = "fruits.png", alt = "2"),
          tags$div(
            class = "container",
            tags$div(
              class = "carousel-caption",
              tags$h1(class = "fit-head", "Try My Fridge!"),
              tags$p(
                class = "fit-text",
                "You have already identified a few locations and want to compare them?"
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
          tags$img(src = "legumes.png", alt = "3"),
          tags$div(
            class = "container",
            tags$div(
              class = "carousel-caption",
              tags$h1(class = "fit-head", "Identify new opportunities"),
              tags$p(
                class = "fit-text",
                "You want to invest into real estate, but don't know where?"
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
    
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        
        mainPanel(
          
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
           
        #Embed video and spotify
        fluidRow(
          embed_url("https://youtu.be/0Ix8hIqB_8k") %>%
            use_align("center") %>%
            use_rounded(radius = 10)
        ),
        
        fluidRow(
          tags$iframe(
            style="border-radius:12px", 
            src="https://open.spotify.com/embed/playlist/7yWS4mNsIXUYtm71xDIWe8?utm_source=generator", 
            width="80%", 
            height="350", 
            frameBorder="0", 
            allowfullscreen="", 
            allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture", 
            loading="lazy")
        ),


        fluidRow(style = "height:25px;",)
        
        
        )
    )
)



# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
    
    output$img2 <- renderImage({
      # Use the 'img2' file in the www directory
      filename <- "First_Attempt/www/try cat.png"
      path <- paste(getwd(), "/", filename, sep="")
      # Return a list containing the filename
      list(src = path, alt = "First_Attempt/www/try cat.png")
    }, deleteFile = FALSE)

}

# Run the application 
shinyApp(ui = ui, server = server)
