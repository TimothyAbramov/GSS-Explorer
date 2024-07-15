navbarPage("GSS Explorer", theme = shinytheme("flatly"),
  
  tabPanel("Explore",
    
    fluidRow(
     
      column(width = 3,
             
        selectizeInput("selectQuestionSingle", "question / label / variable",
                    choices = NULL,
                    options = list(placeholder = "search here",
                                   onInitialize = I('function() { this.setValue(""); }')),
                    width = '100%'),
        
        #sorting switches
        # conditionalPanel(
        #   condition = "categorical_vars.includes(input.selectQuestionSingle)", #TODO conditional hide/unhide of the buttons
        #   fluidRow(
        #     
        #     column(width = 4, align = "left",
        #            switchInput("sortSwitch", label = "sort")
        #            ),
        #     
        #     column(width = 8, align = "right",
        #            switchInput("sortSwitch", 
        #                        onLabel = "ascending", offLabel = "descending",
        #                        onStatus = "default")
        #     )
        #     
        #   )#sorting fluidRow
        # )
        
        
        
     ),
     
     column(width = 9,
        withSpinner(
          plotlyOutput("singleQuestionPlot", height = "85vh")
        )
     )
     
    )  #fluidrow       
  
  ), #tabpanel1 Explore
  
  
  
  tabPanel("Compare",
    
  fluidRow(
     
    column(width = 3,
           
           selectizeInput("selectQuestionCompare1", "Select question A:",
                      choices = NULL,
                      options = list(placeholder = "Question A",
                                     onInitialize = I('function() { this.setValue(""); }'))
                      ),
           
           selectizeInput("selectQuestionCompare2", "Select question B:",
                       choices = NULL,
                       options = list(placeholder = "Question B",
                                      onInitialize = I('function() { this.setValue(""); }'))
                       )
     ),
     
     column(width = 9,
        withSpinner(
          plotOutput("compareQuestionPlot", height = "80vh")
        )
     )
     
    ) #fluidrow     
           
  ), #tabpanel2 Compare
  
  
  tabPanel("About",
    HTML("<p>The <b>General Social Survey (GSS)</b> is a wide-ranging survey conducted regularly in the <b>United States</b>, aiming to understand and track societal trends and attitudes. Covering topics from politics and religion to demographics and well-being, the GSS provides valuable insights into the changing fabric of American society. By asking a diverse range of questions to a representative sample of the population, the survey captures nuanced shifts in <b>beliefs, behaviors, and opinions</b> over time, making it a vital tool for <b>sociologists, policymakers, and researchers</b> alike.</p><br><p>Focusing on <b>2022 GSS data</b>, this dashboard serves as a powerful tool for uncovering insights into the social landscape of America. By visually presenting key metrics derived from the survey, it allows users to explore <b>correlations, patterns, and anomalies</b> within the data. Whether examining <b>demographic shifts, political affiliations, or societal attitudes</b>, dashboard provides a dynamic platform for gaining a deeper understanding of the complexities shaping American society.</p>")
  ) #tabpanel3 About

) #navbarPage
  
  
