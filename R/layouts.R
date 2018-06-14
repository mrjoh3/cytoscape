


#' @rdname layout.cytoscape
#' @family layout
#' @export
layout <- function(cytoscape,
                   name = NULL,
                   fit = TRUE,
                   padding = 30,
                   boundingBox = NULL,
                   avoidOverlap = TRUE,
                   avoidOverlapPadding = 10,
                   nodeDimensionsIncludeLabels = FALSE,
                   spacingFactor = NULL,
                   condense = FALSE,
                   rows = NULL,
                   cols = NULL,
                   position = NULL,
                   sort = NULL,
                   animate = FALSE,
                   animationDuration = 500,
                   animationEasing = NULL,
                   animateFilter = NULL,
                   ready = NULL,
                   stop = NULL,
                   transform = NULL,
                   ...){
  UseMethod('layout')
}




#' @title Layout
#' @description Set network layout options
#'
#' @param cytoscape object
#' @param name character option, must b one of:
#' \itemize{
#'   \item{null}
#'   \item{random}
#'   \item{preset}
#'   \item{grid}
#'   \item{circle}
#'   \item{concentric}
#'   \item{breadthfirst}
#'   \item{cose}
#' }
#' @param fit boolean whether to fit the viewport to the graph
#' @param padding integer pixels padding used on fit
#' @param boundingBox = undefined, // constrain layout bounds; { x1, y1, x2, y2 } or { x1, y1, w, h }
#' @param avoidOverlap boolean prevents node overlap, may overflow boundingBox if not enough space
#' @param avoidOverlapPadding integer pixels extra spacing around nodes when avoidOverlap = true
#' @param nodeDimensionsIncludeLabels = false, // Excludes the label when calculating node bounding boxes for the layout algorithm
#' @param spacingFactor = undefined, // Applies a multiplicative factor (>0) to expand or compress the overall area that the nodes take up
#' @param condense boolean, uses all available space on false, uses minimal space on true
#' @param rows integer force num of rows in the grid
#' @param cols integer force num of columns in the grid
#' @param position js function( node ){}, // returns { row, col } for element
#' @param sort js a sorting function to order the nodes; e.g. function(a, b){ return a.data('weight') - b.data('weight') }
#' @param animate boolean whether to transition the node positions
#' @param animationDuration integer duration of animation in ms if enabled
#' @param animationEasing = undefined, // easing of animation if enabled
#' @param animateFilter = function ( node, i ){ return true; }, // a function that determines whether the node should be animated.  All nodes animated by default on animate enabled.  Non-animated nodes are positioned immediately when the layout starts
#' @param ready = undefined, // callback on layoutready
#' @param stop = undefined, // callback on layoutstop
#' @param transform = 'function (node, position ){ return position; }'
#' @param ... additional parameters passed to the layout object
#'
#' @return cytoscape object
#' @export
#'
#' @importFrom jsonlite toJSON
#' @importFrom utils modifyList
#' @examples
#'
#' df <- cytoscape::comtrade
#'
#' nodes <- data.frame(id = unique(c(df$reporter, df$partner)))
#' edges <- df %>%
#'   dplyr::select(source = reporter,
#'                 target = partner) %>%
#'   dplyr::mutate(id = paste(source, '_', target))
#'
#' cytoscape(nodes = nodes, edges = edges) %>%
#'   cytoscape::layout(4)
#'
layout.cytoscape <- function(cytoscape,
                   name = NULL,
                   fit = TRUE,
                   padding = 30,
                   boundingBox = NULL,
                   avoidOverlap = TRUE,
                   avoidOverlapPadding = 10,
                   nodeDimensionsIncludeLabels = FALSE,
                   spacingFactor = NULL,
                   condense = FALSE,
                   rows = NULL,
                   cols = NULL,
                   position = NULL,
                   sort = NULL,
                   animate = FALSE,
                   animationDuration = 500,
                   animationEasing = NULL,
                   animateFilter = NULL,
                   ready = NULL,
                   stop = NULL,
                   transform = NULL,
                   ...) {

  stopifnot(!is.null(name),
            name %in% c('null', 'random', 'preset', 'grid', 'circle', 'concentric', 'breadthfirst', 'cose')
  )

  layout <- list(name = name,
                 fit = fit,
                 padding = padding,
                 boundingBox = boundingBox,
                 avoidOverlap = avoidOverlap,
                 avoidOverlapPadding = avoidOverlapPadding,
                 nodeDimensionsIncludeLabels = nodeDimensionsIncludeLabels,
                 spacingFactor = spacingFactor,
                 condense = condense,
                 rows = rows,
                 cols = cols,
                 position = position,
                 sort = sort,
                 animate = animate,
                 animationDuration = animationDuration,
                 animationEasing = animationEasing,
                 animateFilter = animateFilter,
                 ready = ready,
                 stop = stop,
                 transform = transform)

  layout <- modifyList(layout, list(...))
  layout <- Filter(Negate(function(x) is.null(unlist(x))), layout)

  cytoscape$x$layout <- jsonlite::toJSON(layout,
                               auto_unbox = T)
  return(cytoscape)

}


#' Title
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
        return(cytoscape)

}


