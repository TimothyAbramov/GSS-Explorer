function(input, output, session) {
  #startup message
  show_alert(
    title = "Warning!",
    text = "You're entering a CONSTRUCTION site (pun intended). Work in PROGRESS, proceed with CAUTION!",
    type = "warning"
  )
  
  #our server outputs:
  #tab1, graph
  output$singleQuestionPlot <- renderPlot({
    plotGraph(input$selectQuestionSingle)
  })
  
  #tab2, graph1
  output$compareQuestionPlot1 <- renderPlot({
    plotGraph(input$selectQuestionCompare1)
  })
  
  #tab2, graph2
  output$compareQuestionPlot2 <- renderPlot({
    plotGraph(input$selectQuestionCompare2)
  })
}
