###
Buffer.from polyfill
###
Buffer.from ||= (src)->
  new Buffer src
