library(shiny)

ui <- fluidPage(
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
        tags$img(src = "First_Attempt/www/", alt = "1"),
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
        tags$img(src = "fruits .jpeg", alt = "2"),
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
        tags$img(src = "legumes .jpeg", alt = "3"),
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
  )
)

server <- function(input, output) {
  # No 
}

shinyApp(ui = ui, server = server)