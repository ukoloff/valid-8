fs = require 'fs'
path = require 'path'
expect = require 'expect.js'
valid8 = require '..'

describe 'Empty buffer', ->
  it 'is valid', ->
    expect valid8 new Buffer 0
    .to.be.ok()

describe 'ASCII', ->
  it 'is valid', ->
    for i in [0..0x7F]
      expect valid8 new Buffer [i]
      .to.be.ok()

    expect valid8 new Buffer [0x7F..0]
    .to.be.ok()

describe 'Cyrillic', ->
  it 'is valid', ->

    expect valid8 new Buffer 'Однажды в студёную зимнюю пору'
    .to.be.ok()

describe 'Glass', ->
  it 'is eatable', ->

    expect valid8 fs.readFileSync path.join __dirname, 'glass.html'
    .to.be.ok()

describe 'Coffee', ->
  it 'is drinkable', ->

    expect valid8 fs.readFileSync __filename
    .to.be.ok()
