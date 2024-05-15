library(gssr)
library(gssrdoc)
library(shinydashboard)
library(shiny)
library(shinyWidgets)
library(tidyverse)
library(labelled)

#getting the data in
gss22 <- gss_get_yr(2022)

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

