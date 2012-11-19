$ ->
  $.getJSON 'paths.php', (data) ->
    # NOTE here we are just using getSelector so we don't have to rewrite the code for each of the supported libraries.
    # you can just use the approriate selector from the library you're using, if you want to. like $(".shape) on jquery, for example.
    createNodes(data[0])

    nodes = $(".node")
    placeNodes(nodes)
    initPlumb(nodes)

    connectNodes(data[1])  


createNodes = (nodes) ->
  for n in nodes
    $('#tpl').clone().attr('id', n).appendTo(".topology")
  $('#tpl').remove()

connect = (info) ->
  connection = jsPlumb.connect
    source: info.sourceID  # just pass in the current node in the selector for source 
    target: info.destID
    # here we supply a different anchor for source and for target, and we get the element's "data-shape"
    # attribute to tell us what shape we should use, as well as, optionally, a rotation value.
    anchor: "Continuous"
    parameters:
      info: info

  text = connection.sourceId + "->" + connection.targetId + ":" + info.timeDelay
  connection.getOverlay("label").setLabel(text)

connectNodes = (paths) ->
  # loop through them and connect each one to each other one.
  for info in paths          
    connect(info)

lastPos = null
lastWidth = null
saveNodePos = (nodes) ->
  pos = {}
  nodes.each (i, e) ->
    $e = $(e)
    pos[$e.attr('id')] = $e.position()

  nodePos =
    lastPos: lastPos
    lastWidth: lastWidth
    pos: pos

  $.cookie('nodePos', nodePos)

placeNodes = (nodes) ->
  nodePos = $.cookie('nodePos')

  p = nodes.parent()
  lastPos = nodePos.lastPos
  lastWidth = nodePos.lastWidth
  currPos = p.position()
  currWidth = p.width()
  p.height(currWidth / 2 + 50)

  if nodePos?
    percent = currWidth / lastWidth
    nodes.each (i, e) ->
      $e = $(e)
      pos = nodePos.pos[$e.attr('id')]
      percent = currWidth / lastWidth
      $e.css
        top: (pos.top - lastPos.top) * percent + currPos.top
        left: (pos.left - lastPos.left) * percent + currPos.left
    
    lastPos = currPos
    lastWidth = currWidth
  else
    width = currWidth / 2.35
    height = width / 2
    num = nodes.length

    nodes.each (i, e) ->
      $e = $(e)
      pos = $e.position()
      $e.css
        top: pos.top + height * (Math.cos(6.28*i/num) + 1)
        left: pos.left + width * (Math.sin(6.28*i/num) + 1)

  $(window).resize ->
    replaceNodes(nodes)

  $(window).unload ->
    saveNodePos(nodes)

replaceNodes = (nodes) ->
  p = nodes.parent()
  currPos = p.position()
  currWidth = p.width()

  if currPos.left != lastPos.left or currPos.top != lastPos.top
    percent = currWidth / lastWidth
    p.height(currWidth / 2 + 50)

    nodes.each (i, e) ->
      $e = $(e)
      pos = $e.position()
      $e.css
        top: (pos.top - lastPos.top) * percent + currPos.top
        left: (pos.left - lastPos.left) * percent + currPos.left

    lastPos = currPos
    lastWidth = currWidth
    jsPlumb.repaintEverything()

initPlumb = (nodes) ->
  jsPlumb.importDefaults
    Connector: "StateMachine"
    PaintStyle: 
      lineWidth: 3
      strokeStyle: "#ccc"
    Endpoint: ["Dot", {radius: 5}]
    EndpointStyle: 
      fillStyle: "#ccc"
    # the overlays to decorate each connection with.  note that the label overlay uses a function to generate the label text; in this
    # case it returns the 'labelText' member that we set on each connection in the 'init' method below.
    ConnectionOverlays: [
    #   ["Arrow", {location: 0.9}],
      ["Label", {location: 0.5, id: "label", cssClass: "label"}]
    ]

  draggable(nodes)

connectable = (nodes) ->
  # make eps sources
  jsPlumb.makeSource nodes, 
    anchor: "Continuous"

  # make nodes targets
  jsPlumb.makeTarget nodes, 
    dropOptions:
      hoverClass: "dragHover"
    anchor: "Continuous"

  # create connection
  jsPlumb.bind "beforeDrop", (info) ->
    info.nodes = prompt("Nodes", 10)
    $.ajax
      url: 'paths'
      type: 'POST'
      dataType: 'json'
      data:
        "path[sourceId]": info.sourceId
        "path[targetId]": info.targetId
        "path[nodes]": info.nodes
      success: (info) ->
        connect(info)
    false

  # remove connection
  jsPlumb.bind "beforeDetach", (c) ->
    info = c.getParameter('info')
    $.ajax
      url: 'paths/' + info.id
      type: 'DELETE'
      dataType: 'json'
    true

deletable = (nodes) ->
  # click to detach
  jsPlumb.bind "click", (c) -> 
    jsPlumb.detach(c)
  

draggable = (nodes) ->
  # make everything draggable
  jsPlumb.draggable(nodes)
  
