R = require 'mocha'
  .Runner

events =
  pending: '-'
  pass:    '+'
  fail:    '#'

emit = R::emit
runner = 0
R::emit = ->
  delete R::emit
  intercept @
  emit.apply @, arguments

intercept = (runner)->
  tests = []
  for k, v of events
    do (v)->
      runner.on k, (test)->
        tests.push
          test: test
          status: v
  runner.on 'end', ->
    for t in tests
      console.log t.status, t.test.fullTitle()
