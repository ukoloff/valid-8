utf8 = require './8'
random = require './random'
assert = require './assert'
valid8 = require './valid8'

describe 'Overlongs', ->
  it 'are invalid', ->
    utf8.ranges min: 0, [1..6]
    .forEach (range)->
      for i in [1..27]
        assert utf8.valid q = utf8 z = random.range range
        assert z == utf8.code q
        utf8.overlongs q
        .forEach (overlong)->
          assert utf8.valid overlong
          assert z == utf8.code overlong
          utf8.test4 false, overlong
