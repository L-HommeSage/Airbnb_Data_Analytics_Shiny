get_city_name <- function(input) {
  city <- ""
  if (input == "0"){
    city <- "Berlin"
  }
  else if(input == "1"){
    city <- "Bologna"
  }
  else if(input == '2'){
    city <- "London"
  }
  return(city)
}


get_feature <- function(input, dataframe) {
  if (input == "0"){
    return(dataframe$availability_30)
  }
  else if(input == "1"){
    return(dataframe$revenue_30)
  }
  else if(input == '2'){
    return(dataframe$price)
  }
}

get_aggregation <- function(input, feature, dataframe){
  if (input == "0"){
    return(sum(get_feature(feature, dataframe))/nrow(dataframe))
  }
  else if(input == "1"){
    return(median(get_feature(feature, dataframe)))
  }
  else if(input =="2"){
    return(get_feature(feature, dataframe))
  }
}


get_ggplot <- function(input, xlogscale, ylogscale, dataframe){
  if (input == "0"){
    return(ggplot(dataframe, aes(x=City, y=Y, fill=City)) +
           geom_bar(stat="identity") + 
           (if(ylogscale) scale_y_log10() else NULL) + (if(xlogscale) scale_x_log10() else NULL) +
           ggtitle("Average availability over 30 days of listings per each city") +
           labs(y="Average availability in days", x = "City"))
  }
  else if(input == "1"){
    return(ggplot(dataframe, aes(Y, fill=City)) +
           geom_histogram(position = "dodge", bins=4) +
           (if(ylogscale) scale_y_log10() else NULL) + (if(xlogscale) scale_x_log10() else NULL) +
           ggtitle("Distribution of estimated availability for the next 30 days of listings per each city") +
           labs(y="Count of listings available", x = "Days of availability per 30 days"))
  }
  else if(input == "2"){
    return(ggplot(dataframe, aes(x=City, y=Y, fill=City)) + 
           geom_boxplot(alpha=0.3) +
           (if(ylogscale) scale_y_log10() else NULL) + (if(xlogscale) scale_x_log10() else NULL) +
           ggtitle("Distribution of availability over the next 30 days for each room type") +
           theme(legend.position="none")+
           labs(x="Room Type", y="Availability over the next 30 days"))
  }
}


get_df <- function(input, berlin, girona, lyon){
  max_len <- max(lengths(list(berlin, girona, lyon)))
  
  length(berlin) <- max_len
  length(girona) <- max_len
  length(lyon) <- max_len

  X = c()
  Y = c()
  
  if("0" %in% input){
    X = c(X, "Berlin, Germany")
    Y = c(Y, ceiling(berlin))
  }
  if("1" %in% input){
    X = c(X, "Girona, Spain")
    Y = c(Y, ceiling(girona))
  }
  if("2" %in% input){
    X = c(X, "Lyon, France")
    Y = c(Y, ceiling(lyon))
  }
  
  return(data.frame("City" = X, "Y" = Y))
}


