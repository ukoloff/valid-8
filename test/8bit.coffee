assert = require './assert'
random = require './random'
utf8 = require './8'
valid8 = require './valid8'

describe 'Random utf8 strings', ->
  it 'are valid', ->
    rnd = utf8.random
    for i in [1..108]
      assert valid8 new Buffer rnd 20

describe 'Single 8-bit value', ->
  it 'is invalid', ->
    test4 = utf8.test4
    for i in [1..108]
      test4 false, [random 128, 255]
