get_data <- function(listingsurl, calendarurl){
  
  # Listings
  
  # Load data from URL
  listingscon <- gzcon(url(listingsurl))
  listingstxt <- readLines(listingscon)
  listingsdat <- read.csv(textConnection(listingstxt))
  
  # Transforming data into data frame type
  listings <- as.data.frame(listingsdat)
  
  print(paste0("Listings loaded : ", paste( unlist(dim(listings)), collapse = ' x ' ) ) )
  
  # Calendars
  
  # Load data from URL
  calendarcon <- gzcon(url(calendarurl))
  calendartxt <- readLines(calendarcon)
  calendardat <- read.csv(textConnection(calendartxt))
  
  # Transforming data into data frame type
  calendar <- as.data.frame(calendardat)
  
  print(paste0("Calendar loaded : ", paste( unlist(dim(calendar)), collapse = ' x ' ) ) )
    
    
  return(list(listings, calendar))
  
}

