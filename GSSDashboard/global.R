#dashboard url:
#https://timothyabramov.shinyapps.io/GSSExplorer/

library(gssr)
library(gssrdoc)
library(readstata13)
library(shinydashboard)
library(shiny)
library(shinythemes)
library(shinyWidgets)
library(shinycssloaders)
library(tidyverse) 
library(labelled)
library(plotly)
library(rlang)
library(readxl)
library(stringr)

#getting the data in from NORC directly
#data(gss_all) don't have enough ram on shinyapps service for that
gss_year = 2022
gss_data <- gss_get_yr(gss_year)


#var types file
gss_var_types <- read_excel("data/varInfo.xlsx")

#ui color pallete (based on Flatly from Bootswatch):
flatly_palette <- list('default' = '#99A4A6',
                       'primary' = '#313E4E',
                       'success' = '#59B99D',
                       'info' = '#5296D3',
                       'warning' = '#E5A140',
                       'danger' = '#D65746',
                       'link' = '#59B697')


#variable, label, and var_text from gss_dict for gssYear
gss_var_info <- gss_dict %>%
  select(variable, label, var_text, years) %>%
  na.omit() %>%
  mutate(label = unname(label)) %>%
  unnest(years) %>%
  filter(year == gss_year, present == TRUE) %>%
  inner_join(gss_var_types, by = "variable") %>% #filter vars to only those that I have a type for
  filter(status == "done") %>%
  select(variable, label = label.x, text = var_text.x, type, subtype)
gss_var_info <- data.frame(gss_var_info)


#vector of categorical vars for viz selection
categorical_vars <- gss_var_info %>%
  filter(type == "categorical") %>%
  select(variable)
categorical_vars <- as.character(categorical_vars$variable)





#Functions:
###########################################################

#text wrapper, for making sure labels are not too long
wrapp_text <- function(text, threshold = 20){
  
  output_vector <- c()
  
  for(text_element in text)
  {
    
    text_size <- nchar(text_element)
    
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
        
        
        temp_str <- str_trim(substring(text_element, start, end))
        
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

#plot(s) for a single question/var selection
plotSingleQuestion <- function(varName, gssYear, sort, orientation, nCategories, topN, binsConfig, bins){
  
  #-no selection TODO(getting this a decent number of times, see if that can be fixed)
  if(varName == ""){
    print("no question selected!(selectizeInput)")
    return()
  }
  
  #variable prep
  sortTranslated <- if(sort == "none"){"trace"}
                    else if(sort == "descending"){"total descending"}
                    else{"total ascending"}
  sortTranslatedInverted <- if(sortTranslated == "total descending"){"total ascending"}
                            else if(sortTranslated == "total ascending"){"total descending"}
                            else{"trace"}
  
  #get the data for the selected question
  varLabel <- as.character(gss_dict[gss_dict['variable'] == varName, 'label'])
  plotData <- data.frame(unlabelled(gss_data[[varName]])) 
  names(plotData) <- varName
  #print("Original selection:")
  #str(plotData)
  
  #initialize graph var
  graph <- NULL
  
  #type of plot depending on the question selected
  #-categorical:
  if((gss_var_types %>% filter(variable == varName))$type[1] == "categorical"){  
    
    #data prep
    plotData[[varName]] <- as.character(plotData[[varName]])
    #print("Data adjusted for categorical plotly(character):")
    #str(plotData)
    
    
    cat_values = plotData %>%
      dplyr::mutate(quantity = 1) %>%
      dplyr::group_by(!!sym(varName)) %>%
      dplyr::summarise(count = sum(quantity))  %>%
      dplyr::filter(!is.na(get(varName))) %>%
      dplyr::mutate(percent = count / sum(count) * 100)
    cat_values[[varName]] <- wrapp_text(cat_values[[varName]])
    
    print("Data prepped for plotly:")
    print(cat_values)
    
    graph <- plot_ly(x = if(orientation == "vertical"){~cat_values[[varName]]}else{~cat_values$percent} ,
                     y = if(orientation == "vertical"){~cat_values$percent}else{~cat_values[[varName]]},
                     type = "bar",
                     orientation = ifelse(orientation == "vertical", 'v', 'h'),
                     marker = list(color = '#5296D3'),
                     hoverlabel = list(font = list(color = '#FFFFFF')),
                     text = ~paste0(cat_values[[varName]], "<br>", round(cat_values$percent, 1), "%"),
                     hoverinfo = 'text', textposition = 'none') %>%
             layout(title = paste0(varLabel, " (", varName, ", ", gssYear, ")"), #titles and tick orientation depending on orientation
                    xaxis = if(orientation == "vertical"){list(tickangle = -90, title = " ")}
                            else{list(title = "%")},
                    yaxis = if(orientation == "vertical"){list(title = "%")}
                            else{list(title = " ")}) %>%
             layout(xaxis = list(categoryorder = sortTranslated),
                    yaxis = list(categoryorder = sortTranslatedInverted)) 
    

  }
  #-quantitative
  else if((gss_var_types %>% filter(variable == varName))$type[1] == "quantitative"){
    plotData[[varName]] <- as.numeric(plotData[[varName]])
    
    #troubleshooting
    # print("min")
    # print(min(plotData[[varName]], na.rm = TRUE))
    # print("max")
    # print(max(plotData[[varName]], na.rm = TRUE))
    
    #axis styles:
    ax_hist <- list(
      title = varName,
      zeroline = FALSE,
      showline = FALSE,
      showticklabels = TRUE,
      showgrid = FALSE
    )

    ax_box <- list(
      title = "",
      zeroline = FALSE,
      showline = FALSE,
      showticklabels = FALSE,
      showgrid = FALSE
    )
    
    
    graph <- subplot(
      #boxplot
      plot_ly(x = plotData[[varName]], type = "box", boxmean = TRUE,
              name = " ", marker = list(color = '#5296D3'),
              fillcolor = '#FFFFFF', 
              hoverlabel = list(font = list(color = '#FFFFFF')),
              hoverinfo = 'x') %>%
        layout(xaxis = ax_box, showlegend = FALSE),
      
      #histogram
      #auto num of bins
      if(binsConfig == "auto"){ #for now auto works somewhat sus, was better before
        plot_ly(x = plotData[[varName]], type = "histogram", histnorm = "percent",
                name = " ", marker = list(color = '#5296D3'),
                nbinsx = 5,
                hoverlabel = list(font = list(color = '#FFFFFF')),
                hovertemplate = '%{x}<br>%{y:.1f}%<extra></extra>') %>%
          layout(xaxis = ax_hist, yaxis = ax_hist)
      }
      #manual num of bins
      else 
      { 
        plot_ly(x = plotData[[varName]], type = "histogram", histnorm = "percent",
                name = " ", marker = list(color = '#5296D3'),
                xbins = list(start = min(plotData[[varName]], na.rm = TRUE),
                             end = max(plotData[[varName]], na.rm = TRUE),
                             size = (max(plotData[[varName]], na.rm = TRUE) - min(plotData[[varName]], na.rm = TRUE)) / bins),
                hoverlabel = list(font = list(color = '#FFFFFF')),
                hovertemplate = '%{x}<br>%{y:.1f}%<extra></extra>') %>%
          layout(xaxis = ax_hist, yaxis = ax_hist)
      },
      
      nrows = 2, heights = c(0.3, 0.7),
      shareX = TRUE
    ) %>%
      layout(showlegend = FALSE, title = paste0(varLabel, " (", varName,", ", gssYear, ")"))
  }
  
  graph <- graph %>%
    config(modeBarButtonsToRemove = list("zoom2d","pan2d","select2d","lasso2d",
        "zoomIn2d","zoomOut2d","autoScale2d","resetScale2d",
        "hoverClosestCartesian","hoverCompareCartesian"),
        toImageButtonOptions = list(format = "png",
                                    filename = "GSS_Explorer_",
                                    height = 1000, width = 1000,
                                    scale = 2))
  
  #our final output
  return(graph)
}

#plot(s) for 2 questions/vars selected
plotQuestionComparison <- function(varName1, varName2){
  
}




