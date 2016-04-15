assert = require 'assert'

utf8 = require './28'
random = require './random'

describe 'UTF-8', ->
  it 'is generated correctly', ->
    for i in [1..108]
      z = random 0, 0xD7FF
      assert new Buffer(utf8 z).toString() == String.fromCharCode z
