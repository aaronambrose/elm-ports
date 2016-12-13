import {Chart} from './chart';
import * as d3 from "d3";

export const NativeApp = (app) => {
  app.ports.initChart.subscribe(function([divId, data]) {
    const chart = Chart(divId, data);
  });
  app.ports.removeChart.subscribe(function(divId) {
    console.log('removeChart: divId: ', divId);
  });

}
