

#' @title images
#' @description Use images in node style
#'
#' @param cytoscape object
#'
#' @return cytoscape object
#' @export
#'
#' @examples
node_images <- function(cytoscape){

  nd <- cytoscape$x$nodes
  stopifnot('images' %in% colnames(nd))

  cytoscape$x$images <- nd

  return(cytoscape)

}
