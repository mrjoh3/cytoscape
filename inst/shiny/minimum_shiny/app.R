#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(cytoscape)

# Define UI for application that draws a network
ui <- fluidPage(

   # Application title
   titlePanel("Comtrade Plastic Exports"),

   sidebarLayout(
      sidebarPanel(
         tags$p('Minimal Example integrated cytoscape into a shiny application. No formatting or cleaning has been done.')
      ),

      mainPanel(
         cytoscapeOutput("network")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

   output$network <- renderCytoscape({
     # generate some data
     df <- cytoscape::comtrade

     nodes <- data.frame(id = unique(c(df$reporter, df$partner)), stringsAsFactors = FALSE)
     edges <- df %>%
       dplyr::select(source = reporter,
                     target = partner) %>%
       dplyr::mutate(id = paste(source, '_', target))

     # draw the network
     cytoscape(nodes = nodes, edges = edges) %>%
       layout('breadthfirst', directed = TRUE) %>%
       panzoom()

   })
}

# Run the application
shinyApp(ui = ui, server = server)

