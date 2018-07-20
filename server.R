library(shiny)

shinyServer(function(input,output){
  output$plot1 <- renderPlot({
    number <- input$numeric
    minX<-input$sliderX[1]
    maxX<-input$sliderX[2]
    minY<-input$sliderY[1]
    maxY<-input$sliderY[2]
    dataX<-runif(number,minX,maxX)
    dataY<-runif(number,minY,maxY)
    xlab<-ifelse(input$show_xlab,"X Axis","")
    ylab<-ifelse(input$show_ylab,"Y Axis","")
    plot(dataX,dataY,xlab=xlab,ylab=ylab,xlim=c(-100,100),ylim=c(-100,100))
  })
  
  mtcars$mpgsp<-ifelse(mtcars$mpg-20>0,mtcars$mpg-20,0)
  model1<-lm(hp~mpg,data=mtcars)
  model2<-lm(hp~mpgsp+mpg,data=mtcars)
  
  model1pred<-reactive({
    mpgInput<-input$sliderMPG
    predict(model1,newdata=data.frame(mpg=mpgInput))
  })
  
  model2pred<-reactive({
    mpgInput<-input$sliderMPG
    predict(model2,newdata=data.frame(mpg=mpgInput,mpgsp=ifelse(mpgInput-20>0,mpgInput-20,0)))
  })
  output$plot2<- renderPlot({
    mpgInput<-input$sliderMPG
    plot(mtcars$mpg,mtcars$hp,xlim=c(10,35),ylim=c(50,350),pch=16,bty="n")
    if(input$Model1){
      abline(model1,col="red")
    }
    if(input$Model2){
      model2lines<-predict(model2,newdata=data.frame(mpg=10:35,mpgsp=ifelse(10:35-20>0,10:35-20,0)))
      lines(10:35,model2lines,col="blue")
    }
    points(mpgInput,model1pred(),col="red")
    points(mpgInput,model2pred(),col="blue")
  })
  output$pred1<-renderText({
    model1pred()
  })
  output$pred2<-renderText({
    model2pred()
  })
})