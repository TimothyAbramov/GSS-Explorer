function(input, output, session) {

  #selectizeInput
  updateSelectizeInput(session, 'selectQuestionSingle', choices = gss22_vars, server = TRUE)
  updateSelectizeInput(session, 'selectQuestionCompare1', choices = gss22_vars, server = TRUE)
  updateSelectizeInput(session, 'selectQuestionCompare2', choices = gss22_vars, server = TRUE)
  
  #tab1 viz
  output$singleQuestionPlot <- renderPlotly({
    plotSingleQuestion(input$selectQuestionSingle)
  })
  
  #tab2 viz
  output$compareQuestionPlot <- renderPlotly({
    plotQuestionComparison(input$selectQuestionCompare1, input$selectQuestionCompare2)
  })
  
  
}
