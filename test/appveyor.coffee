path = require 'path'

do intercept = ->
  R = require 'mocha'
    .Runner
  emit = R::emit
  runner = 0
  R::emit = ->
    delete R::emit
    listen @
    emit.apply @, arguments

events =
  pending: 'Ignored'
  pass:    'Passed'
  fail:    'Failed'

listen = (runner)->
  tests = []
  for k, v of events
    do (v)->
      runner.on k, (test)->
        tests.push
          testFramework: 'mocha'
          testName: test.fullTitle()
          fileName: path.relative '', test.file
          outcome: v
          durationMilliseconds: test.duration
          ErrorStackTrace: test.err?.stack
  runner.on 'end', ->
    console.log JSON.stringify tests
