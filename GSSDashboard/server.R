library(shiny)
library(shinyWidgets)


function(input, output, session) {
  #startup message
  show_alert(
    title = "Warning!",
    text = "You're entering a CONSTRUCTION site (pun intended). Work in PROGRESS, proceed with CAUTION!",
    type = "warning"
  )
}
