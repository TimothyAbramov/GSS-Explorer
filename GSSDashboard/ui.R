dashboardPage(
  dashboardHeader(
    title = "GSS Explorer (2022)",
    titleWidth = 300
  ),
  
  dashboardSidebar(
    collapsed = FALSE,
    width = 200,
    sidebarMenu(
      menuItem("Explore Questions", tabName = "exploreQuestions"),
      menuItem("Compare Questions", tabName = "compareQuestions"),
      menuItem("About", tabName = "about")
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "exploreQuestions",
        fluidRow(
          
          column(width = 4,
            selectInput("selectQuestionSingle", "Select a question:", 
                        c("labor force status" = "wrkstat",
                          "r self-emp or works for somebody" = "wrkslf",
                          "number of hours worked last week" = "hrs1",
                          "number of brothers and sisters" = "sibs"))
          ),
          
          column(width = 8,
            plotOutput("singleQuestionPlot")
          )
          
        )
      ),#tab1
      
      tabItem(tabName = "compareQuestions",
        fluidRow(
          
          column(width = 6,
            selectInput("selectQuestionCompare1", "Select question A:",
                        c("labor force status" = "wrkstat",
                          "r self-emp or works for somebody" = "wrkslf",
                          "number of hours worked last week" = "hrs1",
                          "number of brothers and sisters" = "sibs"))
          ),
          
          column(width = 6,
            selectInput("selectQuestionCompare2", "Select question B:",
                        c("labor force status" = "wrkstat",
                          "r self-emp or works for somebody" = "wrkslf",
                          "number of hours worked last week" = "hrs1",
                          "number of brothers and sisters" = "sibs"))
          )
          
        ),
        
        fluidRow(
          
          column(width = 6,
            plotOutput("compareQuestionPlot1")
          ),
          
          column(width = 6,
            plotOutput("compareQuestionPlot2")
          )
          
        )
      ),#tab2
      
      tabItem(tabName = "about",
        HTML("<p>The <b>General Social Survey (GSS)</b> is a wide-ranging survey conducted regularly in the <b>United States</b>, aiming to understand and track societal trends and attitudes. Covering topics from politics and religion to demographics and well-being, the GSS provides valuable insights into the changing fabric of American society. By asking a diverse range of questions to a representative sample of the population, the survey captures nuanced shifts in <b>beliefs, behaviors, and opinions</b> over time, making it a vital tool for <b>sociologists, policymakers, and researchers</b> alike.</p><br><p>Focusing on <b>2022 GSS data</b>, this dashboard serves as a powerful tool for uncovering insights into the social landscape of America. By visually presenting key metrics derived from the survey, it allows users to explore <b>correlations, patterns, and anomalies</b> within the data. Whether examining <b>demographic shifts, political affiliations, or societal attitudes</b>, dashboard provides a dynamic platform for gaining a deeper understanding of the complexities shaping American society.</p>")
      )#tab3
      
    )#tabItems
    
  )#dashboardBody
  
)#dashboardPage
