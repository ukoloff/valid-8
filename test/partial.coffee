utf8 = require './8'
random = require './random'
assert = require './assert'
valid8 = require '..'

describe 'Trimmed sequences', ->
  it 'are invalid', ->

slices = (array, fn)->
  for z, i in array
    z = array.slice i
    z.pop() unless i
    while z.length
      fn? z
      z.pop()
  return

slices "1 2 3 4 5".split(' '), (a)->console.log a
