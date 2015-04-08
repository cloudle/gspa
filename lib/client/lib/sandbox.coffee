#Consistency <- make sure the API there doesn't change
#Security
#Communication between Modules

#<<CAN'T CHANGE LATTER!

publish = ->


Module "Wings.sandbox", (moduleId, options, template) ->
  subscribers: []
  container: null
  services: options.services || {}
  getId: ->
  getContainer: ->
  getService: ->
  getOption: ->
  publish: publish
  subscribe: ->
  unsubscribe: ->
  getTemplate: ->
  setState: ->

  log: (message) -> console.log message, ", from sandbox!"
  notify: (eventId, data) -> Wings.events.emit eventId, data