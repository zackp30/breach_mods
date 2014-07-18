breach = require 'breach_module'
common = require './lib/common.js'
express = require 'express'
async = require 'async'
http = require 'http'


class Mod_Vim

  keybindings = (evt) ->
    console.log evt.type
    # modifier = (1 .<<. 1)
    # modifier_key = 17
    # if process.platform == 'darwin' # check whether we are on darwin
    #   modifier = (1 .<<. 3) # change keys appopiately
    #   modifier_key = 91
    #
    # ctrl = (1 .<<. 1) # ctrl
    # ctrl_key = 17




  bootstrap = (port) ->
    breach.init(->
      breach.expose('init', ((src, args, cb_) ->
        console.log 'mod_vim (Vimperator port for Breach)'
        console.log("Listening on #{port}")
        breach.module('core').on('tabs:keyboard', keybindings)
        breach.module('core').on('controls:keyboard', keybindings)
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
    http_srv = http.createServer(app).listen(2009, '127.0.0.1')
    http_srv.on('listening', (->
      port = http_srv.address().port
      bootstrap(port)
    ))

  setup()
