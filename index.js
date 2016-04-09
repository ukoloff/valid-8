this.maxBytes = 4;

this.exclude = true;

this.isValidUTF8 = (function(_this) {
  return function(buffer) {
    var code, i, j, len, mask, mode, n;
    mode = 0;
    for (i = j = 0, len = buffer.length; j < len; i = ++j) {
      n = buffer[i];
      if (mode) {
        if (0xC0 !== (0xC0 & n)) {
          return;
        }
        code = code << 6 | n & 0x3F;
        if (--mode) {
          continue;
        }
        if (_this.maxBytes < 5 && code > 0x0010FFFF) {
          return;
        }
        if (_this.exclude && (0xD800 <= code && code <= 0xDFFF)) {
          return;
        }
        if (!(code >> mask)) {
          return;
        }
        continue;
      }
      if (!(n & 0x80)) {
        continue;
      }
      if (n === 0xFF || n === 0xFE || n === 0xC0) {
        return;
      }
      if (!(n & 0x40)) {
        return;
      }
      code = 0;
      mode = 1;
      mask = 0x20;
      while (n & mask) {
        mask >>= 1;
        mode++;
      }
      if (mode >= _this.maxBytes) {
        return;
      }
      code = n & mask - 1;
      mask = 5 * mode + 1;
    }
    if (mode) {
      return;
    }
    return true;
  };
})(this);
