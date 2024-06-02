function(input, output, session) {
  #startup message
  show_alert(
    title = "Warning!",
    text = "You're entering a CONSTRUCTION site (pun intended). Work in PROGRESS, proceed with CAUTION!",
    type = "warning"
  )
  
  #our server outputs:
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
