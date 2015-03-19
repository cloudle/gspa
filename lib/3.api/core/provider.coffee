Wings.Provider = {}
Wings.Provider.nextCode = ()-> null
Wings.Provider.changStatus = ()-> null

Wings.Provider.insert = (name, phone, providerCode  = null)->
  if Meteor.userId() and name
    if Wings.Provider.allowInsert()
      Model.Provider.insert({name: name, phone: phone, providerCode: providerCode})

Wings.Provider.update = (option, priceId)->
  if Meteor.userId() and typeof option is 'object'
    if product = Model.Provider.findOne(priceId)
      if Wings.Provider.allowUpdate(priceId)
        optionUpdate = {}

        if option.name
          if typeof option.name is 'string' and option.name.length > 0
            optionUpdate.name = option.name
          else
            console.log 'name is error'

        if option.phone
          if typeof option.image is 'string'
            optionUpdate.image = option.image
          else

        if option.description
          if typeof option.description is 'string'
            optionUpdate.description = option.description
          else


        Model.Provider.update product._id, $set: optionUpdate if _.keys(optionUpdate).length > 0

Wings.Provider.remove = (priceId)->
  if Meteor.userId() and priceId
    if Wings.Provider.allowRemove(priceId)
      Model.Provider.remove priceId