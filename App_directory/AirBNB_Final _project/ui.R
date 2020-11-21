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
                            )
                          ),
                          mainPanel(
                            textOutput("city_one"),
                            textOutput("city_two")
                          )
                        ),
                      ),
                    ),
           ),
           tabPanel("Deep dive into a city"),
           tabPanel("Documentation")
)