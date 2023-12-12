df <- read.csv("~/dmdv2023/RShiny/titanic case/titanic_case.csv")
#1. Correlations: a page where the user can correlate relevant variables of the dataset. 
#The user should be able to select multiple variables from a dropdown.
library(shiny)
library(shinythemes)
library(dplyr)
library(PerformanceAnalytics)
library(ggplot2)
variable_lst = c("Survived","Pclass", "Male", "Age", "SibSp", "Parch", "Fare")
categorical_lst = c("Survived","Pclass", "Male", "SibSp", "Parch")
continues_lst = c( "Age", "Fare", "SurvivalP")


ui <- navbarPage(
  "Analyzing Titanic",
    tabPanel("Correlations", 
             sidebarLayout(
               sidebarPanel(
                 selectInput("variables", label = "Select variables:", variable_lst, multiple = TRUE)),
               mainPanel(plotOutput("plot")))),
    tabPanel("Plots",
             sidebarLayout(
               sidebarPanel(
               selectInput("x", label = "Select x variable:", continues_lst),
               selectInput("y", label = "Select y variable", continues_lst),
               selectInput("color", label = "Select color variable", categorical_lst),
               selectInput("facet", label = "Select facet variable", categorical_lst)),
               mainPanel(plotOutput("scatter")))),
    tabPanel("View Data",
           dataTableOutput("table")))

server <- function(input, output, session) {
  correlate <- reactive({
    req(length(input$variables) > 1)
    corrdata <- df[, input$variables]
  })
  
  output$plot <- renderPlot(
    chart.Correlation(correlate(), histogram = TRUE, pch = 19)
  )
  output$scatter <- renderPlot(ggplot(data = df,           
                      mapping = aes(
                      x = .data[[input$x]],
                      y = .data[[input$y]],
                      color = .data[[input$color]])) + 
                      geom_point() + 
                      facet_wrap(.data[[input$facet]] ~ .) 
  )
  output$table <- renderDataTable(df, options = list(pagelength = 10))
}
shinyApp(ui, server)









