utf8 = require './8'
random = require './random'
assert = require './assert'
valid8 = require '..'

describe 'Trimmed sequences', ->
  it 'are invalid', ->
    utf8.ranges [7].concat(5*i+1 for i in [2..6]).concat [32]
    .forEach (range)->
      for i in [1..12]
        assert utf8.valid q = utf8 z = random.range range
        assert z == utf8.code q
        slices q, (slice)->
          assert not utf8.valid slice
          utf8.test4 false, slice

slices = (array, fn)->
  for z, i in array
    z = array.slice i
    z.pop() unless i
    while z.length
      fn? z
      z.pop()
  return
