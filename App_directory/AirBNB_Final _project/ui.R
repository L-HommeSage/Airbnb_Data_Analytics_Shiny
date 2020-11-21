library(shiny)

navbarPage("Airbnb Analysis",
           tabPanel("Comparing cities",
                    fluidPage(
                      fluidRow(
                        sidebarLayout(
                          sidebarPanel(
                            checkboxGroupInput("cities", "Choose the cities to compare",
                                         c("Berlin, Germany"="0", "Girona, Spain"="1", "London"="2")
                             ),
                             selectInput("feature", "Choose the feature",
                                         c(
                                           "Availability over last 30 days"="0",
                                           "Revenue over last 30 days"="1",
                                           "Price"="2")
                             ),
                             selectInput("aggregation", "Select the aggregation type",
                                         c("Average"="0","Median"="1", "No"="2")
                             ),
                             selectInput("plot", "Select the plot type",
                                         c("Histogram"="0","Density"="1", "Box"="2", "Violin"="3")
                             ),
                             checkboxInput("xlogscale", "Should X be log scale ?", value=FALSE),
                             checkboxInput("ylogscale", "Should Y be log scale ?", value=FALSE)
                          ),
                          mainPanel(
                            textOutput("city_one"),
                            textOutput("city_two"),
                            plotOutput("main_plot")
                          )
                        ),
                      ),
                    ),
           ),
           tabPanel("Deep dive into a city"),
           tabPanel("Documentation")
)