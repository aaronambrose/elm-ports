import {Chart} from './chart';
import * as d3 from "d3";

var content = null;

function NativeApp(app) {

  // remove any data from previous page
  app.ports.pageChangePort.subscribe(function(id) {
    content = null;
  });

  app.ports.initChart.subscribe(function([id, data]) {
    if(document.getElementById(id).innerHTML === '') {
      content = {};
      content.chart = Chart({id, data});
    }
  });
  app.ports.updateChartSize.subscribe(function() {

    // TODO: clean this mess up
    if(content == null) return;
    var {chart} = content;
    if(chart) chart.updateSize();
  });

}

module.exports = NativeApp;
