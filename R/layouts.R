


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
