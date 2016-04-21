utf8 = require './8'
random = require './random'
assert = require './assert'
valid8 = require './valid8'

describe 'Long sequences', ->
  it 'are invalid', ->
    utf8.ranges max: 0x10FFFF, [5..6], bits: 32
    .forEach (range)->
      for i in [1..108]
        assert utf8.valid q = utf8 z = random.range range
        assert z == utf8.code q
        utf8.test4 false, q
      return

  it 'may be valid if needed', ->
    @skip() if 4 != valid8.maxBytes
    try
      valid8.maxBytes = 8

      # 4..6 are valid
      utf8.ranges [3..6]
      .forEach (range)->
        for i in [1..108]
          assert utf8.valid q = utf8 z = random.range range
          assert z == utf8.code q
          utf8.test4 true, q
        return

      # 7 still invalid
      utf8.ranges 6, bits: 32
      .forEach (range)->
        for i in [1..108]
          assert utf8.valid q = utf8 z = random.range range
          assert z == utf8.code q
          utf8.test4 false, q
        return

      # Very short sequences
      valid8.maxBytes = 2

      # 1 & 2 allowed
      utf8.ranges min: 0, [1..2]
      .forEach (range)->
        for i in [1..108]
          assert utf8.valid q = utf8 z = random.range range
          assert z == utf8.code q
          assert valid8 q
        return

      # 3... invalid
      utf8.ranges [2..6], bits: 32
      .forEach (range)->
        for i in [1..108]
          assert utf8.valid q = utf8 z = random.range range
          assert z == utf8.code q
          assert not valid8 q
        return

    finally
      valid8.maxBytes = 4
