Provider = Wings.Account.Provider = {}

Provider.insert = (name, phone, providerCode  = null)->
  if Meteor.userId() and name
    Model.Provider.insert({name: name, phone: phone, providerCode: providerCode})

Provider.update = (option, priceId)->
  if Meteor.userId() and typeof option is 'object'
    if product = Model.Provider.findOne(priceId)
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

Provider.remove = (priceId)->
  if Meteor.userId() and priceId
    Model.Provider.remove priceId



#Provider.nextCode = ()-> null
#Provider.changStatus = ()-> null