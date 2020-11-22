library(shiny)
library(dplyr)
library(ggplot2)
library(rlist)
library(googleVis)
source("getGzCsv.R")
source("utils_tab_deep_dive.R")
source("utils_tab_data.R")
source("utils_tab_comparing_cities.R")

function(input, output, session) {
  # Initialization
  berlin <- get_data("https://github.com/L-HommeSage/Airbnb_Data_Analytics_Shiny/raw/main/CSV/berlin.csv.gz")
  girona <- get_data("https://github.com/L-HommeSage/Airbnb_Data_Analytics_Shiny/raw/main/CSV/girona.csv.gz")
  lyon <- get_data("https://github.com/L-HommeSage/Airbnb_Data_Analytics_Shiny/raw/main/CSV/lyon.csv.gz")
  
  
  ## FIRST TAB
  output$main_plot <- renderPlot({
    names <- names(berlin)
    berlin_filtered <- data.frame()
    girona_filtered <- data.frame()
    lyon_filtered <- data.frame()
    for (k in names){
      berlin_filtered[[k]]
      girona_filtered[[k]]
      lyon_filtered[[k]]
    }
    
    if("0" %in% input$cities)
      berlin_filtered <- subset(berlin, berlin$data_date == "13/10/2020")
    if("1" %in% input$cities)
      berlin_filtered <- rbind(berlin_filtered, subset(berlin, berlin$data_date == "23/09/2020"))
    if("2" %in% input$cities)
      berlin_filtered <- rbind(berlin_filtered, subset(berlin, berlin$data_date == "30/08/2020"))
    
    if("3" %in% input$cities)
      girona_filtered <- subset(girona, girona$data_date == "28/10/2020")
    if("4" %in% input$cities)
      girona_filtered <- rbind(girona_filtered, subset(berlin, berlin$data_date == "29/06/2020"))
    if("5" %in% input$cities)
      girona_filtered <- rbind(girona_filtered, subset(berlin, berlin$data_date == "28/05/2020"))
    
    if("6" %in% input$cities)
      lyon_filtered <- subset(lyon, lyon$data_date == "24/10/2020")
    if("7" %in% input$cities)
      lyon_filtered <- rbind(lyon_filtered, subset(lyon, lyon$data_date == "19/09/2020"))
    if("8" %in% input$cities)
      lyon_filtered <- rbind(lyon_filtered, subset(lyon, lyon$data_date == "31/08/2020"))
    
    berlin_clean_to_plot <- get_aggregation(input$aggregation, input$feature, berlin_filtered)
    girona_clean_to_plot <- get_aggregation(input$aggregation, input$feature, girona_filtered)
    lyon_clean_to_plot <- get_aggregation(input$aggregation, input$feature, lyon_filtered)
    
    df <- get_df(input$cities, berlin_clean_to_plot, girona_clean_to_plot, lyon_clean_to_plot)
    
    get_ggplot(input$plot, input$aggregation, input$xlogscale, input$ylogscale, 
               df, 
               get_title(input$aggregation, input$feature),
               get_x_label(input$feature, input$plot),
               get_y_label(input$feature, input$plot)
               )
  })
  
  output$error <- renderText({
    get_error(input$plot, input$aggregation)
  })
  
  output$multi_var_plot <- renderPlot({
    
    names <- names(berlin)
    df <- data.frame()
    for (k in names) df[[k]]
    
    if("0" %in% input$cities || "1" %in% input$cities || "2" %in% input$cities )
      df <- rbind(df, berlin)
    
    if("3" %in% input$cities || "4" %in% input$cities || "5" %in% input$cities)
      df <- rbind(df, girona)
    
    if("6" %in% input$cities || "7" %in% input$cities || "8" %in% input$cities)
      df <- rbind(df, lyon)
    
    ggplot(df) + 
    geom_bar(aes(
              x=get_x_feature(input$x_feature, df), 
              y=get_y_feature(input$y_feature, df), 
              fill=city), 
             stat="identity", 
             position = "dodge")
  })
  
  
  ## SECOND TAB
  observeEvent(input$map_city, {
    table = get_table(input$map_city, berlin, girona, lyon)
    max_revenue = max(table$revenue_30)
    max_bedrooms = max(table$bedrooms)
    
    updateSliderInput(session, "revenue_slider", value=c(0, max_revenue), max=max_revenue)
    updateSliderInput(session, "bedrooms_slider", value=c(0, max_bedrooms), max=max_bedrooms)
    updateSelectInput(session, "house_type", choices=unique(table$property_type))
    updateSelectInput(session, "room_type", choices=unique(table$room_type))
  })
  
  output$map <- renderGvis({
    gvisMap(
      get_map_filtered(
        input$revenue_slider, 
        input$availability_slider, 
        input$house_type,
        input$bedrooms_slider,
        input$room_type,
        get_table(input$map_city, berlin, girona, lyon)
      ), 
      "latlong", 
      "revenue_30",
      options=list(region="DE"))
  })
  
  
  output$insigths_panel <- renderText({
    map_dataframe <- get_map_filtered(
      input$revenue_slider, 
      input$availability_slider, 
      input$house_type,
      input$bedrooms_slider,
      input$room_type,
      get_table(input$map_city, berlin, girona, lyon)
    )
    
    paste("Number of matching listings : ", nrow(map_dataframe))
    
  })
  
  output$insight_plot_1 <- renderPlot({
    map_dataframe <- get_map_filtered(
      input$revenue_slider, 
      input$availability_slider, 
      input$house_type,
      input$bedrooms_slider,
      input$room_type,
      get_table(input$map_city, berlin, girona, lyon)
    )
    
    blank_theme <- theme_minimal()+
      theme(
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.border = element_blank(),
        panel.grid=element_blank(),
        axis.ticks = element_blank(),
        plot.title=element_text(size=14, face="bold")
      )
    
    ggplot(map_dataframe, aes(x = factor(1), fill=room_type)) + 
      geom_bar(width = 1) + 
      coord_polar("y") +
      ggtitle("Proportion of each room type") +
      blank_theme +  
      theme(axis.text.x=element_blank(), legend.position="bottom")
  })
  
  output$insight_plot_2 <- renderPlot({
    map_dataframe <- get_map_filtered(
      input$revenue_slider, 
      input$availability_slider, 
      input$house_type,
      input$bedrooms_slider,
      input$room_type,
      get_table(input$map_city, berlin, girona, lyon)
    )
    
    blank_theme <- theme_minimal()+
      theme(
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.border = element_blank(),
        panel.grid=element_blank(),
        axis.ticks = element_blank(),
        plot.title=element_text(size=14, face="bold")
      )
    
    ggplot(map_dataframe, aes(x = factor(1), fill=property_type)) + 
      geom_bar(width = 1) + 
      coord_polar("y") +
      ggtitle("Proportion of each property type") +
      blank_theme +  
      theme(axis.text.x=element_blank(), legend.position="bottom")
  })
  
  output$insight_plot_3 <- renderPlot({
    map_dataframe <- get_map_filtered(
      input$revenue_slider, 
      input$availability_slider, 
      input$house_type,
      input$bedrooms_slider,
      input$room_type,
      get_table(input$map_city, berlin, girona, lyon)
    )
    
    ggplot(map_dataframe, aes(y=bedrooms)) + 
      geom_boxplot(alpha=0.3) +
      ggtitle("Distribution of bedrooms :") +
      theme(legend.position="none") +
      ylim(0, max(map_dataframe$bedrooms) + 2) +
      labs(y="Bedrooms")
  })
  
  output$insight_plot_4 <- renderPlot({
    map_dataframe <- get_map_filtered(
      input$revenue_slider, 
      input$availability_slider, 
      input$house_type,
      input$bedrooms_slider,
      input$room_type,
      get_table(input$map_city, berlin, girona, lyon)
    )
    
    ggplot(map_dataframe, aes(y=availability_30)) + 
      geom_boxplot(alpha=0.3) +
      ggtitle("Distribution of availability for the next 30 days :") +
      theme(legend.position="none") +
      ylim(0, 32) +
      labs(y="Days of availability")
  })
  
  output$insight_plot_5 <- renderPlot({
    map_dataframe <- get_map_filtered(
      input$revenue_slider, 
      input$availability_slider, 
      input$house_type,
      input$bedrooms_slider,
      input$room_type,
      get_table(input$map_city, berlin, girona, lyon)
    )
    
    ggplot(map_dataframe, aes(y=revenue_30)) + 
      geom_boxplot(alpha=0.3) +
      ggtitle("Distribution of revenue for the next 30 days :") +
      theme(legend.position="none") +
      ylim(0, max(map_dataframe$revenue_30) + 500) +
      scale_y_log10() +
      labs(y="Revenue")
  })
  
  ## THIRD TAB
  output$data <- renderGvis({
    opts <- 
      list(
        page=TRUE,
        pageSize=input$pagesize,
        width=550
      )
    
    gvisTable(get_table(input$data_city, berlin, girona, lyon), options=opts)
  })
}


