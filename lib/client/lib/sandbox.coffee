#Consistency <- make sure the API there doesn't change
#Security
#Communication between Modules

#<<CAN'T CHANGE LATTER!

Module "Wings.sandbox",
  log: (message) -> console.log message, ", from sandbox!"
  notify: (eventId, data) -> Wings.events.emit eventId, data