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

user1>> hubot enc helloworld
hubot>> hex: 68656c6c6f776f726c64
hubot>> ascii:
hubot>> base64: aGVsbG93b3JsZA==
hubot>> rot13: uryybjbeyq
hubot>> rot47: 96==@H@C=5
hubot>> rev: dlrowolleh
hubot>> url: helloworld
hubot>> unixtime: NaN
hubot>> md5: fc5e038d38a57032085441e7fe7010b0
hubot>> sha: c8b442aacaa1afa67cf37d38f01df3d21f50d1a3
hubot>> sha1: 6adfb183a4a2c94a2f92dab5ade762a47889a5a1
hubot>> sha256: 936a185caaa266bb9cbe981e9e05cb78cd732b0b3280eb944412bb6f8f8f07af
hubot>> sha512: 1594244d52f2d8c12b142bb61f47bc2eaf503d6d9ca8480cae9fcf112f66e4967dc5e8fa98285e36db8af1b8ffa8b84cb15e0fbcf836c3deb803c13f37659a60
hubot>> rmd160: 8a73c5438c28e79e696144fa869886f240cfaddb
hubot>> whirlpool: 807fb49ba72ce04205dc9bbfbc3481f189f8b1730571b6f588001ec4f37b97e12bc8cefd03598dace3c1118221bf3af78a8f5958c0f59c848af9bc8a6034ea7e
```

## TODO

Implement sha2, hash decoder, omakase decoder

## Acknowledgements

@_rintaro_f
