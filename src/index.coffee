module.exports = fn = (buffer)->
  mode = 0  # First byte
  for n, i in buffer
    if mode
      # Continuation: 10xxxxxx
      return if 0x80 != (0xC0 & n)
      code = code<<6 | n & 0x3F
      continue if --mode
      # Too big?
      return if fn.maxBytes<5 and code>0x0010FFFF
      # Exclude?
      return if !fn.surrogates and 0xD800<=code<=0xDFFF
      # Overlong?
      return unless code >> mask
      continue

    # ASCII: 0xxxxxxx
    continue unless n & 0x80
    # 8 bytes, 7 bytes (avoid 64-bit math), overlong 2 bytes (2 cases)
    return if n in [0xFF, 0xFE, 0xC0, 0xC1]
    # Continuation: 10xxxxxx
    return unless n & 0x40
    mode = 1
    mask = 0x20
    while n & mask
      mask >>= 1
      mode++
    return if mode >= fn.maxBytes
    code = n & mask-1
    mask = 5*mode + 1

  # Unfinished
  return if mode
  # Valid!!!
  true

#-- Configruration

fn.isValidUTF8 = fn # Emulate utf-8-validate

#
# Maximum length allowed. Can be set to 5 or 6 (or to 1, 2 or 3)
#
fn.maxBytes = 4

#
# Allow Unicode surrogates (0xD800-0xDFFF)
#
fn.surrogates = false

#-- That's all folks
