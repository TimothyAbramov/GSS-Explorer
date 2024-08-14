navbarPage("GSS Explorer", theme = shinytheme("flatly"),
  
  tabPanel("Explore",
    
    fluidRow(
     
      column(width = 3,
             
        selectizeInput("selectGSSYear", "year",
                       choices = c(1972, 1973, 1974, 1975, 1976, 1977, 1978, 1980,
                                   1982, 1983, 1984, 1985, 1986, 1987, 1988, 1989,
                                   1990, 1991, 1993, 1994, 1996, 1998, 2000, 2002,
                                   2004, 2006, 2008, 2010, 2012, 2014, 2016, 2018,
                                   2021, 2022),
                       selected = 2022,
                       width = '100%'),
        
        selectizeInput("selectQuestionSingle", "question / label / variable",
                    choices = NULL,
                    options = list(placeholder = "search here",
                                   onInitialize = I('function() { this.setValue(""); }')),
                    width = '100%'),
        
        #categorical controls
        conditionalPanel(condition = "output.varType == 'categorical'",
                         
          radioGroupButtons("sortDirectionCategorical", "sort:", 
                            choices = c("none", "descending", "ascending"), 
                            status = "default"),
          
          radioGroupButtons("orientationCategorical", "orientation:", 
                            choices = c("vertical", "horizontal"), 
                            status = "default"),
          
          
        ), #end conditional panel for categorical
        
        
        #quantitative controls
        conditionalPanel(condition = "output.varType == 'quantitative'",
        
          radioGroupButtons("binsConfigQuantitative", "number of bins:", 
                             choices = c("auto", "manual"), 
                             status = "default"),                 
          conditionalPanel(condition = "input.binsConfigQuantitative == 'manual'",
            numericInput("binsQuantitative", "bins:",
                         value = 5, min = 1, max = 150)
          )                 
                         
        ), #end conditional panel for quantitative
        
        radioGroupButtons("metricRadio", "metric:", 
                          choices = c("percentage", "count"), 
                          status = "default")
        
     ),
     
     column(width = 9,
        tabsetPanel(type = "tabs",
                    
            tabPanel("Visuals",
            withSpinner(
              plotlyOutput("singleQuestionPlot", height = "80vh")
            )),
            
            tabPanel("Var Info",
                     verbatimTextOutput("singleQuestionInfo")),
            
            tabPanel("Viz Data",
                     tableOutput("singleQuestionData"))
            
        )#tabsetPanel
            
     ) #output/viz column
     
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
    tabsetPanel(type = "pills",
      tabPanel("GSS",
               HTML("<p>The <b>General Social Survey (GSS)</b> is a wide-ranging survey conducted regularly in the <b>United States</b>, aiming to understand and track societal trends and attitudes. Covering topics from politics and religion to demographics and well-being, the GSS provides valuable insights into the changing fabric of American society. By asking a diverse range of questions to a representative sample of the population, the survey captures nuanced shifts in <b>beliefs, behaviors, and opinions</b> over time, making it a vital tool for <b>sociologists, policymakers, and researchers</b> alike.</p><br><p>Focusing on <b>2022 GSS data</b>, this dashboard serves as a powerful tool for uncovering insights into the social landscape of America. By visually presenting key metrics derived from the survey, it allows users to explore <b>correlations, patterns, and anomalies</b> within the data. Whether examining <b>demographic shifts, political affiliations, or societal attitudes</b>, dashboard provides a dynamic platform for gaining a deeper understanding of the complexities shaping American society.</p>")
               ), #gss tab
      tabPanel("User Guide"),
      tabPanel("Author")
    )
    
  ) #tabpanel3 About

) #navbarPage
  
  
