HTMLWidgets.widget({

  name: 'cytoscape',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        var cy;

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

        // create style
        var style = [
              {selector: 'node', style: x.node_style},
              {selector: 'edge', style: x.edge_style}
        ];


        // if x.images exists
        if (x.hasOwnProperty('images')) {
          var images = HTMLWidgets.dataframeToD3(x.images);
          for (i = 0; i < images.length; ++i) {
            images[i] = {selector: '#' + images[i].id, style: {'background-image': images[i].images}};
          }
          // add regular style
          Array.prototype.push.apply(style, images);
          console.log(style);
        }

        if (x.json !== null) {

          var json = JSON.parse(x.json);
          console.log(json);

          cy = cytoscape({
            container: document.getElementById(el.id), // container to render in
            elements: json.elements,
            style: json.style,
            layout: json.layout
          });

          cy.json(json);
          console.log(x);

          if(x.hasOwnProperty('panzoom')){
            cy.panzoom(x.panzoom);
          }

        } else {

          // setup basic plot
          cy = cytoscape({

              container: document.getElementById(el.id), // container to render in

              elements: {
                nodes: nodes,
                edges: edges
              },


              style: style,
              layout: x.layout

            });
          console.log(x);
          if(x.hasOwnProperty('panzoom')){
            cy.panzoom(x.panzoom);
          }
        }
        
        document.getElementById(el.id).cy = cy;
        
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});


if (HTMLWidgets.shinyMode) {
  Shiny.addCustomMessageHandler("cytoscape:filter", function(message) {
    var el = document.getElementById(message.id);
    if (el) {
      el.cy.nodes().filter(message.filter);
    }
  });
}


