R = require 'mocha'
  .Runner

emit = R::emit
runner = 0
R::emit = ->
  delete R::emit
  intercept @
  emit.apply @, arguments

intercept = (runner)->
  runner.on 'pending', (test)->
    console.log test.fullTitle()
