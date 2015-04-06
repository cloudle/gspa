Wings.register "testModule", (sandbox) ->
  init: ->
    sandbox.log "Hello world!"
    sandbox.notify("testInitialized", {message: "I'm initialized! I'm TestModule by the way."})

  sayHi: -> sandbox.log "Hi,"

Meteor.startup ->
  Wings.start "testModule"