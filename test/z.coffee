R = require 'mocha'
  .Runner

events =
  pending: 'Ignored'
  pass:    'Passed'
  fail:    'Failed'

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
          testFramework: 'mocha'
          testName: test.fullTitle()
          fileName: test.file
          outcome: v
          durationMilliseconds: test.duration
          ErrorStackTrace: test.err?.stack
  runner.on 'end', ->
    console.log JSON.stringify tests
