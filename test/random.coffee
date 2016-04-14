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

random.utf8 = (n = 16)->
  z = for i in [1..n]
    z = bits[random 0, bits.length - 1]
    random z.min, z.max
  String.fromCharCode.apply String, z
