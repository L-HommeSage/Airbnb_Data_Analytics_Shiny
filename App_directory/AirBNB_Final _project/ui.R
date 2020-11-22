library(shiny)

navbarPage("Airbnb Analysis",
           tabPanel("Comparing cities",
                    fluidPage(
                      fluidRow(
                        sidebarLayout(
                          sidebarPanel(
                            checkboxGroupInput("cities", "Choose the cities to compare",
                                         c("Berlin, Germany, 13 October 2020"="0", 
                                           "Berlin, Germany, 23 September 2020"="1",
                                           "Berlin, Germany, 30 August 2020"="2",
                                           "Girona, Spain, 28 October 2020"="3", 
                                           "Girona, Spain, 29 Juin 2020"="4", 
                                           "Girona, Spain, 28 May 2020"="5", 
                                           "Lyon, France, 24 October 2020"="6",
                                           "Lyon, France, 19 September 2020"="7",
                                           "Lyon, France, 31 August 2020"="8"
                                           ),
                                         selected=c("0", "3","6")
                             ),
                             selectInput("feature", "Choose the feature",
                                         c(
                                           "Availability over last 30 days"="0",
                                           "Revenue over last 30 days"="1",
                                           "Price"="2",
                                           "Bedrooms"="3")
                             ),
                             selectInput("aggregation", "Select the aggregation type",
                                         c("Average"="0","Median"="1", "None"="2")
                             ),
                             selectInput("plot", "Select the plot type",
                                         c("Bar"="0","Density"="1", "Box"="2", "Violin"="3")
                             ),
                             checkboxInput("xlogscale", "Should X be log scale ?", value=FALSE),
                             checkboxInput("ylogscale", "Should Y be log scale ?", value=FALSE)
                          ),
                          mainPanel(
                            textOutput("error"),
                            plotOutput("main_plot")
                          )
                        )
                      ),
                      fluidRow(
                        sidebarLayout(
                          sidebarPanel(
                            selectInput("x_feature", "Select the feature to show in x axis",
                                        c(
                                          "Room type"="0",
                                          "Property type"="1", 
                                          "Accomodates"="2",
                                          "Bedrooms"="3",
                                          "Availability"="4",
                                          "Revenue"="5"
                                          )
                            ),
                            selectInput("y_feature", "Select the feature to show in y axis",
                                        c(
                                          "Accomodates"="0",
                                          "Bedrooms"="1", 
                                          "Price"="2", 
                                          "Availability"="3",
                                          "Revenue"="4"
                                          )
                            )
                          ),
                          mainPanel(
                            plotOutput("multi_var_plot")
                          )
                        )
                      )
                    )
           ),
           tabPanel("Deep dive into a city",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("map_city", "Choose a city to deep dive in :",
                                      c(
                                        "Berlin, Germany"="0",
                                        "Girona, Spain"="1",
                                        "Lyon, France"="2")
                          ),
                          selectInput("house_type", "Choose the property type",
                                      c("Loading, please wait"="0", "Loading, please wait"="1"),
                                      multiple=TRUE
                          ),
                          selectInput("room_type", "Choose the room type",
                                      c("Loading, please wait"="0", "Loading, please wait"="1"),
                                      multiple=TRUE
                          ),
                          sliderInput("bedrooms_slider", "Show listings with bedrooms in range :",
                                      min = 0, max = 30, value = c(0,30)),
                          sliderInput("revenue_slider", "Show listings with estimated revenue in range :",
                                      min = 0, max = 10000, value= c(0, 10000)),
                          sliderInput("availability_slider", "Show listings with estimated availability in range :",
                                      min = 0, max = 30, value= c(0, 30)),
                          
                        ),
                        mainPanel(
                          htmlOutput("map"),
                          hr(),
                          textOutput("insigths_panel")
                        )
                      ),
                    hr(),
                    fluidRow(
                      column(6, plotOutput("insight_plot_1")),
                      column(6, plotOutput("insight_plot_2"))
                    ),
                    hr(),
                    fluidRow(
                      column(4, plotOutput("insight_plot_3")),
                      column(4, plotOutput("insight_plot_4")),
                      column(4, plotOutput("insight_plot_5"))
                    )
           ),
           tabPanel("Data",
                    sidebarPanel(
                      selectInput("data_city", "Choose a city:",
                                  c(
                                    "Berlin, Germany"="0",
                                    "Girona, Spain"="1",
                                    "Lyon, France Kingdom"="2"),
                                  selected="0"
                      ),
                      numericInput(inputId = "pagesize", label = "Countries per page",10)    
                    ),
                    mainPanel(
                      htmlOutput("data")
                    )),
           tabPanel("Documentation")
)