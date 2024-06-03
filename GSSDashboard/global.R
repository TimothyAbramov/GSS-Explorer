#dashboard url:
#https://timothyabramov.shinyapps.io/GSS2022Dashboard/

#library(gssr)
#library(gssrdoc)
library(readstata13)
library(shinydashboard)
library(shiny)
library(shinythemes)
library(shinyWidgets)
library(tidyverse)
library(labelled)
library(plotly)
library(rlang)

#getting the data in
#gss22 <- gss_get_yr(2022)
gss22 <- read.dta13("GSS2022.dta")



#text wrapper for making sure labels are not too long
wrapp_text <- function(text, threshold = 20){
  
  output_vector <- c()
  
  for(text_element in text)
  {
    
    text_size <- nchar(text_element)
    #print(text_size)
    
    #if text not long enough to wrapp
    if(text_size <= threshold)
    {
      output_vector <- c(output_vector, text_element)
      next
    }
    
    #wrapp text
    else
    {
      output_str <- ""
      pos <- 1
      while(pos <= text_size)
      {
        start <- pos
        
        end <- start + threshold-1
        if(end > text_size){end = text_size}
        
        while(end < text_size & substring(text_element, end, end) != " ")
        { 
          end <- end + 1
        }
        
        temp_str <- substring(text_element, start, end)
        if(end != text_size)
        {
          temp_str <- paste(temp_str,"<br>", sep = "") #update the line
        }
        output_str <- paste(output_str, temp_str, sep = "") #update output string
        
        pos <- end + 1 #move to next part of the string
      }
      
      output_vector <- c(output_vector, output_str)
    }
  }
  return(output_vector)
}



#plotly dynamic graphs
plotPlotlyGraph <- function(varName){
  #get the data for the selected question
  plotData <- data.frame(gss22[[varName]]) 
  names(plotData) <- varName
  print("Original selection:")
  str(plotData)
  
  #initialize graph var
  graph <- NULL
  
  #type of plot depending on the question selected
  
  if(varName %in% c("wrkstat", "wrkslf", "degree", "race")){ #if categorical 
    #data prep
    plotData[[varName]] <- as.character(plotData[[varName]])
    print("Data adjusted for categorical plotly(character):")
    str(plotData)
    
    
    cat_values = plotData %>%
      dplyr::mutate(quantity = 1) %>%
      dplyr::group_by(!!sym(varName)) %>%
      dplyr::summarise(count = sum(quantity))  %>%
      dplyr::filter(!is.na(get(varName))) %>%
      dplyr::mutate(percent = count / sum(count) * 100)
      #dplyr::mutate(cat_name = wrapp_text(!!varName))
    cat_values[[varName]] <- wrapp_text(cat_values[[varName]])
    
    print("Data prepped for plotly:")
    print(cat_values)
    
    graph <- plot_ly(x = cat_values[[varName]],
                     y = cat_values$percent,
                     type = "bar") %>%
             layout(title = paste(varName, "distribution"),
                    xaxis = list(tickangle = 90),
                    yaxis = list(title = "%"))
    

  }
  #if quantitative
  else{
    plotData[[varName]] <- as.numeric(plotData[[varName]]) #error somewhere here
    print("Data adjusted for quantitative")
    str(plotData[[varName]])
    
    # graph <- ggplot(plotData, aes_(x = plotData[[varName]])) + 
    #   geom_histogram(aes(y = (..count..)/sum(..count..)*100), fill = "cornflowerblue") +
    #   labs(x = varName)
  }
  
  #other visual adjustments, applicable to all graphs
  # graph <- graph + 
  #   labs(title = paste(toupper(varName), " Distribution"),
  #        y = "percentage(%)") +
  #   theme(plot.title = element_text(size = 14, hjust = 0.5, face = "bold"),
  #         axis.text = element_text(size = 10),
  #         axis.title = element_text(size = 12, face = "bold"))
  
  #our final output
  graph
}



















#ggplot:
# plotGraph <- function(varName){
#   #get the data for the selected question
#   plotData <- data.frame(gss22[[varName]]) 
#   names(plotData) <- varName
#   print("Original selection:")
#   str(plotData)
#   
#   #initialize graph var
#   graph <- NULL
#   
#   #type of plot depending on the question selected
#   #if categorical
#   if(varName %in% c("wrkstat", "wrkslf", "degree", "race")){
#     plotData[[varName]] <- to_factor(plotData[[varName]])
#     print("Data adjusted for categorical:")
#     str(plotData)
#     
#     graph <- ggplot(plotData, aes(.data[[varName]], fill = plotData[[varName]])) + 
#       geom_bar(aes(y = (..count..)/sum(..count..)*100)) + #bar plot
#       theme(panel.grid.major.x = element_blank(),
#             panel.grid.minor.x = element_blank(),
#             legend.position = "none") +
#       aes(stringr::str_wrap(.data[[varName]], 15)) +
#       labs(x = "")
#   }
#   #if quantitative
#   else{
#     plotData[[varName]] <- as.numeric(plotData[[varName]]) #error somewhere here
#     print("Data adjusted for quantitative")
#     str(plotData[[varName]])
#     
#     graph <- ggplot(plotData, aes_(x = plotData[[varName]])) + 
#       geom_histogram(aes(y = (..count..)/sum(..count..)*100), fill = "cornflowerblue") +
#       labs(x = varName)
#   }
#   
#   #other visual adjustments, applicable to all graphs
#   graph <- graph + 
#     labs(title = paste(toupper(varName), " Distribution"),
#          y = "percentage(%)") +
#     theme(plot.title = element_text(size = 14, hjust = 0.5, face = "bold"),
#           axis.text = element_text(size = 10),
#           axis.title = element_text(size = 12, face = "bold"))
#   
#   #our final output
#   graph
# }

