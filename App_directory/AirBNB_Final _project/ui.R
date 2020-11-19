library(shiny)

navbarPage("Airbnb Analysis",
           tabPanel("Comparing cities",
                    fluidPage(
                      fluidRow(
                        sidebarLayout(
                          sidebarPanel(
                            radioButtons("plotType", "Plot type",
                                         c("Scatter"="p", "Line"="l")
                            ),
                            sliderInput("num",label = "Choose a number",
                                        value = 25,min = 1,max=200),
                          ),
                          mainPanel(plotOutput("plot")
                          )
                        ),
                        sidebarLayout(
                          sidebarPanel(
                            radioButtons("plotType2", "Plot type",
                                         c("Line"="l","Scatter"="p")
                            ),
                            sliderInput("num2",label = "Choose a number",
                                        value = 25,min = 1,max=200),
                          ),
                          mainPanel(plotOutput("plot2")
                          )
                        ),
                      ),
                    ),
           ),
           tabPanel("Deep dive into a city"),
           tabPanel("Documentation")
)