// Generated by CoffeeScript 1.4.0
(function() {
  var connect, connectNodes, connectable, createNodes, deletable, draggable, initPlumb, lastPos, lastWidth, placeNodes, replaceNodes, saveNodePos;

  $(function() {
    return $.getJSON('paths.php', function(data) {
      var nodes;
      createNodes(data[0]);
      nodes = $(".node");
      placeNodes(nodes);
      initPlumb(nodes);
      return connectNodes(data[1]);
    });
  });

  createNodes = function(nodes) {
    var n, _i, _len;
    for (_i = 0, _len = nodes.length; _i < _len; _i++) {
      n = nodes[_i];
      $('#tpl').clone().attr('id', n).appendTo(".topology");
    }
    return $('#tpl').remove();
  };

  connect = function(info) {
    var connection, text;
    connection = jsPlumb.connect({
      source: info.sourceID,
      target: info.destID,
      anchor: "Continuous",
      parameters: {
        info: info
      }
    });
    text = connection.sourceId + "->" + connection.targetId + ":" + info.timeDelay;
    return connection.getOverlay("label").setLabel(text);
  };

  connectNodes = function(paths) {
    var info, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = paths.length; _i < _len; _i++) {
      info = paths[_i];
      _results.push(connect(info));
    }
    return _results;
  };

  lastPos = null;

  lastWidth = null;

  saveNodePos = function(nodes) {
    var nodePos, pos;
    pos = {};
    nodes.each(function(i, e) {
      var $e;
      $e = $(e);
      return pos[$e.attr('id')] = $e.position();
    });
    nodePos = {
      lastPos: lastPos,
      lastWidth: lastWidth,
      pos: pos
    };
    return $.cookie('nodePos', nodePos);
  };

  placeNodes = function(nodes) {
    var currPos, currWidth, height, nodePos, num, p, percent, width;
    nodePos = $.cookie('nodePos');
    p = nodes.parent();
    lastPos = nodePos.lastPos;
    lastWidth = nodePos.lastWidth;
    currPos = p.position();
    currWidth = p.width();
    p.height(currWidth / 2 + 50);
    if (nodePos != null) {
      percent = currWidth / lastWidth;
      nodes.each(function(i, e) {
        var $e, pos;
        $e = $(e);
        pos = nodePos.pos[$e.attr('id')];
        percent = currWidth / lastWidth;
        return $e.css({
          top: (pos.top - lastPos.top) * percent + currPos.top,
          left: (pos.left - lastPos.left) * percent + currPos.left
        });
      });
      lastPos = currPos;
      lastWidth = currWidth;
    } else {
      width = currWidth / 2.35;
      height = width / 2;
      num = nodes.length;
      nodes.each(function(i, e) {
        var $e, pos;
        $e = $(e);
        pos = $e.position();
        return $e.css({
          top: pos.top + height * (Math.cos(6.28 * i / num) + 1),
          left: pos.left + width * (Math.sin(6.28 * i / num) + 1)
        });
      });
    }
    $(window).resize(function() {
      return replaceNodes(nodes);
    });
    return $(window).unload(function() {
      return saveNodePos(nodes);
    });
  };

  replaceNodes = function(nodes) {
    var currPos, currWidth, p, percent;
    p = nodes.parent();
    currPos = p.position();
    currWidth = p.width();
    if (currPos.left !== lastPos.left || currPos.top !== lastPos.top) {
      percent = currWidth / lastWidth;
      p.height(currWidth / 2 + 50);
      nodes.each(function(i, e) {
        var $e, pos;
        $e = $(e);
        pos = $e.position();
        return $e.css({
          top: (pos.top - lastPos.top) * percent + currPos.top,
          left: (pos.left - lastPos.left) * percent + currPos.left
        });
      });
      lastPos = currPos;
      lastWidth = currWidth;
      return jsPlumb.repaintEverything();
    }
  };

  initPlumb = function(nodes) {
    jsPlumb.importDefaults({
      Connector: "StateMachine",
      PaintStyle: {
        lineWidth: 3,
        strokeStyle: "#ccc"
      },
      Endpoint: [
        "Dot", {
          radius: 5
        }
      ],
      EndpointStyle: {
        fillStyle: "#ccc"
      },
      ConnectionOverlays: [
        [
          "Label", {
            location: 0.5,
            id: "label",
            cssClass: "label"
          }
        ]
      ]
    });
    return draggable(nodes);
  };

  connectable = function(nodes) {
    jsPlumb.makeSource(nodes, {
      anchor: "Continuous"
    });
    jsPlumb.makeTarget(nodes, {
      dropOptions: {
        hoverClass: "dragHover"
      },
      anchor: "Continuous"
    });
    jsPlumb.bind("beforeDrop", function(info) {
      info.nodes = prompt("Nodes", 10);
      $.ajax({
        url: 'paths',
        type: 'POST',
        dataType: 'json',
        data: {
          "path[sourceId]": info.sourceId,
          "path[targetId]": info.targetId,
          "path[nodes]": info.nodes
        },
        success: function(info) {
          return connect(info);
        }
      });
      return false;
    });
    return jsPlumb.bind("beforeDetach", function(c) {
      var info;
      info = c.getParameter('info');
      $.ajax({
        url: 'paths/' + info.id,
        type: 'DELETE',
        dataType: 'json'
      });
      return true;
    });
  };

  deletable = function(nodes) {
    return jsPlumb.bind("click", function(c) {
      return jsPlumb.detach(c);
    });
  };

  draggable = function(nodes) {
    return jsPlumb.draggable(nodes);
  };

}).call(this);