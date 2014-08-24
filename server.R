library(shiny)
library(ggplot2)

colNames = c("Number of cylinders", 
             "Displacement (cu.in.)", 
             "Gross horsepower", 
             "Rear axle ratio" ,
             "Weight (lb/1000)", 
             "1/4 mile time", 
             "V/S", 
             "Number of forward gears", 
             "Number of carburetors")

varNames = c("cyl", "disp", "hp", "drat", "wt", "qsec", "vs", "gear", "carb")

shinyServer(function(input, output) {
  
  dataset <- reactive({
    d <- mtcars
    d$transmission <- factor(d$am, levels = c(0, 1), labels = c("Automatic", "Manual"))
    d
  })
  
  output$plot <- renderPlot({
    x <- with(dataset(), get(varNames[match(input$x, colNames)]))
    qplot(x = x, y = mpg, data = dataset(), geom = c("point", "smooth"), method = "lm", 
          formula = y ~ x, color = transmission, main = paste("Regression of MPG on", input$x), 
          xlab = input$x, 
          ylab = "Miles per Gallon")
  })

  # Generate an HTML table view of the data
  output$table <- renderTable({
    data.frame(x=dataset())
  })  
  
  # Generate a summary of the regresion model
  output$lm <- renderPrint({
    x <- with(dataset(), get(varNames[match(input$x, colNames)]))
    summary(lm(dataset()$mpg ~ x))
  })
  
  
})