noggin
======

A Javascript logging utility supporting log levels and categories. It outputs nicely formatted console messages with no configuration

## Installation
`npm install noggin`

## Usage  (CoffeeScript)
```coffeescript
logger = require('noggin')
logger.setLogLevel(noggin.ALL)
logger.info "Log level is now #{noggin.logLevelToString(noggin.ALL)}"
#2013-01-02T03:31:32.242Z [DEBUG] [logger] Log level is now DEBUG | INFO | WARN | ERROR | FATAL

logger.debug "WAT?! NO"
#2013-01-02T03:31:32.242Z [DEBUG] WAT?! NO

logger.error "Database message", 'database'
#2013-01-02T03:31:32.242Z [ERROR] [database] Database message
```

## Category wrapped logger (CoffeeScript)
```coffeescript
logger = require('noggin').forCategory('database')

logger.setLogLevel(noggin.ALL)
logger.info "Log level for database category is now #{noggin.logLevelToString(noggin.ALL)}"
#2013-01-02T03:31:32.242Z [DEBUG] [database] Log level for database is now DEBUG | INFO | WARN | ERROR | FATAL

logger.error 'Database message'
#2013-01-02T03:31:32.242Z [ERROR] [database] Database message

```

## Override the default formatter
```coffeescript
logger = require('noggin')

#json output
logger.formatter = (msg, category, level)->
  msg =
    time: new Date()
    category: category
    level: level
    message: msg

logger.info "This is a message", "sys"
#{"time":"2013-01-02T03:31:32.242Z","category":"sys","level":"INFO","message":"This is a message"}
```

## Change output target
```coffeescript
logger = require('noggin')

#post it somewhere
logger.output = (msg)->
  ImaginaryHTTP.post("http://localhost/logsink", msg)
```
