// Generated by CoffeeScript 1.10.0
(function() {
  var valid8;

  valid8 = function(buffer) {
    var code, i, j, len, mask, mode, n;
    mode = 0;
    for (i = j = 0, len = buffer.length; j < len; i = ++j) {
      n = buffer[i];
      if (mode) {
        if (0x80 !== (0xC0 & n)) {
          return;
        }
        code = code << 6 | n & 0x3F;
        if (--mode) {
          continue;
        }
        if (valid8.maxBytes < 5 && code > 0x0010FFFF) {
          return;
        }
        if (!valid8.surrogates && (0xD800 <= code && code <= 0xDFFF)) {
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
      if (n === 0xFF || n === 0xFE || n === 0xC0 || n === 0xC1) {
        return;
      }
      if (!(n & 0x40)) {
        return;
      }
      mode = 1;
      mask = 0x20;
      while (n & mask) {
        mask >>= 1;
        mode++;
      }
      if (mode >= valid8.maxBytes) {
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

  valid8.isValidUTF8 = valid8;

  valid8.maxBytes = 4;

  valid8.surrogates = false;

  if (typeof module !== "undefined" && module !== null ? module.exports : void 0) {
    module.exports = valid8;
  } else if ('function' === typeof define && define.amd) {
    define(function() {
      return valid8;
    });
  } else {
    (function() {
      return this.valid8 = valid8;
    })();
  }

}).call(this);
