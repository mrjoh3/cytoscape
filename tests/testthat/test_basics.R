

context("Basic Functions")




test_that('function works and returns correct type', {

  nodes <- data.frame(id = c('a','b'))
  edges <- data.frame(id = 'ab', source = 'a', target = 'b')
  ct <- cytoscape(nodes = nodes, edges = edges)

  expect_is(ct, c('cytoscape','htmlwidget'))

})
