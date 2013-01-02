levels =
  DEBUG : 1 << 0
  INFO : 1 << 1
  WARN : 1 << 2
  ERROR : 1 << 3
  FATAL : 1 << 4

levelNames = {}

for k,v of levels
  levelNames[v] = k

exports.formatter = (msg, category, level)->
  t = (new Date()).toISOString()
  msg = JSON.stringify(msg) unless typeof msg is 'string'
  "#{t} [#{level}] [#{category}] #{msg}"

exports.output = (msg)->
  msg = JSON.stringify(msg) unless typeof msg is 'string'
  console.log(msg)

exports.log = (msg, category, level)->
  ll = categoryLevels[category]
  ll ||= logLevel
  if (ll | level) is ll
    name = levelNames[level]
    msg = exports.formatter(msg, category, name)
    exports.output(msg)

for k,v of levels
  do(v)->
    exports[k] = v #convenience
    exports[k.toLowerCase()] = (msg, category)->
      exports.log(msg, category, v)

exports.levels = levels
exports.DEFAULT = levels.INFO | levels.WARN | levels.ERROR | levels.FATAL
exports.ALL = levels.DEBUG | levels.INFO | levels.WARN | levels.ERROR | levels.FATAL

logLevel = exports.DEFAULT
categoryLevels = {}

exports.logLevelToString = logLevelToString = (level)->
  level ||= logLevel
  current = []
  for k,v of levels
    current.push(k) if (level | v) is level

  current.join(" | ")

exports.resetLogLevels = (level)->
  categoryLevels = {}
  setLogLevel(level)

exports.setLogLevel = setLogLevel = (level, category)->
  old = logLevel
  if category?
    if categoryLevels[category]
      old = categoryLevels[category]

    exports.debug "Changing #{category} logLevel from #{old} (#{logLevelToString(old)}) to #{level} (#{logLevelToString(level)})", "logger"
    categoryLevels[category] = level
    old
  else
    exports.debug "Changing default logLevel from #{old} (#{logLevelToString(old)}) to #{level} (#{logLevelToString(level)})", "logger"
    logLevel = level
    old

exports.getLogLevel = getLogLevel = (category)->
  l = categoryLevels[category]
  l || logLevel

exports.forCategory = (name)->
  exports.log("Creating logger for #{name}", "logger", levels.DEBUG)
  log = (msg, level)->
    exports.log(msg, name, level)

  logger =
    log: log

  for k,v of levels
    do(v)->
      logger[k] = v
      logger[k.toLowerCase()] = (msg)->
        log(msg, v)

  logger.setLogLevel = (level)->
    setLogLevel(level, name)

  logger.getLogLevel = ()->
    getLogLevel(name)

  logger.ALL = exports.ALL
  logger.DEFAULT = exports.DEFAULT
  logger
