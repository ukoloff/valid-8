utf8 = require './28'
random = require './random'

describe 'Surrogates', ->
  it 'are invalid', ->
    for i in [1..108]
      random.test4  false, utf8 random 0xD800, 0xDFFF
