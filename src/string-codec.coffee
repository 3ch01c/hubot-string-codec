# Description
#   A hubot script that encode/decode string
#
# Configuration:
#   None
#
# Commands:
#   hubot enc <str> - list default encodings of string
#   hubot enc:algo <str> - display encoded string by specified algorithm
#   hubot enc:all <str> - list all available encodings of string
#   hubow enc:list - list of all available algorithms
#
#   hubot dec <str> - list default decodings of string
#   hubot dec:algo <str> - display decoded string by specified algorithm
#   hubot dec:all <str> - list all available decodings of string
#   hubot dec:list - list of all available algorithms
#
# Author:
#   knjcode <knjcode@gmail.com>

codec = require 'string-codec'

enchashes = ['md4', 'md5', 'sha', 'sha1', 'sha224', 'sha256', 'sha384',
             'sha512', 'rmd160', 'whirlpool']
ENC_DEFAULT = codec.ENC_ALGOS.concat(enchashes)

module.exports = (robot) ->
  robot.respond /enc(:\w*)? (.*)?/i, (msg) ->
    algo = if msg.match[1] isnt undefined then msg.match[1] else ''
    str = if msg.match[2] isnt undefined then msg.match[2] else ''
    algo = algo[1..] if algo
    switch algo
      when 'all'
        msg.send 'all encodings of ' + str
        for algo in codec.ENC_ALL
          msg.send algo + ': ' + codec.encoder(str, algo)
      else
        if algo in codec.ENC_ALL
          msg.send codec.encoder(str, algo)
        else if algo is ''
          msg.send 'encodings of ' + str
          for algo in ENC_DEFAULT
            msg.send algo + ': ' + codec.encoder(str, algo)
        else
          msg.send algo + 'unknown algorithm'

  robot.respond /dec(:\w*)? (.*)?/i, (msg) ->
    algo = if msg.match[1] isnt undefined then msg.match[1] else ''
    str = if msg.match[2] isnt undefined then msg.match[2] else ''
    algo = algo[1..] if algo
    switch algo
      when 'all'
        msg.send 'all decodings of ' + str
        for algo in codec.DEC_ALL
          msg.send algo + ': ' + codec.decoder(str, algo)
      else
        if algo in codec.DEC_ALL
          msg.send codec.decoder(str, algo)
        else if algo is ''
          msg.send 'decodings of ' + str
          for algo in codec.DEC_ALL
            msg.send algo + ': ' + codec.decoder(str, algo)
        else
          msg.send algo + 'unknown algorithm'

  robot.respond /enc:list/i, (msg) ->
    msg.send codec.ENC_ALL.toString()

  robot.respond /dec:list/i, (msg) ->
    msg.send codec.DEC_ALL.toString()
