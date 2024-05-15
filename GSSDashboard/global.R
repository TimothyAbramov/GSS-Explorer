#dashboard url:
#https://timothyabramov.shinyapps.io/GSS2022Dashboard/

#library(gssr)
#library(gssrdoc)
library(readstata13)
library(shinydashboard)
library(shiny)
library(shinyWidgets)
library(tidyverse)
library(labelled)

#getting the data in
#gss22 <- gss_get_yr(2022)
gss22 <- read.dta13("GSS2022.dta")

#see how to figure out what kind of question it is
# labels <- attr(gss22$wrkstat, "labels")
# str(labels)
# labels_names<- attr(labels, "names")

#selected questions to start off the thing:
#wrkstat (categorical, k>2) Last week were you working full time, part time, going to school, keeping house, or what?
#label: labor force status
str(gss22$wrkstat) #dbl + lbl
#wrkslf (categorical, k = 2) (Are/were) you self employed or (do/did) you work for someone else?
#label: r self-emp or works for somebody
str(gss22$wrkslf) #dbl + lbl

#hrs1 (quantitative) If working, full or part time: how many hours did you work last week, at all jobs?
#label: number of hours worked last week
str(gss22$hrs1) #dbl+lbl
#sibs (quantitative) How many brothers and sisters did you have? Please count those born alive, but no longer living, as well as those alive now. Also include stepbrothers and stepsisters, and children adopted by your parents.
#label: number of brothers and sisters
str(gss22$sibs) #dbl+lbl



#function to plot graphs
plotGraph <- function(varName){
  #get the data for the selected question
  plotData <- data.frame(gss22[[varName]]) 
  names(plotData) <- varName
  print("Original selection:")
  str(plotData)
  
  #initialize graph var
  graph <- NULL
  
  #type of plot depending on the question selected
  #if categorical
  if(varName %in% c("wrkstat", "wrkslf", "degree", "race")){
    plotData[[varName]] <- to_factor(plotData[[varName]])
    print("Data adjusted for categorical:")
    str(plotData)
    
    graph <- ggplot(plotData, aes(.data[[varName]])) + 
      geom_bar(aes(y = (..count..)/sum(..count..)*100)) + #bar plot
      theme(panel.grid.major.x = element_blank(),
            panel.grid.minor.x = element_blank()) +
      aes(stringr::str_wrap(.data[[varName]], 15)) +
      labs(x = "")
  }
  #if quantitative
  else{
    plotData[[varName]] <- as.numeric(plotData[[varName]]) #error somewhere here
    print("Data adjusted for quantitative")
    str(plotData[[varName]])
    
    graph <- ggplot(plotData, aes_(x = plotData[[varName]])) + 
      geom_histogram(aes(y = (..count..)/sum(..count..)*100)) +
      labs(x = varName)
  }
  
  #other visual adjustments, applicable to all graphs
  graph <- graph + 
    labs(title = paste(toupper(varName), " Distribution"),
         y = "percentage(%)") +
    theme(plot.title = element_text(size = 14, hjust = 0.5, face = "bold"),
          axis.text = element_text(size = 10))
  
  #our final output
  graph
}

