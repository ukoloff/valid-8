#
# Get random from range
#
module.exports = random = (min, max)->
  unless max?
    max = min
    min = 0
  Math.floor Math.random()*(max - min + 1) + min

#
# Get random from range as object
#
random.range =
range = (range)->
  random range.min, range.max

#
# Pick random array element
#
random.pick =
pick = (array)->
  array[random array.length-1]
