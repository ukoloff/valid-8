intercept = ->
  R = require 'mocha'
    .Runner
  emit = R::emit
  runner = 0
  R::emit = ->
    delete R::emit
    listen @
    emit.apply @, arguments

do intercept if api = process.env.APPVEYOR_API_URL

post = (data, path)->
  url = require 'url'
  http = require 'http'
  uri = url.parse api
  data = JSON.stringify data
  uri.method = 'POST'
  uri.agent = false
  uri.path = path
  uri.pathname = path
  uri.headers =
    'Content-Type': 'application/json'
    # 'Content-Length': data.length
  q = http.request uri, (res)->
    console.log "POST response"
    res.pipe process.stdout
  q.on 'error', ->
    console.error 'HTTP error!'
  q.end data

events =
  pending: 'Ignored'
  pass:    'Passed'
  fail:    'Failed'

listen = (runner)->
  path = require 'path'
  tests = []
  for k, v of events
    do (v)->
      runner.on k, (test)->
        post
          testFramework: 'mocha'
          testName: test.fullTitle()
          fileName: path.relative '', test.file
          outcome: v
          durationMilliseconds: test.duration
          ErrorMessage: test.err?.message
          ErrorStackTrace: test.err?.stack
          '/api/tests'
