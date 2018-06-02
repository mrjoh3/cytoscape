Cytoscape Network Charts
================

A HTMLWidget wrapper for the [Cytoscape.js](http://js.cytoscape.org/) graph / network visualisation and analysis library.

A Minimal Example
-----------------

``` r
nodes <- data.frame(id = c('a','b'))
edges <- data.frame(id = 'ab', source = 'a', target = 'b')

cytoscape(nodes = nodes, edges = edges)
```

![](README_files/figure-markdown_github/min-1.png)

With Real Data
--------------

Comtrade waste plastic exports for December 2017.

``` r
df <- cytoscape::comtrade

nodes <- data.frame(id = unique(c(df$reporter, df$partner)))
edges <- df %>%
    dplyr::select(source = reporter,
                  target = partner) %>%
    dplyr::mutate(id = paste(source, '_', target))
           
cytoscape(nodes = nodes, edges = edges) %>% 
  layout('grid', rows = 4)
```

![](README_files/figure-markdown_github/plastics-1.png)
