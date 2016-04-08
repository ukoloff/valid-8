fs = require('fs')
coffee = require('coffee-script')

fs.writeFile(
  'index.js',
  coffee.compile(
    fs.readFileSync(
      'src/index.coffee',
      'utf-8'),
    {bare: true}),
  'utf-8')
