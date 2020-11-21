library(shiny)

navbarPage("Airbnb Analysis",
           tabPanel("Comparing cities",
                    fluidPage(
                      fluidRow(
                        sidebarLayout(
                          sidebarPanel(
                             radioButtons("city_one", "Choose the first city",
                                         c("Berlin"="0", "Bologna"="1", "London"="2")
                             ),
                             radioButtons("city_two", "Choose the second city",
                                         c("Berlin"="0", "Bologna"="1", "London"="2")
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
                             checkboxInput("ylogscale", "Would you like Y to be in log scale ?", value=FALSE)
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