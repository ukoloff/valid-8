# valid-8

[![Build Status](https://travis-ci.org/ukoloff/valid-8.svg?branch=master)](https://travis-ci.org/ukoloff/valid-8)
[![npm version](https://badge.fury.io/js/valid-8.svg)](https://badge.fury.io/js/valid-8)
[![Bower version](https://badge.fury.io/bo/valid-8.svg)](https://badge.fury.io/bo/valid-8)

Pure JavaScript implementation of UTF-8 validation.

To be drop-in replacement for `utf-8-validate`.

Most time and efforts were spent to develop extensive test suite.

## Testing

Tests are run using mocha with regular command:

```sh
npm test
```
Many [non-obvious aspects](https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-test.txt)
of UTF-8 validation are tested, including:

  - UTF surrogates
  - long sequences
  - overlong sequences
  - incomplete sequences

### Testing other libraries

To test other UTF-8 validation libraries, first install them

```sh
cd test/others
npm install
cd ../..
```
and then run test, eg:

```sh
npm test --lib=utf-8-validate
```

or:

```sh
npm test --lib=is-utf8
```

### Speed

Validation speed is measured during test. So far this validator is *fastest*
(this is not a joke!).

  * `valid-8`: 300 Mb/s (pure JavaScript)
  * `utf-8-validate`: 260 Mb/s (C++)
  * `is-utf8`: 110 Mb/s (pure JavaScript either)

## API

Validation is simple:

```js
valid8 = require('valid-8')

if(!valid8(new Buffer('你好，世界！')))
{
  // ...
}
```

For compatibility with `utf-8-validate` `valid8.Validation.isValidUTF8 === validate8`.

By default, `valid8` rejects UTF surrogates (0xD800-0xDFFF) and codepoints
higher than 0x10FFFF, according to UTF specification.

One can force UTF surrogates to pass test setting `valid8.surrogates = true`.

To allow long sequences (say, 5 or 6 bytes), set `validate8.maxBytes` to `5` or `6`.
7-byte sequences will always be rejected. By default `validate8.maxBytes=4`,
and can be set to 1, 2 or 3 either. Eg, set `validate8.maxBytes=2` to disable
Chinese ideograms (and many other symbols).

## Rivals

  * [utf-8-validate](https://github.com/websockets/utf-8-validate), C++
  * [is-utf8](https://github.com/wayfind/is-utf8), pure JavaScript

## See also

  * [The Hateful Eight](http://www.imdb.com/title/tt3460252/)
