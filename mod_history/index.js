// Generated by CoffeeScript 1.7.1
(function() {
  var breach, common;

  breach = require('breach_module');

  common = require('./lib/common.js');

  breach.init(function() {
    breach.expose('init', (function(src, args, cb_) {
      console.log('mod_history (history support for breach)');
      return breach.module('core').call('set_title', {
        'title': 'ohey '
      });
    }));
    return breach.expose('kill', (function(args, cb_) {
      return common.exit(0);
    }));
  });

  process.on('uncaughtException', (function(err) {
    return common.fatal(err);
  }));

}).call(this);
