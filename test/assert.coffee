assert = require 'assert'

count = 0

module.exports = ->
  count++
  assert.apply @, arguments

after ->
  console.log "\nAssertions:", count
