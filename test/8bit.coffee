assert = require 'assert'
valid8 = require '..'
random = require './random'

utf8 = random.utf8

describe 'Random utf8 strings', ->
  it 'are valid', ->
    for i in [1..27]
      assert valid8 r = new Buffer utf8 20
      assert not valid8 Buffer.concat [r, new Buffer [random 128, 255]]
