assert = require 'assert'
valid8 = require '..'

module.exports = random = (min, max)->
  unless max?
    max = min
    min = 0
  Math.floor Math.random()*(max - min + 1) + min

random.pick = (array)->
  array[random array.length-1]

bits = [7, 8, 11, 0xD7FF, '', 0xDFFF, 16, 0x10FFFF]
.map (bits)->
  if not bits or bits>0x100
    bits
  else
    (1 << bits) - 1
.reduce (ranges, n)->
  ranges.push
    min: ranges[ranges.length-1].max + 1
    max: n
  ranges
, [min: '', max: -1]
.filter (range)->
  'number' == typeof(range.min + range.max)

utf8 = random.utf8 = (n = 16)->
  r = []
  for i in [1..n]
    z = bits[random 0, bits.length - 1]
    r.push random z.min, z.max
  String.fromCharCode.apply String, r

describe 'Random utf8 strings', ->
  it 'are valid', ->
    for i in [1..27]
      assert valid8 r = new Buffer utf8 20
      assert not valid8 Buffer.concat [r, new Buffer random 128, 255]
