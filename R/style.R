

#' @title Edge Style
#'
#' @param cytoscape object
#' @param ... additional parameters passed to the style edge object
#'
#' @return
#' @export
#'
#' @examples
#'
#' nodes <- data.frame(id = c('a','b'))
#' edges <- data.frame(id = 'ab', source = 'a', target = 'b')
#'
#' cytoscape(nodes = nodes, edges = edges) %>% edge_style('line-color' = '#ff0000')
#'
edge_style <- function(cytoscape, ...){

  es <- jsonlite::fromJSON(cytoscape$x$edge_style)
  es <- modifyList(es, list(...))

  cytoscape$x$edge_style <- jsonlite::toJSON(es, auto_unbox = TRUE)

  return(cytoscape)

}



#' @title Node Style
#'
#' @param cytoscape
#' @param ... additional parameters passed to the style node object
#'
#' @return
#' @export
#'
#' @examples
#'
#' nodes <- data.frame(id = c('a','b'))
#' edges <- data.frame(id = 'ab', source = 'a', target = 'b')
#'
#' cytoscape(nodes = nodes, edges = edges) %>% node_style('background-color' = '#ff0000')
#'
node_style <- function(cytoscape, ...){

  ns <- jsonlite::fromJSON(cytoscape$x$node_style)
  ns <- modifyList(ns, list(...))

  cytoscape$x$node_style <- jsonlite::toJSON(ns, auto_unbox = TRUE)

  return(cytoscape)

}
