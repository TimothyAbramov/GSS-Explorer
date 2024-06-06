navbarPage("GSS Explorer (2022)", theme = shinytheme("flatly"),
  
  tabPanel("Explore",
    
    fluidRow(
     
      column(width = 4,
        selectInput("selectQuestionSingle", "Select a question:",
                    c("labor force status" = "wrkstat",
                      "r self-emp or works for somebody" = "wrkslf",
                      "highest degree finished" = "degree",
                      "what race do you consider yourself" = "race",
                      "number of hours worked last week" = "hrs1",
                      "number of brothers and sisters" = "sibs",
                      "household size and composition" = "hompop",
                      "members under 6 years of age" = "babies"))
     ),
     
     column(width = 8,
        plotlyOutput("singleQuestionPlot", height = "85vh")
     )
     
    )  #fluidrow       
  
  ), #tabpanel1 Explore
  
  
  
  tabPanel("Compare",
    
  fluidRow(
     
    column(width = 4,
           
           selectInput("selectQuestionCompare1", "Select question A:",
                      c("labor force status" = "wrkstat",
                        "r self-emp or works for somebody" = "wrkslf",
                        "highest degree finished" = "degree",
                        "what race do you consider yourself" = "race",
                        "number of hours worked last week" = "hrs1",
                        "number of brothers and sisters" = "sibs",
                        "household size and composition" = "hompop",
                        "members under 6 years of age" = "babies"
                      )),
           
           selectInput("selectQuestionCompare2", "Select question B:",
                       c("labor force status" = "wrkstat",
                         "r self-emp or works for somebody" = "wrkslf",
                         "highest degree finished" = "degree",
                         "what race do you consider yourself" = "race",
                         "number of hours worked last week" = "hrs1",
                         "number of brothers and sisters" = "sibs",
                         "household size and composition" = "hompop",
                         "members under 6 years of age" = "babies"
                       ))
     ),
     
     column(width = 8,
        plotOutput("compareQuestionPlot", height = "80vh")   
     )
     
    ) #fluidrow     
           
  ), #tabpanel2 Compare
  
  
  tabPanel("About",
    HTML("<p>The <b>General Social Survey (GSS)</b> is a wide-ranging survey conducted regularly in the <b>United States</b>, aiming to understand and track societal trends and attitudes. Covering topics from politics and religion to demographics and well-being, the GSS provides valuable insights into the changing fabric of American society. By asking a diverse range of questions to a representative sample of the population, the survey captures nuanced shifts in <b>beliefs, behaviors, and opinions</b> over time, making it a vital tool for <b>sociologists, policymakers, and researchers</b> alike.</p><br><p>Focusing on <b>2022 GSS data</b>, this dashboard serves as a powerful tool for uncovering insights into the social landscape of America. By visually presenting key metrics derived from the survey, it allows users to explore <b>correlations, patterns, and anomalies</b> within the data. Whether examining <b>demographic shifts, political affiliations, or societal attitudes</b>, dashboard provides a dynamic platform for gaining a deeper understanding of the complexities shaping American society.</p>")
  ) #tabpanel3 About

) #navbarPage
  
  
