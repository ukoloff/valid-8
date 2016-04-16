#
# Convert to UTF-8
#

module.exports =
utf8 = (code)->
  code &= 0xFFFFFFFF
  # ASCII ?
  return [code] unless code >> 7
  r = []
  mask = 5
  loop
    r.unshift code & 0x3F | 0x80
    code >>>= 6
    continue if code >> mask--
    r.unshift code | 256 - (1 << mask+2)
    return r
#
# Check whether all bits in a sequence set correctly
#
utf8.valid =
valid = (array)->

#
# Make overlong sequence from valid one
#
utf8.overlong = (array)->
  return unless valid array
  switch array.length
    when 1
      x = array[0]
      return [x >> 6 | 0xC0, x & 0x3F | 0x80]
    when 7
      return
    else
