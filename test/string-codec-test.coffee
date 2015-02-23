assert = require 'power-assert'
sinon = require 'sinon'
codec = require '../src/string-codec'

encode_testset =
  'hex':
    'abc':'616263'
    'def':'646566'
    'ghi':'676869'
    'あいうえお':'e38182e38184e38186e38188e3818a'
  'ascii':
    '616263':'abc'
    '0x616263':'abc'
    '61:62:63':'abc'
  'base64':
    'abc':'YWJj'
    'def':'ZGVm'
    'ghi':'Z2hp'
  'rot13':
    'abc':'nop'
  'rot47':
    'abc':'234'
  'rev':
    'abc':'cba'
  'url':
    'あいうえお':'%E3%81%82%E3%81%84%E3%81%86%E3%81%88%E3%81%8A'
  'unixtime':
    'Sun Feb 22 2015 13:40:00 GMT+0900 (JST)':'1424580000000'
  'md4':
    'abc':'a448017aaf21d8525fc10ae87aa6729d'
  'md5':
    'abc':'900150983cd24fb0d6963f7d28e17f72'
  'sha':
    'abc':'0164b8a914cd2a5e74c4f7ff082c4d97f1edf880'
  'sha1':
    'abc':'a9993e364706816aba3e25717850c26c9cd0d89d'
  'sha512':
    'abc':'ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f'
  'rmd160':
    'abc':'8eb208f7e05d987a9b044a8e98c6b087f15a0bfc'
  'whirlpool':
    'abc':'4e2448a4c6f486bb16b6562c73b4020bf3043e3a731bce721ae1b303d97e6d4c7181eebdb6c57e277d0e34957114cbd6c797fc9d95d8b582d225292076d4eef5'
  'sha224':
    'abc':'23097d223405d8228642a477bda255b32aadbce4bda0b3f7e36c9da7'
  'sha256':
    'abc':'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad'
  'sha384':
    'abc':'cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7'
  'sha512':
    'abc':'ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f'

decode_testset =
  'hex':
    '616263':'abc'
    '646566':'def'
    '676869':'ghi'
    'あいうえお':'e38182e38184e38186e38188e3818a'
  'ascii':
    'abc':'616263'
  'base64':
    'YWJj':'abc'
    'ZGVm':'def'
    'Z2hp':'ghi'
  'rot13':
    'nop':'abc'
  'rot47':
    '234':'abc'
  'rev':
    'cba':'abc'
  'url':
    '%E3%81%82%E3%81%84%E3%81%86%E3%81%88%E3%81%8A':'あいうえお'
  # depends on local timezone
  # 'unixtime':
  #   '1424580000000':'Sun Feb 22 2015 13:40:00 GMT+0900 (JST)'


describe 'encode test', ->
  for algo, testset of encode_testset
    it algo + ' encode test', ->
      for key, value of testset
        assert codec.encoder(key, algo) == value

describe 'decode test', ->
  for algo, testset of decode_testset
    it algo + ' decode test', ->
      for key, value of testset
        assert codec.decoder(key, algo) == value

describe 'string-codec', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()
    @msg =
      send: sinon.spy()

    require('../src/string-codec')(@robot)

  it 'registers a respond enc listener', ->
    assert.ok(@robot.respond.calledWith(/enc(:\w*)? (.*)?/i))

  it 'registers a respond dec listener', ->
    assert.ok(@robot.respond.calledWith(/dec(:\w*)? (.*)?/i))

  it 'registers a respond enc:list listener', ->
    assert.ok(@robot.respond.calledWith(/enc:list/i))

  it 'registers a respond dec:list listener', ->
    assert.ok(@robot.respond.calledWith(/dec:list/i))
