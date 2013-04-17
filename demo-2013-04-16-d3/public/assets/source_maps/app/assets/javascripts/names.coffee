window.app =
  svg: null
  pusher: null
  channel: null
  people: []
  ready: ->
    $('svg').on('click', 'circle', app.remove_person)
    $('svg').on('click', 'text', app.remove_person)
    app.svg = d3.select('svg')
    app.pusher = app.pusher = new Pusher('3a852337fd2551e668fc')
    app.channel = app.pusher.subscribe('meetup')
    app.channel.bind('person_created', app.person_created)
    app.channel.bind('person_removed', app.person_removed)
  person_created: (person) ->
    person.r = Number.random(10, 100)
    person.cx = Number.random(0, 1200)
    person.cy = Number.random(0, 500)
    app.people.push(person) if app.people.none( (p) -> p.name == person.name)
    circles = app.svg.selectAll('circle').data(app.people, (p) -> p.name)
    circles.enter().append('circle')
                   .attr('r', 0)
                   .attr('cx', (p) -> p.cx)
                   .attr('cy', (p) -> p.cy)
                   .transition()
                   .duration(250)
                   .attr('r', (p) -> p.r)
                   .style('fill', (p) -> p.color)
                   .text((p) -> p.name)

    boxes = app.svg.selectAll('text').data(app.people, (p) -> p.name)
    boxes.enter().append('text')
                   .attr('x', (p) -> p.cx)
                   .attr('y', (p) -> p.cy)
                   .text((p) -> p.name)
  remove_person: ->
    name = $(this).text()
    settings =
      dataType: 'script'
      type: "get"
      url: "/remove_person?name=#{name}"
    $.ajax(settings)
  person_removed: (person) ->
    app.people.remove (p) -> p.name == person.name

    circles = app.svg.selectAll('circle').data(app.people, (p) -> p.name)
    circles.exit()
                   .transition()
                   .duration(250)
                   .attr('r', 0)
                   .remove()

    boxes = app.svg.selectAll('text').data(app.people, (p) -> p.name)
    boxes.exit().remove()

$(document).ready(app.ready)
