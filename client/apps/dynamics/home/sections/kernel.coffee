Wings.defineWidget 'kernel',
  messages: -> Schema.Message.find({parent: Session.get("currentChannel")?._id}, {sort: {createAt: 1}})
  avatarImg: -> "avatars/#{@creator}.jpg"
  events:
    "keyup .messenger-input": (event, template) ->
      if event.which is 13 and currentChannel = Session.get("currentChannel")
        $message = $(event.currentTarget)
        result = Model.Message.insert(currentChannel._id, $message.val(), currentChannel.channelType)

        if result.valid
          $message.val('')
        else
          console.log result.error