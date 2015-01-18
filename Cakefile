task "build", "compile assets", ->
  {exec} = require 'child_process'
  exec "node_modules/.bin/coffee -o public views/*.coffee"
  exec "node_modules/.bin/stylus -o public views/*.styl"
  exec "node_modules/.bin/jade -o public views/*.jade"

task "watch", "compile assets on the fly", ->
  {exec} = require 'child_process'
  exec "node_modules/.bin/coffee -o public -w views/"
  exec "node_modules/.bin/stylus -o public -w views/"
  exec "node_modules/.bin/jade -o public -w views/"
