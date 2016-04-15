#
# Convert to UTF-8
#

module.exports =
utf8 = (code)->
  code &= 0xFFFF
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
