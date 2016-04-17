assert = require './assert'

utf8 = require './8'
random = require './random'

test8 = (z)->
  assert new Buffer(a = utf8 z).toString() == String.fromCharCode z
  assert utf8.valid a
  assert z == utf8.code a

describe 'UTF-8', ->
  it 'is generated correctly', ->
    for i in [1..108]
      test8 random 0, 0xFF
      test8 random 0x100, 0x7FF
      test8 random 0x800, 0xD7FF
      test8 random 0xE000, 0xFFFF
