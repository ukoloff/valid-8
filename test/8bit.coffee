utf8 = require './8'
random = require './random'
assert = require './assert'
valid8 = require './valid8'
newBuffer = require './buffer'

describe 'Random utf8 strings', ->
  it 'are valid', ->
    rnd = utf8.random
    for i in [1..108]
      assert valid8 newBuffer rnd 20

describe 'Single 8-bit value', ->
  it 'is invalid', ->
    test4 = utf8.test4
    for i in [1..108]
      test4 false, [random 128, 255]
