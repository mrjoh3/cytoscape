

colaDependancy <- function() {
  list(
    htmltools::htmlDependency(
      name = 'cola', version = '3.3.8',
      src = system.file('htmlwidgets/lib/cola-3.3.8', package = 'cytoscape'),
      script = c('cola.min.js')
    )
  )
}

cycolaDependency <- function() {
  list(
    htmltools::htmlDependency(
      name = 'cytoscape-cola', version = '2.2.3',
      src = system.file('htmlwidgets/lib/cytoscape-cola-2.2.3', package = 'cytoscape'),
      script = c('cytoscape-cola.js')
    )
  )
}



#' @title Cola Layout 
#'
#' @param cytoscape
#' @param name
#' @param animate
#' @param refresh
#' @param maxSimulationTime
#' @param ungrabifyWhileSimulating
#' @param fit
#' @param padding
#' @param boundingBox
#' @param nodeDimensionsIncludeLabels
#' @param ready
#' @param stop
#' @param randomize
#' @param avoidOverlap
#' @param handleDisconnected
#' @param nodeSpacing
#' @param flow
#' @param alignment
#' @param gapInequalities
#' @param edgeLength
#' @param edgeSymDiffLength
#' @param edgeJaccardLength
#' @param unconstrIter
#' @param userConstIter
#' @param allConstIter
#' @param infinite
#' @param ...
#'
#' @importFrom jsonlite toJSON
#' @importFrom htmlwidgets JS
#' @return
#' @export
#'
#' @examples
cola_layout <- function(cytoscape,
                        name = 'cola',
                        animate = TRUE, # whether to show the layout as it's running
                        refresh = 1, # number of ticks per frame; higher is faster but more jerky
                        maxSimulationTime = 4000, # max length in ms to run the layout
                        ungrabifyWhileSimulating = FALSE, # so you can't drag nodes during layout
                        fit = TRUE, # on every layout reposition of nodes, fit the viewport
                        padding = 30, # padding around the simulation
                        boundingBox = NULL, # constrain layout bounds; { x1, y1, x2, y2 } or { x1, y1, w, h }
                        nodeDimensionsIncludeLabels = FALSE, # whether labels should be included in determining the space used by a node
                        
                        # layout event callbacks
                        ready = htmlwidgets::JS('function(){}'), # on layoutready
                        stop = htmlwidgets::JS('function(){}'), # on layoutstop
                        
                        # positioning options
                        randomize = FALSE, # use random node positions at beginning of layout
                        avoidOverlap = TRUE, # if TRUE, prevents overlap of node bounding boxes
                        handleDisconnected = TRUE, # if TRUE, avoids disconnected components from overlapping
                        nodeSpacing = htmlwidgets::JS("function( node ){ return 10; }"), # extra spacing around nodes
                        flow = NULL, # use DAG/tree flow layout if specified, e.g. { axis = 'y', minSeparation = 30 }
                        alignment = NULL, # relative alignment constraints on nodes, e.g. function( node ){ return { x = 0, y = 1 } }
                        gapInequalities = NULL, # list of inequality constraints for the gap between the nodes, e.g. [{"axis" ="y", "left" =node1, "right" =node2, "gap" =25}]. The constraint in the example says that the center of node1 must be at least 25 pixels above the center of node2. In other words, it is an inequality constraint that requires "node1.y + gap <= node2.y". You can set the extra "equality" attribute as "TRUE" to convert it into an equality constraint.
                        
                        # different methods of specifying edge length
                        # each can be a constant numerical value or a function like `function( edge ){ return 2; }`
                        edgeLength = NULL, # sets edge length directly in simulation
                        edgeSymDiffLength = NULL, # symmetric diff edge length in simulation
                        edgeJaccardLength = NULL, # jaccard edge length in simulation
                        
                        # iterations of cola algorithm; uses default values on NULL
                        unconstrIter = NULL, # unconstrained initial layout iterations
                        userConstIter = NULL, # initial layout iterations with user-specified constraints
                        allConstIter = NULL, # initial layout iterations with all constraints including non-overlap
                        
                        # infinite layout options
                        infinite = FALSE, # overrides all other options for a forces-all-the-time mode
                        ...){
  
  layout <- list(name = 'cola',
                 animate = animate,
                 refresh = refresh,
                 maxSimulationTime = maxSimulationTime,
                 ungrabifyWhileSimulating = ungrabifyWhileSimulating,
                 fit = fit,
                 padding = padding,
                 boundingBox = boundingBox,
                 nodeDimensionsIncludeLabels = nodeDimensionsIncludeLabels,
                 ready = ready,
                 stop = stop,
                 randomize = randomize,
                 avoidOverlap = avoidOverlap,
                 handleDisconnected = handleDisconnected,
                 nodeSpacing = nodeSpacing,
                 flow = flow,
                 alignment = alignment,
                 gapInequalities = gapInequalities,
                 edgeLength = edgeLength,
                 edgeSymDiffLength = edgeSymDiffLength,
                 edgeJaccardLength = edgeJaccardLength,
                 unconstrIter = unconstrIter,
                 userConstIter = userConstIter,
                 allConstIter = allConstIter,
                 infinite = infinite
  )
  
  layout <- modifyList(layout, list(...))
  layout <- Filter(Negate(function(x) is.null(unlist(x))), layout)
  
  cytoscape$x$layout <- layout
  
  # add cola dependancies here
  if (is.null(cytoscape$dependencies)) {
    cytoscape$dependencies <- c(colaDependancy(), cycolaDependency())
  } else {
    cytoscape$dependencies <- c(colaDependancy(), cycolaDependency(), cytoscape$dependencies)
  }
  
  return(cytoscape)
  
}

