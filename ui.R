library(shiny)
library(ggplot2)

dataset <- mtcars
dataset$transmission <- factor(dataset$am, levels = c(0, 1), labels = c("Automatic", "Manual"))

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


shinyUI(pageWithSidebar(
  
  headerPanel("Motor Trend Car Road Tests Explorer"),
  
  sidebarPanel(
    helpText("This app explores the data extracted from the 1974 Motor Trend US magazine and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models). Specifically it allows you to experiment with dependency of fuel efficiency from other variables, grouping the data by car transmission type. Besides plotting the data points it also fits a regression line and allows to see linear regression model parameters. Start by selecting variable below:"),
    selectInput('x', 'MPG relation with', colNames)
  ),

  # Show a tabset that includes a plot and table view
  mainPanel(
    tabsetPanel(type = "tabs", 
                tabPanel("Plot", plotOutput("plot")), 
                tabPanel("Linear model", verbatimTextOutput("lm")), 
                tabPanel("Table", tableOutput("table"))
    )
  )
))