utf8 = require './8'
random = require './random'
assert = require './assert'
valid8 = require './valid8'

describe 'Overlongs', ->
  it 'are invalid', ->
    random.ranges [min: 0, 7].concat(5*i+1 for i in [2..6])
    .forEach (range)->
      for i in [1..27]
        assert utf8.valid q = utf8 z = random.range range
        assert z == utf8.code q
        utf8.overlongs q
        .forEach (overlong)->
          assert utf8.valid overlong
          assert z == utf8.code overlong
          random.test4 false, overlong
