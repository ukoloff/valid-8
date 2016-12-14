utf8 = require './8'
random = require './random'
valid8 = require './valid8'

describe 'Surrogates', ->
  it 'are invalid', ->
    for i in [1..108]
      utf8.test4  false, utf8 random 0xD800, 0xDFFF
    return

  it 'may be valid if needed', ->
    @skip() if false != valid8.surrogates
    try
      valid8.surrogates = true
      for i in [1..108]
        utf8.test4  true, utf8 random 0xD800, 0xDFFF
      return
    finally
      valid8.surrogates = false
