fs = require 'fs'
path = require 'path'
expect = require 'expect.js'
isUtf8 = require '..'

describe 'Empty buffer', ->
  it 'is valid', ->
    expect isUtf8.isValidUTF8 new Buffer 0
    .to.be.ok()

describe 'ASCII', ->
  it 'is valid', ->
    for i in [0..0x7F]
      expect isUtf8.isValidUTF8 new Buffer [i]
      .to.be.ok()

    expect isUtf8.isValidUTF8 new Buffer [0x7F..0]
    .to.be.ok()

describe 'Cyrillic', ->
  it 'is valid', ->

    expect isUtf8.isValidUTF8 new Buffer 'Однажды в студёную зимнюю пору'
    .to.be.ok()

describe 'Glass', ->
  it 'is eatable', ->

    expect isUtf8.isValidUTF8 fs.readFileSync path.join __dirname, 'glass.html'
    .to.be.ok()

describe 'Coffee', ->
  it 'is drinkable', ->

    expect isUtf8.isValidUTF8 fs.readFileSync __filename
    .to.be.ok()
