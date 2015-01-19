Sceitse = (element, options = {}) ->
  canvas = document.createElement('canvas')
  element.appendChild(canvas)

  [_painting, _savepoints, _x, _y, _d] = [false, [], [], [], []]

  mouseup = (event) ->
    _painting = false

  mouseleave = (event) ->
    _painting = false

  mousedown = (event) ->
    _painting = true
    _savepoints.push(_x.length)
    [x, y] = [event.pageX - @offsetLeft, event.pageY - @offsetTop]
    paint(x, y)

  mousemove = (event) ->
    return unless _painting
    [x, y] = [event.pageX - @offsetLeft, event.pageY - @offsetTop]
    paint(x, y, true)

  touchstart = (event) ->
    mousedown.call(@, touch) for touch in event.touches
    
  touchmove = (event) ->
    event.preventDefault()
    mousemove.call(@, touch) for touch in event.touches

  touchend = (event) ->
    mouseup.call(@, touch) for touch in event.touches

  paint = (x, y, d = false) ->
    _x.push(x)
    _y.push(y)
    _d.push(d)
    redraw()

  redraw = ->
    context = canvas.getContext('2d')
    context.clearRect(0, 0, canvas.width, canvas.height)
    context.strokeStyle = 'green'
    context.lineJoin = 'round'
    context.lineWidth = 5
    max = _x.length
    for i in [0...max]
      context.beginPath()
      if _d[i] and i
        context.moveTo(_x[i-1], _y[i-1])
      else
        context.moveTo(_x[i] - 1, _y[i])
      context.lineTo(_x[i], _y[i])
      context.closePath()
      context.stroke()

  drawImage = (data) ->
    context = canvas.getContext('2d')
    image = new Image(canvas.width, canvas.height)
    image.src = data
    context.clearRect(0, 0, canvas.width, canvas.height)
    context.drawImage(image)

  undo = ->
    savepoint = _savepoints.pop()
    return unless savepoint?
    _x = _x[0...savepoint]
    _y = _y[0...savepoint]
    _d = _d[0...savepoint]
    redraw()

  if Modernizr.touch and navigator.maxTouchPoints isnt 0
    canvas.addEventListener('touchstart', touchstart)
    canvas.addEventListener('touchmove', touchmove)
    canvas.addEventListener('touchend', touchend)
  else
    canvas.addEventListener('mousedown', mousedown)
    canvas.addEventListener('mousemove', mousemove)
    canvas.addEventListener('mouseup', mouseup)
    canvas.addEventListener('mouseleave', mouseleave)

  resize = ->
    padding = options.padding or 15
    element.style.padding = "#{padding}px"
    canvas.width = window.innerWidth - padding * 2
    canvas.height = window.innerHeight - padding * 2
    redraw()

  window.addEventListener 'resize', resize
  resize()

  x: _x
  y: _y
  d: _d
  getData: -> canvas.toDataURL()
  setData: drawImage
  undo: undo

document.addEventListener 'DOMContentLoaded', ->
  sceitse = new Sceitse(@querySelector('#sceitse'), padding: 15)
