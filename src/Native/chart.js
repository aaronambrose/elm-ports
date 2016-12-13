


export const Chart = (divId, data) => {
  const id = divId;
  console.log('id: ', id);
  buildChart(id, data);

  function resize() {

  }

  window.onresize = resize;
}

function buildChart(divId, data) {

  var mainDiv = document.getElementById(divId);
  var parentDiv = d3.select('#' + divId);
  var w = mainDiv.offsetWidth;
  var h = (mainDiv.offsetHeight >= 0) ? 400 : mainDiv.offsetHeight;
  console.log('mainDiv: ', mainDiv);
  console.log('w: ', w);
  console.log('h: ', h);
  var svg = parentDiv.append("svg");

  svg.attr("width", w).attr("height", h);

  var margin = {top: 20, right: 20, bottom: 30, left: 50},
  width = +svg.attr("width") - margin.left - margin.right,
  height = +svg.attr("height") - margin.top - margin.bottom,
  g = svg.append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");
  var parseTime = d3.timeParse("%d-%b-%y");

  data.forEach(d => {
    d.date = parseTime(d.date);
    d.close = +d.close;
  });

  console.log('data: ', data);

  var x = d3.scaleTime()
  .rangeRound([0, width]);

  var y = d3.scaleLinear()
  .rangeRound([height, 0]);

  var line = d3.line()
  .x(function(d) { return x(d.date); })
  .y(function(d) { return y(d.close); });



  x.domain(d3.extent(data, function(d) { return d.date; }));
  y.domain(d3.extent(data, function(d) { return d.close; }));

  g.append("g")
  .attr("class", "axis axis--x")
  .attr("transform", "translate(0," + height + ")")
  .call(d3.axisBottom(x));

  g.append("g")
  .attr("class", "axis axis--y")
  .call(d3.axisLeft(y))
  .append("text")
  .attr("fill", "#000")
  .attr("transform", "rotate(-90)")
  .attr("y", 6)
  .attr("dy", "0.71em")
  .style("text-anchor", "end")
  .text("Price ($)");

  g.append("path")
  .datum(data)
  .attr("class", "line")
  .attr("d", line);
}
