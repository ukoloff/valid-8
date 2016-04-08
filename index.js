this.maxBytes = 4;

this.isValidUTF8 = (function(_this) {
  return function(buffer) {
    var bits, code, i, j, len, mask, mode, n;
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
        if (!(code >> bits)) {
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
      bits = 5 * mode + 1;
    }
    if (mode) {
      return;
    }
    return true;
  };
})(this);
