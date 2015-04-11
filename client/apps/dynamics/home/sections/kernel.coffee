Wings.defineWidget 'kernel',
  messages: -> Schema.Message.find({parent: Session.get("currentChannel")?._id}, {sort: {createAt: 1}})
  avatarImg: -> "avatars/#{@creator}.jpg"
  events:
    "keyup .messenger-input": (event, template) ->
      if event.which is 13 and currentChannel = Session.get("currentChannel")
        $message = $(event.currentTarget)
        separator = true

        if latestMessage = Schema.Message.findOne({parent: currentChannel._id}, {sort: {createAt: -1}})
          dateDiffInMinute = Math.round((((new Date() - latestMessage.createAt) % 86400000) % 3600000) / 60000)
          separator = latestMessage.creator is Meteor.userId() and dateDiffInMinute > 6

        result = Model.Message.insert(currentChannel._id, $message.val(), currentChannel.channelType, separator)

        if result.valid
          $message.val('')
        else
          console.log result.error