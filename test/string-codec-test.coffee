assert = require 'power-assert'
sinon = require 'sinon'

describe 'string-codec', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()
    @msg =
      send: sinon.spy()

    require('../src/string-codec')(@robot)

  it 'registers a respond enc listener', ->
    assert.ok(@robot.respond.calledWith(/enc(:.*)? (.*)?/i))

  it 'registers a respond dec listener', ->
    assert.ok(@robot.respond.calledWith(/dec(:.*)? (.*)?/i))

  it 'registers a respond enc:list listener', ->
    assert.ok(@robot.respond.calledWith(/enc:list/i))

  it 'registers a respond dec:list listener', ->
    assert.ok(@robot.respond.calledWith(/dec:list/i))
