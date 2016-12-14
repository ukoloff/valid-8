assert = require './assert'

utf8 = require './8'
random = require './random'

describe 'UTF-8', ->
  it 'is generated correctly', ->
    utf8.ranges
      min: 0
      [1..2]
      min: 0xD800
      false
      max: 0xDFFF
      3
    .forEach (range)->
      for i in [1..108]
        assert utf8.valid q = utf8 z = random.range range
        assert z == utf8.code q
        assert Buffer.from(q).toString() == String.fromCharCode z
      return
