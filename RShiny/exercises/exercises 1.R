#Create an app that greets the user by name. You don’t know all the functions you need to do this
#yet, so I’ve included some lines of code below. Think about which lines you’ll use and then copy
#and paste them into the right place in a Shiny app.
library(shiny)
library(dplyr)

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting"))

server <- function(input, output, session) {
  output$greeting <- renderText({
    paste0("Hello ", input$name)
})
}
shinyApp(ui, server)

#Suppose your friend wants to design an app that allows the user to set a number ( x ) between 1
#and 50, and displays the result of multiplying this number by 5. This is their first attempt:
ui <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  "then x times 5 is",
  textOutput("product")
)

server <- function(input, output, session) {
  output$product <- renderText({
    input$x * 5
  })
}
shinyApp(ui, server)

#Extend the app from the previous exercise to allow the user to set the value of the multiplier, y , so
#that the app yields the value of x * y . The final result should look like this:
ui <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", label = "and y is", min = 1, max = 50, value = 30),
  "then x times y is",
  textOutput("product")
)

server <- function(input, output, session) {
  output$product <- renderText({
    input$x * input$y
  })
}
shinyApp(ui, server)

#Take the following app which adds some additional functionality to the last app described in the
#last exercise. What’s new? How could you reduce the amount of duplicated code in the app by
#using a reactive expression.

ui <- fluidPage(
  sliderInput("x", "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", "and y is", min = 1, max = 50, value = 5),
  "then, (x * y) is", textOutput("product"),
  "and, (x * y) + 5 is", textOutput("product_plus5"),
  "and (x * y) + 10 is", textOutput("product_plus10")
)
server <- function(input, output, session) {
  product <- reactive({
    input$x * input$y
  })
  output$product <- renderText({
    product()
  })
  output$product_plus5 <- renderText({
    product()+5
  })
  output$product_plus10 <- renderText({
    product()+10
  })
}
shinyApp(ui, server)

#Consider the following app. You select a dataset from a package (this time we’re using the ggplot2
#package) and the app prints out a summary and plot of the data. It also follows good practice and
#makes use of reactive expressions to avoid redundancy of code. However there are three bugs in
#the code provided below. Can you find and fix them?

library(ggplot2)
datasets <- c("economics", "faithfuld", "seals")
ui <- fluidPage(
  selectInput("dataset", "Dataset", choices = datasets),
  verbatimTextOutput("summary"),
  plotOutput("plot")
)
server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:ggplot2")
  })
  output$summary <- renderPrint({
    summary(dataset())
  })
  output$plot <- renderPlot({
    plot(dataset())
  }, res = 96)
}
shinyApp(ui, server)

#When space is at a premium, it’s useful to label text boxes using a placeholder that appears inside
#the text entry area. How do you call textInput() to generate the UI below?
textInput("name", "Your name", placeholder = "Your name")

#Carefully read the documentation for sliderInput() to figure out how to create a date slider, as
#shown below.
dateRangeInput("date", "Select date", from = "2020-09-01", to = "2020-09-22")

#Create a slider input to select values between 0 and 100 where the interval between each
#selectable value on the slider is 5. Then, add animation to the input widget so when the user
#presses play the input widget scrolls through the range automatically.

ui <- fluidPage(
  sliderInput("value", label = "Select values", min = 0, max = 100, value = 5, step = 5, animate = T),
  textOutput('value')
)
server <- function(input, output, session) {
  output$value <- renderText({
    input$value
  })
}
shinyApp(ui, server)

#Re-create the Shiny app below, setting height and width of the plot to 300px and 700px
#respectively. Set the plot “alt” text so that a visually impaired user can tell that its a scatterplot of
#five random numbers.
dataset <- c(1:5)
ui <- fluidPage(
  plotOutput('plot')
)
server <- function(input, output, session) {
  output$plot <- renderPlot({
    plot(1:5)
  })
}
shinyApp(ui, server)













