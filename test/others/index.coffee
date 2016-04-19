#
# Substitute library to test
#

libs =
  "is-utf8": -> @
  "utf-8-validate": -> @Validation.isValidUTF8

fn = libs[lib = process.env.npm_config_lib] or libs[lib = Object.keys(libs)[0]]

console.log "Testing library: #{lib}"

module.exports = fn.call require lib
