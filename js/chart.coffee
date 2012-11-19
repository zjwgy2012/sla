$ ->
    # Prepare the chart data
    sin = []
    cos = [];
    for i in [0..29]
        sin.push([i/2, Math.sin(i/2)])
        cos.push([i/2, Math.cos(i/2)])


    # Make chart
    data = [
        data: sin
        label: "sin(x)"
        color: "#BA1E20"
    ,
        data: cos
        label: "cos(x)"
        color: "#459D1C"
    ]
    options =
        series:
            lines:
                show: true
            points:
                show: true
        grid:
            hoverable: true
            clickable: true
        yaxis:
            min: -1.6
            max: 1.6

    plot = $.plot($(".chart"), data, options)
    
    # Point hover in chart
    previousPoint = null;
    $(".chart").bind "plothover", (event, pos, item) ->
        if item
            if previousPoint != item.dataIndex
                previousPoint = item.dataIndex
                
                $('.tip').fadeOut 200, ->
                    $(@).remove()

                x = item.datapoint[0].toFixed(2)
                y = item.datapoint[1].toFixed(2)
                    
                tooltip(item.pageX, item.pageY,item.series.label + " of " + x + " = " + y)
        else
            $('.tip').fadeOut 200, ->
                $(@).remove()
            previousPoint = null    
    

# Tooltip for flot charts
tooltip = (x, y, contents) ->
    $('<div id="tooltip" class="tip">' + contents + '</div>').css
        top: y + 5
        left: x + 5
    .appendTo("body").fadeIn(200)

