utf8 = require './8'
random = require './random'
assert = require './assert'
valid8 = require './valid8'

describe 'Long sequences', ->
  it 'are invalid', ->
    utf8.ranges [].concat(5*i+1 for i in [5..6]).concat [32]
    .forEach (range)->
       for i in [1..108]
         assert utf8.valid q = utf8 z = random.range range
         assert z == utf8.code q
         utf8.test4 false, q

  it 'may be valid if needed', ->
    @skip() if 4 != valid8.maxBytes
    try
      valid8.maxBytes = 8
      # 4..6 are valid
      utf8.ranges [].concat(5*i+1 for i in [4..7])
      .forEach (range)->
         for i in [1..108]
           assert utf8.valid q = utf8 z = random.range range
           assert z == utf8.code q
           utf8.test4 true, q
      # 7 still invalid
      utf8.ranges [6*5+1, 32]
      .forEach (range)->
         for i in [1..108]
           assert utf8.valid q = utf8 z = random.range range
           assert z == utf8.code q
           utf8.test4 false, q
      # ...
    finally
      valid8.maxBytes = 4
