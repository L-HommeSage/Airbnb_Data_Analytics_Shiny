library(shiny)
library(dplyr)
library(ggplot2)
library(rlist)
source("getGzCsv.R")
source("utils.R")

function(input, output) {
  berlin <- get_data("https://github.com/L-HommeSage/Airbnb_Data_Analytics_Shiny/raw/main/csv/berlin.csv.gz")
  girona <- get_data("https://github.com/L-HommeSage/Airbnb_Data_Analytics_Shiny/raw/main/csv/girona.gz")
  lyon <- get_data("https://github.com/L-HommeSage/Airbnb_Data_Analytics_Shiny/raw/main/csv/lyon.csv.gz")
  
  output$main_plot <- renderPlot({
    berlin_clean_to_plot <- get_aggregation(input$aggregation, input$feature, berlin)
    girona_clean_to_plot <- get_aggregation(input$aggregation, input$feature, girona)
    lyon_clean_to_plot <- get_aggregation(input$aggregation, input$feature, lyon)
    
    df <- get_df(input$cities, berlin_clean_to_plot, girona_clean_to_plot, lyon_clean_to_plot)
    
    get_ggplot(input$plot, input$xlogscale, input$ylogscale, df)
  })
}


