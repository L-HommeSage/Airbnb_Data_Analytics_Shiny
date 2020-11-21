get_data <- function(csvurl){
  
  # Listings
  
  # Load data from URL
  con <- gzcon(url(csvurl))
  txt <- readLines(con)
  dat <- read.csv(textConnection(txt))
  
  # Transforming data into data frame type
  listings <- as.data.frame(dat)
  
  print(paste0("Listings loaded : ", paste( unlist(dim(listings)), collapse = ' x ' ) ) )
  
  print(head(listings))
  
  return(listings)
}

