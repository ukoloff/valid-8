#
# Convert to UTF-8
#

module.exports =
utf8 = (code)->
  code &= 0xFFFFFFFF
  # ASCII ?
  return [code] unless code >> 7
  buffer = []
  mask = 5
  loop
    buffer.unshift code & 0x3F | 0x80
    code >>>= 6
    break unless code >> mask--
  # First byte
  buffer.unshift code | 256 - (1 << mask+2)
  return buffer

#
# Check whether all bits in a sequence set correctly
#
utf8.valid =
valid = (buffer)->
  x = buffer.length
  return unless 0 < x < 8
  if 1==x
    # ASCII?
    return !(buffer[0] >> 7)
  # First byte
  return if buffer[0] >>> 7 - x != (1 << x) - 1 << 1
  for i in [1..x]
    # Continuation?
    return if buffer[i-1] >> 6 != 2
  true

#
# Make overlong sequence from valid one
#
utf8.overlong = (buffer)->
  return unless valid buffer
  switch x = buffer.length
    when 1
      x = buffer[0]
      return [x >> 6 | 0xC0, x & 0x3F | 0x80]
    when 7
      return
  # Add first byte to multi-byte
  buffer = [].slice buffer
  buffer[0] &= 0xFF
  buffer.unshift 0xC0
  buffer
