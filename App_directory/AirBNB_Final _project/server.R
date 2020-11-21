library(shiny)
library(dplyr)
source("getGzCsv.R")
source("prepare_data.R")

function(input, output) {
  berlin <- get_data("https://github.com/L-HommeSage/Airbnb_Data_Analytics_Shiny/raw/main/csv/berlin.csv.gz")
  #bologna_data <- get_data("http://data.insideairbnb.com/italy/emilia-romagna/bologna/2020-10-24/data/listings.csv.gz", "http://data.insideairbnb.com/italy/emilia-romagna/bologna/2020-10-24/data/calendar.csv.gz")
  #london_data <- get_data("http://data.insideairbnb.com/united-kingdom/england/london/2020-10-13/data/listings.csv.gz", "http://data.insideairbnb.com/italy/emilia-romagna/bologna/2020-10-24/data/calendar.csv.gz")
  
  output$city_one <- renderText({ 
    paste("You have selected this", input$city_one)
  })
  
  output$city_two <- renderText({ 
    paste("You have selected this", input$city_two)
  })
}