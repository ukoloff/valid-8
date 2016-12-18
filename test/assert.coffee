assert = require 'assert'
appveyor = require './appveyor'

count = 0

module.exports = ->
  count++
  assert.apply @, arguments

after? ->
  console.log ""
  appveyor.log "Assertions: #{count}"
