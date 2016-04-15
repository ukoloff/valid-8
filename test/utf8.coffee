assert = require './assert'

utf8 = require './28'
random = require './random'

test8 = (z)->
  assert new Buffer(utf8 z).toString() == String.fromCharCode z

describe 'UTF-8', ->
  it 'is generated correctly', ->
    for i in [1..108]
      test8 random 0, 0xFF
      test8 random 0x100, 0x7FF
      test8 random 0x800, 0xD7FF
      test8 random 0xE000, 0xFFFF
