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
    print("Original selection:")
    str(plotData)
    
    #initialize graph var
    graph <- NULL
    
    #type of plot depending on the question selected
    #if categorical
    if(input$selectQuestionSingle %in% c("wrkstat", "wrkslf")){
      plotData[[input$selectQuestionSingle]] <- to_factor(plotData[[input$selectQuestionSingle]])
      print("Data adjusted for categorical:")
      str(plotData)
      
      graph <- ggplot(plotData, aes(.data[[input$selectQuestionSingle]])) + 
        geom_bar() + #bar plot
        theme(panel.grid.major.x = element_blank(),
              panel.grid.minor.x = element_blank()) +
        aes(stringr::str_wrap(.data[[input$selectQuestionSingle]], 15)) +
        labs(x = "")
    }
    #if quantitative
    else if (input$selectQuestionSingle %in% c("hrs1", "sibs")){
      plotData[[input$selectQuestionSingle]] <- as.numeric(plotData[[input$selectQuestionSingle]]) #error somewhere here
      print("Data adjusted for quantitative")
      str(plotData[[input$selectQuestionSingle]])
      
      graph <- ggplot(plotData, aes_(x = plotData[[input$selectQuestionSingle]])) + 
        geom_histogram() #histogram
    }
    
    #other visual adjustments, applicable to all graphs
    graph <- graph + 
      labs(title = paste(toupper(input$selectQuestionSingle), " Distribution")) +
      theme(plot.title = element_text(size = 12, hjust = 0.5, face = "bold"))
    
    #our final output
    graph
  })
  
  output$compareQuestionPlot1 <- renderPlot({
    
    #get the data for the selected question
    plotData <- data.frame(gss22[[input$selectQuestionCompare1]]) 
    names(plotData) <- input$selectQuestionCompare1
    print("Original selection:")
    str(plotData)
    
    #initialize graph var
    graph <- NULL
    
    #type of plot depending on the question selected
    #if categorical
    if(input$selectQuestionCompare1 %in% c("wrkstat", "wrkslf")){
      plotData[[input$selectQuestionCompare1]] <- to_factor(plotData[[input$selectQuestionCompare1]])
      print("Data adjusted for categorical:")
      str(plotData)
      
      graph <- ggplot(plotData, aes(.data[[input$selectQuestionCompare1]])) + 
        geom_bar() + #bar plot
        theme(panel.grid.major.x = element_blank(),
              panel.grid.minor.x = element_blank()) +
        aes(stringr::str_wrap(.data[[input$selectQuestionCompare1]], 15)) +
        labs(x = "")
    }
    #if quantitative
    else if (input$selectQuestionCompare1 %in% c("hrs1", "sibs")){
      plotData[[input$selectQuestionCompare1]] <- as.numeric(plotData[[input$selectQuestionCompare1]]) #error somewhere here
      print("Data adjusted for quantitative")
      str(plotData[[input$selectQuestionCompare1]])
      
      graph <- ggplot(plotData, aes_(x = plotData[[input$selectQuestionCompare1]])) + 
        geom_histogram() #histogram
    }
    
    #other visual adjustments, applicable to all graphs
    graph <- graph + 
      labs(title = paste(toupper(input$selectQuestionCompare1), " Distribution")) +
      theme(plot.title = element_text(size = 12, hjust = 0.5, face = "bold"))
    
    #our final output
    graph
  })
  
  output$compareQuestionPlot2 <- renderPlot({
    
    #get the data for the selected question
    plotData <- data.frame(gss22[[input$selectQuestionCompare2]]) 
    names(plotData) <- input$selectQuestionCompare2
    print("Original selection:")
    str(plotData)
    
    #initialize graph var
    graph <- NULL
    
    #type of plot depending on the question selected
    #if categorical
    if(input$selectQuestionCompare2 %in% c("wrkstat", "wrkslf")){
      plotData[[input$selectQuestionCompare2]] <- to_factor(plotData[[input$selectQuestionCompare2]])
      print("Data adjusted for categorical:")
      str(plotData)
      
      graph <- ggplot(plotData, aes(.data[[input$selectQuestionCompare2]])) + 
        geom_bar() + #bar plot
        theme(panel.grid.major.x = element_blank(),
              panel.grid.minor.x = element_blank()) +
        aes(stringr::str_wrap(.data[[input$selectQuestionCompare2]], 15)) +
        labs(x = "")
    }
    #if quantitative
    else if (input$selectQuestionCompare2 %in% c("hrs1", "sibs")){
      plotData[[input$selectQuestionCompare2]] <- as.numeric(plotData[[input$selectQuestionCompare2]]) #error somewhere here
      print("Data adjusted for quantitative")
      str(plotData[[input$selectQuestionCompare2]])
      
      graph <- ggplot(plotData, aes_(x = plotData[[input$selectQuestionCompare2]])) + 
        geom_histogram() #histogram
    }
    
    #other visual adjustments, applicable to all graphs
    graph <- graph + 
      labs(title = paste(toupper(input$selectQuestionCompare2), " Distribution")) +
      theme(plot.title = element_text(size = 12, hjust = 0.5, face = "bold"))
    
    #our final output
    graph
  })
}
