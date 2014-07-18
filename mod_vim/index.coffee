breach = require 'breach_module'
common = require './lib/common.js'
express = require 'express'
async = require 'async'
http = require 'http'


class Mod_Vim


  bootstrap = (port) ->
    breach.init(->
      breach.expose('init', ((src, args, cb_) ->
        console.log 'mod_vim (Vimperator port for Breach)'
        console.log("Listening on #{port}")
      ))
      breach.expose('kill', ((args, cb_) ->
        common.exit 0
      ))
    )
    process.on('uncaughtException', ((err) ->
      common.fatal err
    ))

  setup = ->
    app = express()

    app.use '/', express.static(__dirname + '/controls')
    http_srv = http.createServer(app).listen(0, '127.0.0.1')
    http_srv.on('listening', (->
      port = http_srv.address().port
      bootstrap(port)
    ))

  setup()
