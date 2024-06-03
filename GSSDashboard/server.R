function(input, output, session) {

  #tab1
  output$singleQuestionPlot <- renderPlotly({
    plotPlotlyGraph(input$selectQuestionSingle)
  })
  
  #tab2
  output$compareQuestionPlot <- renderPlotly({
    plotPlotlyGraph(input$selectQuestionCompare1)
  })
  
  
}
