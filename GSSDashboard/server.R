function(input, output, session) {

  #tab1
  output$singleQuestionPlot <- renderPlotly({
    plotSingleQuestion(input$selectQuestionSingle)
  })
  
  #tab2
  output$compareQuestionPlot <- renderPlotly({
    plotQuestionComparison(input$selectQuestionCompare1, input$selectQuestionCompare2)
  })
  
  
}
