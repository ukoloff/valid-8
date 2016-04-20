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
      # ...
    finally
      valid8.maxBytes = 4
