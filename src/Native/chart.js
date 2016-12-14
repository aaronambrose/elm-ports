
const formatData = (data) => {

  const parseTime = d3.timeParse('%d-%b-%y');
  data.forEach(d => {
    d.date = parseTime(d.date);
    d.close = +d.close;
  });
  return data;
}

const getSVG = (id, element, isEmpty) => {
  const w = element.offsetWidth;
  const h = w / 2;
  const margin = {
      top: 20,
      right: 20,
      bottom: 30,
      left: 50
  };

  // set up parent element and SVG
  let container = d3.select('#' + id);
  let svg = (isEmpty) ? container.append('svg') : container.select('svg');
  svg.attr('width',  w)
    .attr('height', h);

  let g = (isEmpty) ? svg.append('g') : svg.select('g');
  g.attr('transform','translate(' + margin.left + ',' + margin.top + ')');

  const width = svg.attr('width') - margin.left - margin.right;
  const height = svg.attr('height') - margin.top - margin.bottom;

  return {g, width, height};
}

const createScale = ({width, height}, data) => {
  const x = d3.scaleTime()
  .rangeRound([0, width])
  .domain(d3.extent(data, function(d) { return d.date; }));

  const y = d3.scaleLinear()
  .rangeRound([height, 0])
  .domain(d3.extent(data, function(d) { return d.close; }));

  return {x, y};
}

const renderAxes = ({g, width, height}, data, {x, y}, isEmpty) => {
  let xAxis = (isEmpty) ? g.append('g') : d3.select('.axis--x');
  xAxis.attr('class', 'axis axis--x')
  .attr('transform', 'translate(0,' + height + ')')
  .call(d3.axisBottom(x));

  let yAxis = (isEmpty) ? g.append('g') : g.select('.axis--y');
  yAxis.attr('class', 'axis axis--y')
  .attr('class', 'axis axis--y')
  .call(d3.axisLeft(y))
  .append('text')
  .attr('fill', '#000')
  .attr('transform', 'rotate(-90)')
  .attr('y', 6)
  .attr('dy', '0.71em')
  .style('text-anchor', 'end')
  .text('Price ($)');

  return {x, y};
}

const drawLine = ({g}, data, {x, y}, isEmpty) => {
  const line = d3.line()
    .x(function(d) { return x(d.date); })
    .y(function(d) { return y(d.close); });

  let path = (isEmpty) ? g.append('path') : d3.select('.line');
  path.datum(data)
    .attr('class', 'line')
    .attr('d', line);
}

export function Chart(options) {
  let opts = options;
  let data = formatData(opts.data);
  let element = document.getElementById(opts.id);
  let isEmpty = (element.innerHTML === '');
  let svg = getSVG(opts.id, element, isEmpty);
  let scale = createScale(svg, data);
  let axes = renderAxes(svg, data, scale, isEmpty);
  drawLine(svg, data, axes, isEmpty);

  return {
    updateSize: function ({w, h}) {
      let isEmpty = (element.innerHTML === '');
      svg = getSVG(opts.id, element, isEmpty);
      scale = createScale(svg, data);
      axes = renderAxes(svg, data, scale, isEmpty);
      drawLine(svg, data, axes, isEmpty);
    },
    updateData: function(data) {
      console.log('update: data: ', data);
    }
  };
}
