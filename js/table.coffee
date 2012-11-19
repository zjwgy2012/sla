$ ->
  $.getJSON 'paths.php', (data) ->
    $('.data-table').dataTable
      sDom: "<'row-fluid'<'span6'f><'span6'p>r>t<'row-fluid'>"
      sPaginationType: "bootstrap"
      aaData: parseData(data[1])
  
  plot = null
  data = null
  options = 
    series: 
      shadowSize: 0 # drawing is faster without shadows
    yaxis: 
      min: 0
      max: 100
    xaxis:
      show: false
  update = ->
    plot.setData([getRandomData()])
    # since the axes don't change, we don't need to call plot.setupGrid()
    plot.draw()
  pre = null
  getRandomData = ->
    # do a random walk
    pre = data[0]
    data = data[1..]
    data.push(pre + Math.random() * 50 - 25)

    # zip the generated y values with the x values
    res = []
    for d, i in data
      res.push([i, d])
    res

  index = null
  $('#modal').on 'shown', ->
    data = (50 for num in [1..100])
    plot = $.plot($("#plot-chart"), [getRandomData()], options)
    index = setInterval(update, 50)
  $('#modal').on 'hidden', ->
    clearInterval(index)
    

    
parseData = (data) ->
  array = []
  for d in data
    array.push [
      d.sourceID
      d.destID
      d.timeDelay
      "<a data-toggle=\"modal\" data-target=\"#modal\"><i class=\"icon-zoom-in\"></i></a>"
    ]
  array
