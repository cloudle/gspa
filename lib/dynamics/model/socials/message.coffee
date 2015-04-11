class Model.Message
  @MessageTypes:
    direct  : 1
    channel : 2
    group   : 3

  constructor: (doc) -> @[key] = value for key, value of doc
  @insert: (parent, message, messageType, separator = true) ->
    newMessage = { creator: Meteor.userId(), parent: parent, message: message, messageType: messageType, separator: separator }
    Wings.IRUS.insert(Schema.Message, newMessage, Wings.Validators.Social.messageInsert)