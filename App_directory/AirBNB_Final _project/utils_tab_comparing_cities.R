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
  else if(input == "3"){
    return(dataframe$bedrooms)
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

get_ggplot <- function(input, aggregation, xlogscale, ylogscale, dataframe, title, xlabel, ylabel){
  if (input == "0"){
    if(aggregation == "2"){
      return()
    }
    else{
      return(ggplot(dataframe, aes(x=City, y=Y, fill=City)) +
               geom_bar(stat="identity") + 
               (if(ylogscale) scale_y_log10() else NULL) + (if(xlogscale) scale_x_log10() else NULL) +
               ggtitle(title) +
               labs(y=ylabel, x = xlabel)) 
    }
  }
  else if(input == "1"){
    if(aggregation == "2"){
      return(ggplot(dataframe, aes(Y, fill=City)) +
               geom_histogram(position = "dodge", bins=4) +
               (if(ylogscale) scale_y_log10() else NULL) + (if(xlogscale) scale_x_log10() else NULL) +
               ggtitle(title) +
               labs(y=ylabel, x = xlabel)) 
    }
    else{
      return()
    }
  }
  else if(input == "2"){
    if(aggregation == "2"){
      return(ggplot(dataframe, aes(x=City, y=Y, fill=City)) + 
               geom_boxplot(alpha=0.3) +
               (if(ylogscale) scale_y_log10() else NULL) + (if(xlogscale) scale_x_log10() else NULL) +
               ggtitle(title) +
               theme(legend.position="none")+
               labs(x=xlabel, y=ylabel)) 
    }
    else{
      return()
    }
  }
}


get_df <- function(input, berlin, girona, lyon){
  max_len <- max(lengths(list(berlin, girona, lyon)))
  
  length(berlin) <- max_len
  length(girona) <- max_len
  length(lyon) <- max_len
  
  X = c()
  Y = c()
  
  if("0" %in% input || "1" %in% input || "2" %in% input){
    X = c(X, "Berlin, Germany")
    Y = c(Y, ceiling(berlin))
  }
  if("3" %in% input || "4" %in% input || "5" %in% input){
    X = c(X, "Girona, Spain")
    Y = c(Y, ceiling(girona))
  }
  if("6" %in% input || "7" %in% input || "8" %in% input){
    X = c(X, "Lyon, France")
    Y = c(Y, ceiling(lyon))
  }
  
  if(length(X) == 0){
    X = c("Berlin, Germany", "Girona, Spain", "Lyon, France")
    Y = c(ceiling(berlin), ceiling(girona), ceiling(lyon))
  }
  
  return(data.frame("City" = X, "Y" = Y))
}


get_title <- function(aggregation, feature){
  label <- ""
  if(aggregation == "0"){
    label <- "Average"
  }
  else if(aggregation == "1"){
    label <- "Median"
  }
  
  if(feature == "0"){
    label <- paste(label, "availability over last 30 days")
  }
  else if(feature == "1"){
    label <- paste(label, "revenue over last 30 days")
  }
  else if(feature == "2"){
    label <- paste(label, "price")
  }
  else if(feature == "3"){
    label <- paste(label, "number of bedrooms per listing")
  }
  
  return(label)
  
}

get_x_label <- function(feature, plot){
  if(plot == "0" || plot == "2"){
    return("City")
  }
  else if(plot == "1"){
    if(feature =="0"){
      return("Days")
    }
    else if(feature == "1"){
      return("Revenue")
    }
    else if(feature =="2"){
      return("Price")
    }
  }
}

get_y_label <- function(feature, plot){
  if(plot == "0" || plot == "2"){
    if(feature =="0"){
      return("Days")
    }
    else if(feature == "1"){
      return("Revenue")
    }
    else if(feature =="2"){
      return("Price")
    }
  }
  else if(plot == "1"){
    return("Count")
  }
}

get_error <- function(plot, feature){
  if(plot == "0"){
    if(feature =="2"){
      return("Could not create an bar plot with no aggregated data. \n\nPlease set aggregation type to \"Median\" or \"Average\"")
    }
  }
  else if(plot == "1" || plot == "2"){
    if(feature != "2"){
      return("Could not create this kind of plot with aggregated data. \n\nPlease set aggregation type to \"None\"")
    }
  }
  return()
}

get_x_feature <- function(input, dataframe){
  if(input == "0"){
    return(dataframe$room_type)
  }
  else if(input == "1"){
    return(dataframe$property_type)
  }
  else if(input == "2"){
    return(dataframe$accomodates)
  }
  else if(input == "3"){
    return(dataframe$bedrooms)
  }
  else if(input == "4"){
    return(dataframe$availability_30)
  }
  else if(input == "5"){
    return(dataframe$revenue_30)
  }
}

get_y_feature <- function(input, dataframe){
  if(input == "0"){
    return(dataframe$accommodates)
  }
  else if(input == "1"){
    return(dataframe$bedrooms)
  }
  else if(input == "2"){
    return(dataframe$price)
  }
  else if(input == "3"){
    return(dataframe$availability_30)
  }
  else if(input == "4"){
    return(dataframe$revenue_30)
  }
}