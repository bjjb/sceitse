var express = require('express')
var morgan = require('morgan')
var nib = require('nib')
var path = require('path')
var app = express()
var pkg = require('./package.json')

app.set('view engine', 'jade')
app.set('views', path.join(__dirname, 'views'))

app.use(morgan('combined'))
console.log(app.get('views'))
app.use(express.static(path.join(__dirname, 'public')))

app.get('/', function(req, res) {
  res.render('index')
})

webapp = {
  name: pkg.name,
  version: pkg.version,
  description: pkg.description,
  launch_path: "/",
  developer: pkg.author,
  icons: {
    128: "/icon@128.png",
    512: "/icon@512.png"
  },
  default_locale: "en",
  fullscreen: true
}

app.get('/manifest.webapp', function(req, res) {
  res.set('Content-Type', 'application/x-web-app-manifest+json')
  res.end(JSON.stringify(webapp))
})

var server = app.listen(process.env.PORT || 3000, function() {
  var name = pkg.name
  var version = pkg.version
  var host = server.address().address
  var port = server.address().port
  console.log("%s v%s listening at %s:%s", name, version, host, port)
  var version = pkg.version
})
