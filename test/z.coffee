mocha = require 'mocha'

before ->
  # console.log "BEFORE", @runnable
  emit = mocha.Runner::emit
  runner = 0
  mocha.Runner::emit = ->
    runner = @
    runner.on 'pending', (test)->
      console.log test.fullTitle()
    delete mocha.Runner::emit
    emit.apply @, arguments
