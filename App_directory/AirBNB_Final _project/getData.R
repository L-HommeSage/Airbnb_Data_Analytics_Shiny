#Import libraries
library(dplyr)
library(data.table)

get_data <- function(city,data_date){
  
  #Load the dataset
  listings_url <- paste0("http://data.insideairbnb.com/canada/bc/",city,"/",data_date,"/data/listings.csv.gz")
  calendar_url <- paste0("http://data.insideairbnb.com/canada/bc/",city,"/",data_date,"/data/calendar.csv.gz")
  
  #Read the data
  listings <- data.table::fread(listings_url)
  calendar <- data.table::fread(calendar_url)
  
  ## Add Keys: columns city and day date
  listings$city <- city
  
  ## Select interesting columns
  ### Most columns don't contain interesting information
  columns_listings <- c("city", "id", "neighbourhood_cleansed", 
                        "latitude", "longitude", 
                        "property_type", "room_type", "accommodates", "bedrooms", 
                        "beds", "price", "minimum_nights",  "maximum_nights")
  
  listings <- listings %>% 
    select(columns_listings) %>% 
    arrange(id)
  
}