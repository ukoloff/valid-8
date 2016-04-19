utf8 = require './8'
random = require './random'
assert = require './assert'
valid8 = require './valid8'

describe 'Long sequences', ->
  it 'are invalid', ->
    (5*i+1 for i in [5..6])
    .concat [32]
    .map (bits)->
      (2 << bits - 1) - 1 >>> 0
    .reduce (ranges, n)->
      res = if ranges.length
        ranges
      else
        []
      res.push
        max: n
        min: if ranges.length
          ranges[ranges.length - 1].max
        else
          ranges
      res
    .forEach (range)->
       for i in [1..108]
         z = random range.min+1, range.max
         assert utf8.valid q = utf8 z
         assert z == utf8.code q
         random.test4 false, q

  it 'may be valid if needed', ->
    @skip() if 4 != valid8.maxBytes
    try
      valid8.maxBytes = 8
      # ...
    finally
      valid8.maxBytes = 4
