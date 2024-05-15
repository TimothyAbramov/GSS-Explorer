function(input, output, session) {
  #startup message
  show_alert(
    title = "Warning!",
    text = "You're entering a CONSTRUCTION site (pun intended). Work in PROGRESS, proceed with CAUTION!",
    type = "warning"
  )
  
  #our server outputs
  output$singleQuestionPlot <- renderPlot({
    
    #get the data for the selected question
    plotData <- data.frame(gss22[[input$selectQuestionSingle]]) 
    names(plotData) <- input$selectQuestionSingle
    str(plotData)
    
    #initialize graph var
    graph <- NULL
    
    #type of plot depending on the question selected
    #if categorical
    if(input$selectQuestionSingle %in% c("wrkstat", "wrkslf")){
      plotData[[input$selectQuestionSingle]] <- factor(plotData[[input$selectQuestionSingle]])
      str(plotData)
      
      graph <- ggplot(plotData, aes(.data[[input$selectQuestionSingle]]))
      graph <- graph + geom_bar() #bar plot
    }
    #if quantitative
    else if (input$selectQuestionSingle %in% c("hrs1", "sibs")){
      plotData[[input$selectQuestionSingle]] <- double(plotData[[input$selectQuestionSingle]])
      str(plotData)
      
      graph <- ggplot(plotData, aes_(x = .data[[input$selectQuestionSingle]]))
      graph <- graph + geom_histogram() #histogram
    }
    
    
    #our output
    graph
  })
  
  output$compareQuestionPlot1 <- renderPlot({
    
  })
  
  output$compareQuestionPlot2 <- renderPlot({
    
  })
}
