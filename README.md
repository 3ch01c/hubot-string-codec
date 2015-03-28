# hubot-string-codec

A hubot script that encode/decode string

See [`src/string-codec.coffee`](src/string-codec.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install prototype-cafe/hubot-string-codec --save`

Then add **hubot-string-codec** to your `external-scripts.json`:

```json
["hubot-string-codec"]
```

## Sample Interaction

```
user1> hubot enc:base64 hello
Hubot> aGVsbG8=
user1> hubot dec:base64 aGVsbG8=
Hubot> hello

user1> hubot enc:md5 hello
Hubot> 5d41402abc4b2a76b9719d911017c592
user1> hubot dec:md5 5d41402abc4b2a76b9719d911017c592
Hubot> hello

user1> hubot enc:unixtime Fri Feb 20 2015 22:08:00 GMT+0900 (JST)
Hubot> 1424437680
user1> hubot dec:unixtime 1424437680
Hubot> Fri Feb 20 2015 22:08:00 GMT+0900 (JST)

user1> hubot enc helloworld
Hubot> encodings of helloworld
Hubot> hex: 68656c6c6f
Hubot> ascii:
Hubot> base64: aGVsbG8=
Hubot> base85: xK#0@zV
Hubot> z85: xK#0@zV
Hubot> ascii85: <~BOu!rDZ~>
Hubot> base91:
Hubot> rot5: hello
Hubot> rot13: uryyb
Hubot> rot18: uryyb
Hubot> rot47: 96==@
Hubot> rev: olleh
Hubot> crc1: 14
Hubot> crc8: 92
Hubot> crc16: 34d2
Hubot> crc24: 47f58a
Hubot> crc32: 3610a686
Hubot> adler32: 62c0215
Hubot> url: hello
Hubot> unixtime: NaN
Hubot> lower: hello
Hubot> upper: HELLO
Hubot> md4: 866437cb7a794bce2b727acc0362ee27
Hubot> md5: 5d41402abc4b2a76b9719d911017c592
Hubot> sha: ac62a630ca850b4ea07eda664eaecf9480843152
...
```

## Commands

```
hubot enc <string> - list various encoded strings
hubot enc:[algo] <string> - display string encode with specified algorithm
hubot enc:all <string> - list strings encode with all available algorithm
hubow enc:list - list of all available algorithm

hubot dec <string> - list various decoded strings
hubot dec:[algo] <string> - display string decode with specified algorithm
hubot dec:all <string> - list strings decode with all available algorithm
hubot dec:list - list of all available algorithm
```

## Available algorithm

### encode

hex, ascii, base64, base85 (z85), ascii85, base91, rot5/rot13/rot18/rot47,  
rev (reverse string), crc1/crc8/crc16/crc24/crc32, adler32, url (url encoding),  
unixtime, lower, upper, punycode, md4, md5, sha, sha1, sha224, sha256, sha384,  
sha512, rmd160, whirlpool

### decode

hex, ascii, base64, base85 (z85), ascii85, base91, rot5/rot13/rot18/rot47,  
rev, url, unixtime, punycode, md5

For further details, see [string-codec](https://github.com/knjcode/string-codec)
