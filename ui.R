library(shiny)

shinyUI(fluidPage(
  titlePanel("Project"),
  sidebarLayout(
    sidebarPanel(
      h2("Plot a certain number of dots"),
      numericInput("numeric","Input",value=1000,min=1,max=1000),
      sliderInput("sliderX","Slide",-100,100,value=c(-50,50)),
      sliderInput("sliderY","Slide",-100,100,value=c(-50,50)),
      checkboxInput("show_xlab","Show X Axis",value=TRUE),
      checkboxInput("show_ylab","Show Y Axis",value=TRUE),
      h2("Plot Regression Line"),
      sliderInput("sliderMPG","MPG number",10,35,value=20),
      checkboxInput("Model1","Show Model 1",value=TRUE),
      checkboxInput("Model2","Show Model 2",value=TRUE)
    ),
    
    mainPanel(
      plotOutput("plot1"),
      plotOutput("plot2"),
      textOutput("pred1"),
      textOutput("pred2")
              )
  )
))
