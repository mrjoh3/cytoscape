cypanzoomDependency <- function() {
  list(
    htmltools::htmlDependency(
      name = 'cytoscape-panzoom', version = '2.5.2',
      src = system.file('htmlwidgets/lib/cytoscape-panzoom', package = 'cytoscape'),
      script = c('cytoscape-panzoom.js'),
      stylesheet = c("cytoscape.js-panzoom.css")
    )
  )
}
jqueryDependency <- function() {
  list(
    rmarkdown::html_dependency_jquery()
    )
}

fontawesomeDependency <- function() {
  list(
    rmarkdown::html_dependency_font_awesome()
  )
}
#' @title panzoom Layout
#'
#' @param cytoscape
#' @param name
#' @param zoomFactor
#' @param  zoomDelay
#' @param minZoom
#' @param maxZoom
#' @param fitPadding
#' @param panSpeed
#' @param panDistance
#' @param panDragAreaSize
#' @param panMinPercentSpeed
#' @param panInactiveArea
#' @param panIndicatorMinOpacity
#' @param zoomOnly
#' @param fitSelector
#' @param animateOnFit
#' @param fitAnimationDuration
#' @param sliderHandleIcon
#' @param zoomInIcon
#' @param zoomOutIcon
#' @param resetIcon
#' @param ...
#'
#' @importFrom jsonlite toJSON
#' @importFrom htmlwidgets JS
#' @return
#' @export
#'
#' @examples
panzoom <- function(cytoscape,
                    name = 'panzoom',
                    zoomFactor = 0.05, # zoom factor per zoom tick
                    zoomDelay = 45, # how many ms between zoom ticks
                    minZoom = 0.1, # min zoom level
                    maxZoom = 10, # max zoom level
                    fitPadding = 50, # padding when fitting
                    panSpeed = 10, # how many ms in between pan ticks
                    panDistance = 10, # max pan distance per tick
                    panDragAreaSize = 75, # the length of the pan drag box in which the vector for panning is calculated (bigger = finer control of pan speed and direction)
                    panMinPercentSpeed = 0.25, # the slowest speed we can pan by (as a percent of panSpeed)
                    panInactiveArea = 8, # radius of inactive area in pan drag box
                    panIndicatorMinOpacity = 0.5, # min opacity of pan indicator (the draggable nib); scales from this to 1.0
                    zoomOnly = FALSE, # a minimal version of the ui only with zooming (useful on systems with bad mousewheel resolution)
                    fitSelector = NULL, # selector of elements to fit
                    animateOnFit = htmlwidgets::JS('function(){return false;}'), # whether to animate on fit
                    fitAnimationDuration = 1000, # duration of animation on fit

                    # icon class names
                    sliderHandleIcon = 'fa fa-minus',
                    zoomInIcon = 'fa fa-plus',
                    zoomOutIcon = 'fa fa-minus',
                    resetIcon = 'fa fa-expand',
                        ...){

  panzoom <- list(name = 'panzoom',
                  zoomFactor = zoomFactor,
                  zoomDelay = zoomDelay,
                  minZoom = minZoom,
                  maxZoom = maxZoom,
                  fitPadding = fitPadding,
                  panSpeed = panSpeed,
                  panDistance = panDistance,
                  panDragAreaSize = panDragAreaSize,
                  panMinPercentSpeed = panMinPercentSpeed,
                  panInactiveArea = panInactiveArea,
                  panIndicatorMinOpacity = panIndicatorMinOpacity,
                  zoomOnly = zoomOnly,
                  fitSelector = fitSelector,
                  animateOnFit = animateOnFit,
                  fitAnimationDuration = fitAnimationDuration,
                  sliderHandleIcon = sliderHandleIcon,
                  zoomInIcon = zoomInIcon,
                  zoomOutIcon = zoomOutIcon,
                  resetIcon = resetIcon
  )

  panzoom <- modifyList(panzoom, list(...))
  panzoom <- Filter(Negate(function(x) is.null(unlist(x))), panzoom)

  cytoscape$x$panzoom <- panzoom

  # add panzoom dependancies here
  if (is.null(cytoscape$dependencies)) {
    cytoscape$dependencies <- c(jqueryDependency(), cypanzoomDependency(), fontawesomeDependency())
  } else {
    cytoscape$dependencies <- c(jqueryDependency(), cypanzoomDependency(), fontawesomeDependency(),
                                cytoscape$dependencies)
  }

  return(cytoscape)

}
