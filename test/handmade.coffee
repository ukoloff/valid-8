fs = require 'fs'
path = require 'path'
assert = require 'assert'
valid8 = require '..'

describe 'Empty buffer', ->
  it 'is valid', ->
    assert valid8 new Buffer 0

describe 'ASCII', ->
  it 'is valid', ->
    for i in [0..0x7F]
      assert valid8 new Buffer [i]

    assert valid8 new Buffer [0x7F..0]

describe 'Cyrillic', ->
  it 'is valid', ->

    assert valid8 new Buffer 'Однажды в студёную зимнюю пору'

describe 'Glass', ->
  it 'is eatable', ->

    assert valid8 fs.readFileSync path.join __dirname, 'glass.html'

describe 'Coffee', ->
  it 'is drinkable', ->

    assert valid8 fs.readFileSync __filename
