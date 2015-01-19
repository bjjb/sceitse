
Sceitse = (canvas) ->
  [_painting, _savepoints, _x, _y, _d] = [false, [], [], [], []]

  mouseup = (event) ->
    return if touchAvailable
    _painting = false
    canvas.classList.remove 'painting'

  mouseleave = (event) ->
    return if touchAvailable
    _painting = false
    canvas.classList.remove 'painting'

  mousedown = (event) ->
    return if touchAvailable
    _painting = true
    _savepoints.push(_x.length)
    canvas.classList.add 'painting'
    [x, y] = [event.pageX - @offsetLeft, event.pageY - @offsetTop]
    paint(x, y)

  mousemove = (event) ->
    return if touchAvailable
    return unless _painting
    [x, y] = [event.pageX - @offsetLeft, event.pageY - @offsetTop]
    paint(x, y, true)

  touchstart = (event) ->
    return unless touchAvailable
    _painting = true
    canvas.classList.add 'painting'
    console.log "TOUCH START", event

  touchmove = (event) ->
    return unless touchAvailable
    console.log "TOUCH MOVE", event

  touchend = (event) ->
    return unless touchAvailable
    _painting = false
    canvas.classList.remove 'painting'
    console.log "TOUCH END", event

  paint = (x, y, d = false) ->
    _x.push(x)
    _y.push(y)
    _d.push(d)
    redraw()

  context = canvas.getContext('2d')
  context.strokeStyle = 'green'
  context.lineJoin = 'round'
  context.lineWidth = 5

  redraw = ->
    context.clearRect(0, 0, canvas.width, canvas.height)
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

  resize = (width, height) ->
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight

  canvas.addEventListener('mousedown', mousedown)
  canvas.addEventListener('mousemove', mousemove)
  canvas.addEventListener('mouseup', mouseup)
  canvas.addEventListener('mouseleave', mouseleave)
  canvas.addEventListener('touchstart', touchstart)
  canvas.addEventListener('touchmove', touchmove)
  canvas.addEventListener('touchend', touchend)

  x: _x
  y: _y
  d: _d
  getData: -> canvas.toDataURL()
  setData: drawImage
  undo: undo
  resize: resize

touchAvailable = 'ontouchstart' in window
document.addEventListener 'DOMContentLoaded', ->
  touchAvailable = window.ontouchstart isnt undefined
  sceitse = new Sceitse(@querySelector('canvas#sceitse'))
  console.log touchAvailable
window.Sceitse = Sceitse
