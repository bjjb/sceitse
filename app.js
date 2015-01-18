var express = require('express')
var morgan = require('morgan')
var nib = require('nib')
var path = require('path')
var app = express()

app.set('view engine', 'jade')
app.set('views', path.join(__dirname, 'views'))

app.use(morgan('combined'))
console.log(app.get('views'))
app.use(express.static(path.join(__dirname, 'public')))

app.get('/', function(req, res) {
  res.render('index')
})

var server = app.listen(process.env.PORT || 3000, function() {
  var name = require('./package').name
  var host = server.address().address
  var port = server.address().port
  console.log("%s listening at %s:%s", name, host, port)
})
