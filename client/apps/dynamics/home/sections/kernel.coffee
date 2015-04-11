Wings.defineWidget 'kernel',
  messages: -> Schema.Message.find({parent: Session.get("currentChannel")?._id}, {sort: {createAt: 1}})
  avatarImg: -> "avatars/#{@creator}.jpg"
  messageCreator: -> Meteor.users.findOne(@creator)

  events:
    "keyup .messenger-input": (event, template) ->
      if event.which is 13 and currentChannel = Session.get("currentChannel")
        $message = $(event.currentTarget)
#        result = Model.Message.insert(currentChannel._id, $message.val(), currentChannel.channelType)
        Meteor.call 'sendMessage', currentChannel._id, $message.val(), currentChannel.channelType, (err, result) ->
          if result.valid then $message.val('') else console.log result.error