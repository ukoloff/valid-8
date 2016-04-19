utf8 = require './8'
random = require './random'
assert = require './assert'
valid8 = require './valid8'

describe 'Overlongs', ->
  it 'are invalid', ->
    [7]
    .concat(5*i+1 for i in [2..6])
    .reduce (ranges, n)->
      ranges.push
        max: 1 << n >>> 0
        min: if ranges.length
          ranges[ranges.length - 1].max - 1
        else
          0
      ranges
    , []
    .forEach (range)->
      for i in [1..27]
        z = random range.min, range.max - 1
        assert utf8.valid q = utf8 z
        assert z == utf8.code q
        utf8.overlongs q
        .forEach (overlong)->
          assert utf8.valid overlong
          assert z == utf8.code overlong
          random.test4 false, overlong
