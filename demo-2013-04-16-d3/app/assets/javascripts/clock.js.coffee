window.app =
  svg: null
  tick: ->
    second = moment().format('s').toNumber()
    numbers = [0..second]
    height = $('svg').css('height').toNumber()
    rects = app.svg.selectAll('rect').data(numbers)
    rects.enter().append('rect')
                 .attr('width', 50)
                 .attr('height', 10)
                 .attr('x', (d) -> (d%5) * 100)
                 .attr('y', 0)
                 .style('fill', 'red')
                 .transition()
                 .duration(250)
                 .attr('y', (d) -> height - 10 - (Math.floor(d/5) * 30))
                 .style('fill', 'black')
    rects.exit()
                 .transition()
                 .duration(250)
                 .attr('y', 0)
                 .style('fill', 'red')
                 .remove()
  ready: ->
    app.svg = d3.select('svg')
    setInterval(app.tick, 1000)

$(document).ready(app.ready)
