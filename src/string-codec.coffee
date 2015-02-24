# Description
#   A hubot script that encode/decode string
#
# Configuration:
#   None
#
# Commands:
#   hubot enc <str> - list encoded and hashed string
#   hubot enc:algo <str> - list encoded or hashed string by specified algorithm
#   hubot enc:all <str> - list all available encodings and hashes of string
#   hubow enc:list - list of all available algorithms
#
#   hubot dec <str> - list deocded and dehashed string if available
#   hubot dec:algo <str> - list specified algorithm decoded or unhashed string
#   hubot dec:all <str> - list all available decodings and unhashes of string
#   hubot dec:list - list of all available algorithms
#
# Author:
#   knjcode <knjcode@gmail.com>

crypto = require 'crypto'

allencoder = []
encalgos = ['hex', 'ascii', 'base64', 'rot13', 'rot47', 'rev', 'url',
            'unixtime']
enchashes = ['md4', 'md5', 'sha', 'sha1', 'sha224', 'sha256', 'sha384',
             'sha512', 'rmd160', 'whirlpool']
allenchashes = crypto.getHashes()
allencoder = allencoder.concat(encalgos,allenchashes)

alldecoder = []
decalgos = ['hex', 'ascii', 'base64', 'rot13', 'rot47', 'rev', 'url',
            'unixtime']
dechashes = []
alldecoder = alldecoder.concat(decalgos,dechashes)


module.exports = (robot) ->
  robot.respond /enc(:\w*)? (.*)?/i, (msg) ->
    algo = if msg.match[1] isnt undefined then msg.match[1] else ''
    str = if msg.match[2] isnt undefined then msg.match[2] else ''
    algo = algo[1..] if algo
    switch algo
      when 'all'
        for algo in allencoder
          msg.send algo + ': ' + encoder(str, algo)
      else
        if algo in encalgos
          msg.send encoder(str, algo)
        else if algo in allenchashes
          msg.send encoder(str, algo)
        else if algo is ''
          for algo in encalgos.concat(enchashes)
            msg.send algo + ': ' + encoder(str, algo)
        else
          msg.send algo + ' algorithm is not supported'

  robot.respond /dec(:\w*)? (.*)?/i, (msg) ->
    algo = if msg.match[1] isnt undefined then msg.match[1] else ''
    str = if msg.match[2] isnt undefined then msg.match[2] else ''
    algo = algo[1..] if algo
    switch algo
      when 'all'
        for algo in alldecoder
          msg.send algo + ': ' + decoder(str, algo)
      else
        if algo in decalgos
          msg.send decoder(str, algo)
        else if algo in dechashes
          msg.send decoder(str, algo)
        else if algo is ''
          for algo in alldecoder
            msg.send algo + ': ' + decoder(str, algo)
        else
          msg.send algo + ' algorithm is not supported'

  robot.respond /enc:list/i, (msg) ->
    msg.send allencoder.toString()

  robot.respond /dec:list/i, (msg) ->
    msg.send alldecoder.toString()


# hex parse helper
hex_parse = (str) ->
  if not (str.length % 2)
    str.replace(/0x|:/g, '')
  else
    false

# rot13 cipher
rot13 = (str) ->
  ret_str = ''
  code_A = 'A'.charCodeAt(0)
  code_a = 'a'.charCodeAt(0)
  code_N = 'N'.charCodeAt(0)
  code_n = 'n'.charCodeAt(0)
  code_Z = 'Z'.charCodeAt(0)
  code_z = 'z'.charCodeAt(0)
  for i in [0...str.length]
    code = str.charCodeAt(i)
    if (code_A<=code && code<code_N) || (code_a<=code && code<code_n)
      code = code + 13
    else if (code_N<=code && code<=code_Z) || (code_n<=code && code<=code_z)
      code = code - 13
    ret_str += String.fromCharCode(code)
  return ret_str

# LookupTable for rot47
LookupTable = []
for i in ['!'.charCodeAt(0)...'P'.charCodeAt(0)]
  LookupTable[String.fromCharCode(i)] = String.fromCharCode(i+47)
  LookupTable[String.fromCharCode(i+47)] = String.fromCharCode(i)

# rot47 cipher
rot47 = (str) ->
  ret_str = ''
  for i in [0...str.length]
    ret_str += LookupTable[str[i]]
  return ret_str

# reverse string
rev = (str) ->
  str.split('').reverse().join('')

# reciprocal cipher helper
recipro = {
  rot13: rot13,
  rot47: rot47,
  rev: rev
}

# encode helper
encoder = (str, algo) ->
  switch algo
    when 'hex', 'base64'
      new Buffer(str).toString(algo)
    when 'ascii'
      if hex = hex_parse(str)
        Buffer(hex, 'hex').toString('utf8')
    when 'rot13', 'rot47', 'rev'
      recipro[algo](str)
    when 'url'
      encodeURIComponent(str)
    when 'unixtime'
      Date.parse(str).toString(10)
    else
      if algo in allenchashes
        crypto.createHash(algo).update(str, 'utf8').digest('hex')

# decode helper
decoder = (str, algo) ->
  switch algo
    when 'hex'
      if not (str.length % 2)
        new Buffer(str, algo).toString('utf8')
    when 'base64'
      new Buffer(str, algo).toString('utf8')
    when 'ascii'
      new Buffer(str, algo).toString('hex')
    when 'rot13', 'rot47', 'rev'
      recipro[algo](str)
    when 'url'
      decodeURIComponent(str)
    when 'unixtime'
      new Date(parseInt(str)).toString('utf8')
    else
      return 'not implemented'

module.exports.encoder = encoder
module.exports.decoder = decoder
