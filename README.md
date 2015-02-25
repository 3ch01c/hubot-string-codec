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
hubot>> crc1: 3c
hubot>> crc8: d2
hubot>> crc16: cdd3
hubot>> crc24: 4d1aa7
hubot>> crc32: f9eb20ad
hubot>> adler32: 1736043d
hubot>> url: helloworld
hubot>> unixtime: NaN
hubot>> md4: 793033db97268fc9ceebde269797e54b
hubot>> md5: fc5e038d38a57032085441e7fe7010b0
hubot>> sha: c8b442aacaa1afa67cf37d38f01df3d21f50d1a3
...
```

## Supported specifications

### encoder

|algorithm|input|output|
|:--|:--|:--|
|hex|string|hex string|
|ascii|hex string|string|
|base64|string|base64|
|ascii85 (base85)|string|ascii85|
|base91|hex string|string|
|ro13|string|string|
|rot47|string|string|
|rev (reverse string)|string|string|
|z85|string|z85|
|rfc1924 (base85 IPv6)|IPv6 address|base85 IPv6 string|
|crc1/crc8/crc16<br>crc24/crc32|string|crc checksum|
|adler32|string|adler32|
|url (url encoding)|string|url encode|
|unixtime|date string|unix timestamp|
|md4|string|md4|
|md5|string|md5|
|sha|string|sha|
|sha1|string|sha1|
|sha224|string|sha224|
|sha256|string|sha256|
|sha384|string|sha384|
|sha512|string|sha512|
|rmd160|string|rmd160|
|whirlpool|string|whirlpool|

Others:  
DSA,DSA-SHA,DSA-SHA1,DSA-SHA1-old,RSA-MD4,RSA-MD5,RSA-MDC2,RSA-RIPEMD160,  
RSA-SHA,RSA-SHA1,RSA-SHA1-2,RSA-SHA224,RSA-SHA256,RSA-SHA384,RSA-SHA512,  
dsaEncryption,dsaWithSHA,dsaWithSHA1,dss1,ecdsa-with-SHA1,md4WithRSAEncryption,  
md5WithRSAEncryption,mdc2,mdc2WithRSA,ripemd,ripemd160,ripemd160WithRSA,  
sha1WithRSAEncryption,sha224WithRSAEncryption,sha256WithRSAEncryption,  
sha384WithRSAEncryption,sha512WithRSAEncryption,shaWithRSAEncryption,ssl2-md5,  
ssl3-md5,ssl3-sha1

### decoder

|algorithm|input|output|
|:--|:--|:--|
|hex|hex string|string|
|ascii|string|hex string|
|base64|base64|string|
|ascii85|ascii85|string|
|base91|base91|hex string|
|rot13|string|string|
|rot47|string|string|
|rev|string|string|
|z85|z85|string|
|rfc1924|base85 IPv6 string|IPv6 address|
|url|url encode|string|
|unixtime|unix timestamp|date string|

## TODO

Implement hash decoder, omakase decoder

## Acknowledgements

- @_rintaro_f
- basE91 based on [mscdex/base91.js](https://github.com/mscdex/base91.js)
- Ascii85/z85/rfc1924 based on [noseglid/base85](https://github.com/noseglid/base85)
- crc1/crc8/crc16/crc24/crc32 [alexgorbatchev/node-crc](https://github.com/alexgorbatchev/node-crc)
- adler32 [SheetJS/js-adler32](https://github.com/SheetJS/js-adler32)
