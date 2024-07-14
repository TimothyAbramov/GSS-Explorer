function(input, output, session) {

  #selectizeInput
  updateSelectizeInput(session, 'selectQuestionSingle', choices = gss_var_info$variable, server = TRUE)
  updateSelectizeInput(session, 'selectQuestionCompare1', choices = gss_var_info$variable, server = TRUE)
  updateSelectizeInput(session, 'selectQuestionCompare2', choices = gss_var_info$variable, server = TRUE)
  
  #tab1 viz
  output$singleQuestionPlot <- renderPlotly({
    plotSingleQuestion(input$selectQuestionSingle)
  })
  
  #tab2 viz
  output$compareQuestionPlot <- renderPlotly({
    plotQuestionComparison(input$selectQuestionCompare1, input$selectQuestionCompare2)
  })
  
  
}
