Helper = require('hubot-test-helper')
chai = require 'chai'

expect = chai.expect

helper = new Helper('../src/nyaa-net.coffee')

describe 'nyaa-net', ->
  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  it 'try search', ->
    @room.user.say('alice', 'nyaa search nyaa 1 5').then =>
      console.log @room.messages
