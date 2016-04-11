module.exports = random = (min, max)->
  unless max?
    max = min
    min = 0
  Math.floor Math.random()*(max - min + 1) + min

random.pick = (array)->
  array[random array.length-1]
