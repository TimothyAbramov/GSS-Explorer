function(input, output, session) {

  #tab1, graph
  output$singleQuestionPlot <- renderPlotly({
    plotPlotlyGraph(input$selectQuestionSingle)
  })
  
  #tab2, graph1
  output$compareQuestionPlot1 <- renderPlotly({
    plotPlotlyGraph(input$selectQuestionCompare1)
  })
  
  #tab2, graph2
  output$compareQuestionPlot2 <- renderPlotly({
    plotPlotlyGraph(input$selectQuestionCompare2)
  })
}
