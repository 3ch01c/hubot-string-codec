# Description
#   A hubot script that encode/decode string
#
# Configuration:
#   None
#
# Commands:
#   hubot enc <string> - list various encoded strings
#   hubot enc:[algo] <string> - display string encode with specified algorithm
#   hubot enc:all <string> - list strings encode with all available algorithm
#   hubow enc:list - list of all available algorithm
#
#   hubot dec <string> - list various decoded strings
#   hubot dec:[algo] <string> - display string decode with specified algorithm
#   hubot dec:all <string> - list strings decode with all available algorithm
#   hubot dec:list - list of all available algorithm
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
        replies = [ 'all encodings of ' + str ]
        for algo in codec.ENC_ALL
          replies.push algo + ': ' + codec.encoder(str, algo)
        msg.send replies.join '\n'
      else
        if algo in codec.ENC_ALL
          msg.send codec.encoder(str, algo)
        else if algo is ''
          replies = [ 'encodings of ' + str ]
          for algo in ENC_DEFAULT
            replies.push algo + ': ' + codec.encoder(str, algo)
          msg.send replies.join '\n'
        else
          msg.send algo + 'unknown algorithm'

  robot.respond /dec(:\w*)? (.*)?/i, (msg) ->
    algo = if msg.match[1] isnt undefined then msg.match[1] else ''
    str = if msg.match[2] isnt undefined then msg.match[2] else ''
    algo = algo[1..] if algo
    switch algo
      when 'all'
        replies = [ 'all decodings of ' + str ]
        for algo in codec.DEC_ALL
          replies.push algo + ': ' + codec.decoder(str, algo)
        msg.send replies.join '\n'
      else
        if algo in codec.DEC_ALL
          msg.send codec.decoder(str, algo)
        else if algo is ''
          replies = [ 'decodings of ' + str ]
          for algo in codec.DEC_ALL
            replies.push algo + ': ' + codec.decoder(str, algo)
          msg.send replies.join '\n'
        else
          msg.send algo + 'unknown algorithm'

  robot.respond /enc:list/i, (msg) ->
    msg.send codec.ENC_ALL.toString()

  robot.respond /dec:list/i, (msg) ->
    msg.send codec.DEC_ALL.toString()
