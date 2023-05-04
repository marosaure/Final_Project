
library(shiny)
library(blastula)
library(glue)
# Define on Logo 
img_path_2 <- "logo frigo.png"
ds_logo <- add_image(img_path_2, width = 200)
header_text <- md(glue(ds_logo))

