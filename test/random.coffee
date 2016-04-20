assert = require './assert'
valid8 = require './valid8'

module.exports = random = (min, max)->
  unless max?
    max = min
    min = 0
  Math.floor Math.random()*(max - min + 1) + min

#
# Pick random array element
#
random.pick =
pick = (array)->
  array[random array.length-1]

#
# Generate intervals array
#
random.ranges =
ranges = (array)->
  array
  .map (x)->
    if 'number' == typeof x
      max: (2 << x - 1) - 1 >>> 0
    else if !x
      skip: true
    else
      x
  .reduce (ranges, x, i)->
    if i > 1
      prev = ranges[ranges.length-1].b
    else
      prev = ranges
      ranges = []
    ranges.push
      a: prev
      b: x
    ranges
  .filter (x)->
    !x.a.skip and !x.b.skip
  .map (x)->
    min: x.a.min ? x.a.max + 1
    max: x.b.max ? x.b.min - 1

#
# Ranges used for UTF-8 random strings
#
bits = ranges [max: 0, 7, 8, 11, min: 0xD800, false, max: 0xDFFF, 16, max: 0x10FFFF]

#
# Generate random UTF-8 string
#
random.utf8 = utf8 = (n = 16)->
  z = for i in [1..n]
    z = pick bits
    random z.min, z.max
  String.fromCharCode.apply String, z

#
# Wrap fragment with random strings and test
#
random.test4 = (good, buffer)->
  buffer = new Buffer buffer  unless Buffer.isBuffer buffer
  for z in [0..3]
    x = [buffer]
    x.unshift new Buffer utf8 27  if x & 1
    x.push new Buffer utf8 27  if x & 2
    x = valid8 Buffer.concat x
    x = !x unless good
    assert x
  return
