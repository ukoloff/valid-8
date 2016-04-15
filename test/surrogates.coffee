utf8 = require './28'
random = require './random'
valid8 = require '..'

describe 'Surrogates', ->
  it 'are invalid', ->
    for i in [1..108]
      random.test4  false, utf8 random 0xD800, 0xDFFF

  it 'may be valid if needed', ->
    @skip() if false != valid8.surrogates
    try
      valid8.surrogates = true
      for i in [1..108]
        random.test4  true, utf8 random 0xD800, 0xDFFF
    finally
      valid8.surrogates = false
