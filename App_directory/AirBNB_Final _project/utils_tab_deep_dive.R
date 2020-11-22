get_map_filtered <- function(revenue, availability, house_type, input_bedrooms, input_room_type, dataframe){
  # Revenue
  filtered <- subset(dataframe, dataframe$revenue_30 > revenue[1])
  filtered <- subset(filtered, filtered$revenue_30 < revenue[2])
  
  # Availability
  filtered <- subset(filtered, filtered$availability_30 > availability[1])
  filtered <- subset(filtered, filtered$availability_30 < availability[2])
  
  # Room type
  if(!is.null(input_room_type)){
    filtered <- subset(filtered, filtered$room_type %in% input_room_type)
  }
  
  # House Type
  if(!is.null(house_type)){
    filtered <- subset(filtered, filtered$property_type %in% house_type)
  }
  
  # Bedrooms
  filtered <- subset(filtered, filtered$bedrooms > input_bedrooms[1])
  filtered <- subset(filtered, filtered$bedrooms < input_bedrooms[2])
  
  return(filtered)
}