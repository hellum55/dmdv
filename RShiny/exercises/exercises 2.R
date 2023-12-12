#Update the options for renderDataTable() below so that the table is displayed, but nothing else
#(i.e. remove the search, ordering, and filtering commands).
library(ggplot2)
library(shiny)
library(ISLR2)
ui <- fluidPage(
  dataTableOutput("table")
)
server <- function(input, output, session) {
  output$table <- renderDataTable(mtcars, options = list(ordering = FALSE, searching = FALSE))
}
shinyApp(ui, server)

#Modify the Central Limit Theorem app below so that the sidebar is on the right instead of the left.
ui <- fluidPage(
  titlePanel("Central limit theorem"),
  sidebarLayout(
    sidebarPanel(
      numericInput("m", "Number of samples:", 2, min = 1, max = 100)
    ),
    mainPanel(
      plotOutput("hist")
    ), position = c("right")
  )
)
server <- function(input, output, session) {
  output$hist <- renderPlot({
    means <- replicate(1e4, mean(runif(input$m)))
    hist(means, breaks = 20)
  }, res = 96)
}
shinyApp(ui, server)

#Browse the themes available in the shinythemes package, pick an attractive theme, and apply it to
#the Central Limit Theorem app.
library(shinythemes)
ui <- fluidPage(
  titlePanel("Central limit theorem"),
  theme = shinythemes::shinytheme("superhero"),
  sidebarLayout(
    sidebarPanel(
      numericInput("m", "Number of samples:", 2, min = 1, max = 100)
    ),
    mainPanel(
      plotOutput("hist")
    ), position = c("right")
  )
)
server <- function(input, output, session) {
  output$hist <- renderPlot({
    means <- replicate(1e4, mean(runif(input$m)))
    hist(means, breaks = 20)
  }, res = 96)
}
shinyApp(ui, server)

#Create an app that contains two plots, each of which takes up half the app (regardless of what size
#the whole app is)
ui <- fluidPage(
  titlePanel("two plots"),
        column(width = 6, plotOutput("plot")),
        column(width = 6, plotOutput("hist"))
)
server <- function(input, output, session) {
    output$plot <- renderPlot({
      plot(1:5)
    })
    output$hist <- renderPlot({
      plot(1:10)
    })
  }
shinyApp(ui, server)

#Make a plot with click handle that shows all the data returned in the input.
ui <- fluidPage(
  plotOutput("plot", click = "plot_click"),
  tableOutput("data")
)
server <- function(input, output, session) {
  output$plot <- renderPlot({
    plot(mtcars$mpg, mtcars$cyl)
  })
  output$data <- renderTable({
    nearPoints(mtcars, input$plot_click, xvar = "mpg", yvar = "cyl")
  })
}

shinyApp(ui, server)

#Make a plot with click, dblclick, hover, and brush output handlers and nicely display the current
#selection in the sidebar. Plot the plot in the main panel.
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      plotOutput("plot", click = "plot_click", brush = "plot_brush", dblclick = "plot_reset", hover = "hover"),
      tableOutput("data")
    )
  )
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    ggplot(mtcars, aes(mpg, wt)) + geom_point()
  }, res = 96)
  
  output$data <- renderTable({
    nearPoints(mtcars, input$plot_click, xvar = "mpg", yvar = "cyl")
    brushedPoints(mtcars, input$plot_brush)
  })
}

shinyApp(ui, server)

#Create an app that lets you upload a csv file, select a variable, and then perform a t.test() on
#that variable. After the user has uploaded the csv file, you'll need to use updateSelectInput() to
#fill in the available variables. See Section 10.1 for details.

ui <- fluidPage(
  fileInput("upload", NULL, accept = c(".csv", ".tsv")),
  numericInput("n", "Rows", value = 5, min = 1, step = 1),
  tableOutput("head")
)

server <- function(input, output, session) {
  data <- reactive({
    req(input$upload)
    
    ext <- tools::file_ext(input$upload$name)
    switch(ext,
           csv = vroom::vroom(input$upload$datapath, delim = ","),
           tsv = vroom::vroom(input$upload$datapath, delim = "\t"),
           validate("Invalid file; Please upload a .csv or .tsv file")
    )
  })
  
  output$head <- renderTable({
    head(data(), input$n)
  })
}














