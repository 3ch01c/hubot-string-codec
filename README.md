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
user1>> hubot enc:base64 prototype-cafe
hubot>> cHJvdG90eXBlLWNhZmU=

user1>> hubot dec:base64 cHJvdG90eXBlLWNhZmU=
hubot>> prototype-cafe

user1>> hubot enc:unixtime Fri Feb 20 2015 22:08:00 GMT+0900 (JST)
hubot>> 1424437680000
user1>> hubot dec:unixtime 1424437680000
hubot>> Fri Feb 20 2015 22:08:00 GMT+0900 (JST)

user1>> hubot enc:rfc1924 2001:db8:100:f101::1
hubot>> 9R}vSQZ1W=8fRv3*HAqn
user1>> hubot dec:rfc1924 9R}vSQZ1W=8fRv3*HAqn
hubot>> 2001:db8:100:f101::1

user1>> hubot enc helloworld
hubot>> hex: 68656c6c6f776f726c64
hubot>> ascii:
hubot>> base64: aGVsbG93b3JsZA==
hubot>> ascii85: <~BOu!rDg-,?Ch*~>
hubot>> base91:
hubot>> rot13: uryybjbeyq
hubot>> rot47: 96==@H@C=5
hubot>> rev: dlrowolleh
hubot>> z85: xK#0@z*cbuy?9
hubot>> rfc1924: false
hubot>> url: helloworld
hubot>> unixtime: NaN
hubot>> md4: 793033db97268fc9ceebde269797e54b
hubot>> md5: fc5e038d38a57032085441e7fe7010b0
hubot>> sha: c8b442aacaa1afa67cf37d38f01df3d21f50d1a3
hubot>> sha1: 6adfb183a4a2c94a2f92dab5ade762a47889a5a1
hubot>> sha224: b033d770602994efa135c5248af300d81567ad5b59cec4bccbf15bcc
hubot>> sha256: 936a185caaa266bb9cbe981e9e05cb78cd732b0b3280eb944412bb6f8f8f07af
hubot>> sha384: 97982a5b1414b9078103a1c008c4e3526c27b41cdbcf80790560a40f2a9bf2ed4427ab1428789915ed4b3dc07c454bd9
hubot>> sha512: 1594244d52f2d8c12b142bb61f47bc2eaf503d6d9ca8480cae9fcf112f66e4967dc5e8fa98285e36db8af1b8ffa8b84cb15e0fbcf836c3deb803c13f37659a60
hubot>> rmd160: 8a73c5438c28e79e696144fa869886f240cfaddb
hubot>> whirlpool: 807fb49ba72ce04205dc9bbfbc3481f189f8b1730571b6f588001ec4f37b97e12bc8cefd03598dace3c1118221bf3af78a8f5958c0f59c848af9bc8a6034ea7e
```

## TODO

Implement hash decoder, omakase decoder

## Acknowledgements

- @_rintaro_f
- basE91 based on [mscdex/base91.js](https://github.com/mscdex/base91.js)
- Ascii85/z85/rfc1924 based on [noseglid/base85](https://github.com/noseglid/base85)
- crc1/crc8/crc16/crc24/crc32 [alexgorbatchev/node-crc](https://github.com/alexgorbatchev/node-crc)
- adler32 [SheetJS/js-adler32](https://github.com/SheetJS/js-adler32)
