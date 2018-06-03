HTMLWidgets.widget({

  name: 'cytoscape',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
        el.innerText = x.message;

        var nodes = HTMLWidgets.dataframeToD3(x.nodes);
        var edges = HTMLWidgets.dataframeToD3(x.edges);

        console.log(nodes[1]);

        // add data label to each element
        for(var n in nodes) {
          nodes[n] = {data: nodes[n], position: nodes[n]};
        }
        for(var e in edges) {
          edges[e] = {data: edges[e]};
        }

        console.log(nodes);

        // setup basic plot
        var cy = cytoscape({

            container: document.getElementById(el.id), // container to render in

            elements: {
              nodes: nodes,
              edges: edges
            },


            style: [ // the stylesheet for the graph
              {
                selector: 'node',
                style: x.node_style
              },

              {
                selector: 'edge',
                style: x.edge_style
              }
            ],

            layout: x.layout

          });

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
