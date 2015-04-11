#Consistency <- make sure the API there doesn't change
#Security
#Communication between Modules

#<<CAN'T CHANGE LATTER!

Wings.sandbox = (moduleId, options, template) ->
  log: (message) -> console.log message, ", from sandbox!"
  notify: (eventId, data) -> Wings.events.emit eventId, data

#  subscribers: []
#  container: null
#  services: options.services || {}
#  getId: ->
#  getContainer: ->
#  getService: ->
#  getOption: ->
#  publish: publish
#  subscribe: ->
#  unsubscribe: ->
#  getTemplate: ->
#  setState: ->