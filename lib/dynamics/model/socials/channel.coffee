class Model.Channel
  @ChannelTypes:
    public   : 1
    private  : 2

  constructor: (doc) -> @[key] = value for key, value of doc
  @insert: (name, description = null, channelType = @ChannelTypes.channel) ->
    newChannel = { creator: Meteor.userId(), channelType: channelType, name: name }
    newChannel.description = description if description
    Wings.IRUS.insert(Schema.Channel, newChannel, Wings.Validators.Social.channelInsert)