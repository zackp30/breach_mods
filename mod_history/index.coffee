breach = require 'breach_module'
common = require './lib/common.js'


# doStuff = ->
#   breach.set_title "Ohey"

breach.init(->
  breach.expose('init', ((src, args, cb_) ->
    console.log 'mod_history (history support for breach)'
    breach.module('core').call('set_title', { 'title': 'ohey '})

  ))
  breach.expose('kill', ((args, cb_) ->
    common.exit 0
  ))
)
process.on('uncaughtException', ((err) ->
  common.fatal err
))
