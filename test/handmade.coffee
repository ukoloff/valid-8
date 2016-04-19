fs = require 'fs'
path = require 'path'
assert = require './assert'
valid8 = require '..'
random = require './random'

buffers = []
longBuffer = 0

test = (buffer)->
  buffer = new Buffer buffer unless Buffer.isBuffer buffer
  buffers.push buffer = buffer
  assert valid8 buffer

describe 'Empty buffer', ->
  it 'is valid', ->
    test 0

describe 'ASCII', ->
  it 'is valid', ->
    for i in [0..0x7F]
      test Buffer [i]

    test [0x7F..0]

describe 'Cyrillic', ->
  it 'is valid', ->

    test 'Однажды в студёную зимнюю пору'

describe 'Glass', ->
  it 'is edible', ->

    test longBuffer = fs.readFileSync path.join __dirname, 'glass.html'

describe 'Coffee', ->
  it 'is drinkable', ->

    test fs.readFileSync __filename

describe "Pile of poo", ->
  it "is valid either", ->
    test "💩" # "\u{1F4A9}"    # https://mathiasbynens.be/notes/javascript-unicode

describe "Buffer", ->
  it "is inspected entirely", ->
    for b in buffers
      assert not valid8 Buffer.concat [
        b,
        new Buffer [random 128, 255]
      ]
      assert not valid8 Buffer.concat [
        b,
        new Buffer [random 128, 255],
        random.pick buffers
      ]
    buffers = []

describe 'Speed', ->

  @slow 1000

  it 'is found', ->
    start = new Date
    n = 0
    loop
      unless valid8 longBuffer
        throw Error 'Unexpected fail'
      t = new Date - start
      n++
      it "", ->
      if n > 100 and t > 100
        break
    longBuffer = longBuffer.length * n * 1000 / t / 1024 / 1024


after ->
  console.log "Validation speed: #{longBuffer} Mb/s"
