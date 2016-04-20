assert = require './assert'
valid8 = require './valid8'
random = require './random'

describe 'Random utf8 strings', ->
  it 'are valid', ->
    utf8 = random.utf8
    for i in [1..108]
      assert valid8 new Buffer utf8 20

describe 'Single 8-bit value', ->
  it 'is invalid', ->
    test4 = random.test4
    for i in [1..108]
      test4 false, [random 128, 255]
