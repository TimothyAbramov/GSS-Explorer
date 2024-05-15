library(shinydashboard)
library(shiny)


dashboardPage(
  dashboardHeader(
    title = "GSS Explorer"
  ),
  
  dashboardSidebar(
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
            selectInput("selectQuestionSingle", "Select a question:", choices = c("Q1", "Q2", "Q3"))
          ),
          
          column(width = 8,
            plotlyOutput("singleQuestionPlot")
          )
          
        )
      ),#tab1
      
      tabItem(tabName = "compareQuestions",
        fluidRow(
          
          column(width = 6,
            selectInput("selectQuestionCompare1", "Select question A:", choices = c("Q1", "Q2", "Q3"))
          ),
          
          column(width = 6,
            selectInput("selectQuestionCompare2", "Select question B:", choices = c("Q1", "Q2", "Q3"))
          )
          
        ),
        fluidRow(
          
          plotlyOutput("compareQuestionPlot1"),
          
          plotlyOutput("compareQuestionPlot2")
          
        )
      ),#tab2
      
      tabItem(tabName = "about",
        HTML("Dashboard description here")
      )#tab3
      
    )#tabItems
    
  )#dashboardBody
  
)#dashboardPage
