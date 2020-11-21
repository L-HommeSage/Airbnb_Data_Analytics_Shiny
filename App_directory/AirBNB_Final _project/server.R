library(shiny)
library(dplyr)
library(ggplot2)
source("getGzCsv.R")
source("utils.R")

function(input, output) {
  berlin <- get_data("https://github.com/L-HommeSage/Airbnb_Data_Analytics_Shiny/raw/main/csv/berlin.csv.gz")
  #bologna_data <- get_data("http://data.insideairbnb.com/italy/emilia-romagna/bologna/2020-10-24/data/listings.csv.gz", "http://data.insideairbnb.com/italy/emilia-romagna/bologna/2020-10-24/data/calendar.csv.gz")
  #london_data <- get_data("http://data.insideairbnb.com/united-kingdom/england/london/2020-10-13/data/listings.csv.gz", "http://data.insideairbnb.com/italy/emilia-romagna/bologna/2020-10-24/data/calendar.csv.gz")
  
  output$main_plot <- renderPlot({
    berlin_clean_to_plot <- get_aggregation(input$aggregation, input$feature, berlin)
    
    df <- data.frame("City" = c("Berlin", "Berlin2", "Berlin3"), "Y" = c(ceiling(berlin_clean_to_plot),ceiling(berlin_clean_to_plot), ceiling(berlin_clean_to_plot)))
    
    get_ggplot(input$plot, input$ylogscale, df)
  })
}


