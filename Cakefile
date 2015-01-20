task "build", "compile assets", ->
  copyVendorScripts()
  regenerateIcons()
  spawn "node_modules/.bin/coffee", ["-o", "public", "views/*.coffee"], stdio: 'inherit'
  spawn "node_modules/.bin/stylus", ["-o", "public", "views/*.styl"], stdio: 'inherit'
  spawn "node_modules/.bin/jade", ["-o", "public", "views/*.jade"], stdio: 'inherit'

task "watch", "compile assets on the fly", ->
  copyVendorScripts()
  regenerateIcons()
  spawn "node_modules/.bin/coffee", ["-o", "public", "-w", "views/"], stdio: 'inherit'
  spawn "node_modules/.bin/stylus", ["-o", "public", "-w", "views/"], stdio: 'inherit'
  spawn "node_modules/.bin/jade", ["-o", "public", "-w", "views/"], stdio: 'inherit'

task "icons", "rebuild the icons", ->
  regenerateIcons()

{spawn} = require 'child_process'

regenerateIcons = ->
  for x in [76, 120, 128, 152, 180, 512]
    spawn "convert", ["icon.png", "-resize", "#{x}x#{x}", "public/icon@#{x}.png"], stdio: 'inherit'

copyVendorScripts = ->
  spawn "cp", ["views/modernizr.js", "public/"], stdio: 'inherit'
  spawn "cp", ["node_modules/blueimp-md5/js/md5.js", "public/"], stdio: 'inherit'
