import {Chart} from './chart';
import * as d3 from "d3";


let chart = undefined;

function NativeApp(app) {
  app.ports.initChart.subscribe(function([id, data]) {

    if(document.getElementById(id).innerHTML === '') {
      chart = Chart({id, data});
    } else {
      chart.updateSize({w: 400, h: 200});
    }
  });
  app.ports.removeChart.subscribe(function(divId) {
    console.log('removeChart: divId: ', divId);
  });

}

module.exports = NativeApp;
