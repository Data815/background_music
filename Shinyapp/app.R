#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(ggplot2)
library(tidyverse)


urlfile<-"https://raw.githubusercontent.com/Data815/background_music/main/Input/music_dataset.csv"
dataset<-read.csv(url(urlfile))

ui <- fluidPage(
    titlePanel("Background Music"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("Rating", "Rating", 0, 5,c(2,4)),
            radioButtons("Test_Type", "Test Type",
                         choices = c("Music", "No Music"),
                         selected = "Music"),
            selectInput("Gender", "Gender",
                        choices = c("Male", "Female", "transexual"))
        ),
        mainPanel(
            plotOutput("coolplot"),
            br(), br(),
            tableOutput("results")
        )
    )
)

server <- function(input, output) {
    output$coolplot <- renderPlot({
        filtered <-
            dataset %>%
            filter(Rating >= input$Rating[1],
                   Rating <= input$Rating[2],
                   Test_Type == input$Test_Type,
                   Gender == input$Gender
            )
        ggplot(filtered, aes(Time_Sec)) +
            geom_histogram()
    })
}

shinyApp(ui = ui, server = server)