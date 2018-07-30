

cy_filter <- function(id, filter, options) {
  message <- list(id = id, filter = filter)
  if (!missing(options)) {
    message['options'] <- options
  }
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage("cytoscape:filter", message)
}