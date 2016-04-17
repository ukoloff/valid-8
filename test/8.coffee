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
  for i in [2..x]
    # Continuation?
    return if buffer[i-1] >> 6 != 2
  true

#
# Make overlong sequence from valid one
#
utf8.overlong =
overlong = (buffer)->
  return unless valid buffer
  switch x = buffer.length
    when 1
      x = buffer[0]
      return [x >> 6 | 0xC0, x & 0x3F | 0x80]
    when 7
      return
  # Add first byte to multi-byte
  buffer = [].slice.call buffer
  x = 1 << 7 - x
  buffer[0] &= 0x7F + x
  buffer.unshift 0x100 - x
  buffer

#
# Generate all overlongs
#
utf8.overlongs = (code)->
  code = utf8 code if 'number'==typeof code
  code while code = overlong code

#
# Find codepoint for valid sequence
#
utf8.code = (buffer)->
  return unless valid buffer
  return buffer[0] if 1==buffer.length
  for n, i in buffer
    code = if i
      code << 6 | n & 0x3F
    else
      n & (1 << 7 - buffer.length) - 1
  code
