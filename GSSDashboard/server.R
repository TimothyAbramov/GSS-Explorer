function(input, output, session) {

  #var category (reactive output that is only on server,
  #              used in javascript condition on the ui side)
  output$varType <- reactive({
    if(input$selectQuestionSingle %in% categorical_vars){
      return("categorical")
    }
    else{
      return("quantitative")
    }
  })
  outputOptions(output, "varType", suspendWhenHidden = FALSE)
  
  
  
  #handling year selection
  observeEvent(input$selectGSSYear, {
    #update gss data 
    gss_data <- gss_get_yr(input$selectGSSYear)
    
    #update the selectize choices:
    gss_var_info <- gss_dict %>% #variable, label, and var_text from gss_dict for gssYear
      select(variable, label, var_text, years) %>%
      na.omit() %>%
      mutate(label = unname(label)) %>%
      unnest(years) %>%
      filter(year == as.numeric(input$selectGSSYear), present == TRUE) %>%
      inner_join(gss_var_types, by = "variable") %>% #filter vars to only those that I have a type for
      filter(status == "done") %>%
      select(variable, label = label.x, text = var_text.x, type, subtype)
    gss_var_info <- data.frame(gss_var_info)
    
    #updating the ui part
    updateSelectizeInput(session, 'selectQuestionSingle',
                         choices = gss_var_info$variable,
                         server = TRUE)
    
    #print updated list of vars
    print(dim(gss_var_info)) 
  })
  
  
  
  #updating var/label/question choices dynamically
  updateSelectizeInput(session, 'selectQuestionSingle',
                       choices = gss_var_info$variable,
                       server = TRUE)
  updateSelectizeInput(session, 'selectQuestionCompare1', 
                       choices = gss_var_info$variable, server = TRUE)
  updateSelectizeInput(session, 'selectQuestionCompare2', 
                       choices = gss_var_info$variable, server = TRUE)
  
  
  
  #explore tab viz
  output$singleQuestionPlot <- renderPlotly({
    plotSingleQuestion(input$selectQuestionSingle, input$selectGSSYear,
                       input$sortDirectionCategorical, input$orientationCategorical,
                       input$categoryCountCategorical, input$topNCategorical,
                       input$binsConfigQuantitative, input$binsQuantitative)
  })
  
  
  
  #compare tab viz
  output$compareQuestionPlot <- renderPlotly({
    plotQuestionComparison(input$selectQuestionCompare1, input$selectQuestionCompare2)
  })
  
  
}
