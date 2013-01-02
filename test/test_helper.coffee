exports.noggin = noggin = require('../src')

logCatcher = (msg)->
  exports.captured.push(msg)

exports.resetLogs = ()->
  exports.captured = []
  noggin.output = logCatcher

exports.resetLogs()

exports.reset = ()->
  exports.resetLogs()
  noggin.resetLogLevels(noggin.DEFAULT)

beforeEach ->
  exports.reset()
