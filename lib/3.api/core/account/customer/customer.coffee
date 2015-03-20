Customer = Wings.Account.Customer = {}

Customer.insert = (name, phone = null)->
  if Meteor.userId() and name
    Model.Customer.insert({name: name, phone: phone})

Customer.update = (option, customerId)->
  if Meteor.userId() and typeof option is 'object'
    if customer = Model.Customer.findOne(customerId)
      optionUpdate = {}
      if option.name
        if typeof option.name is 'string' and option.name.length > 0
          optionUpdate.name = option.name
        else
          console.log 'name is error'

      if option.phone
        if typeof option.phone is 'string'
          optionUpdate.phone = option.description
        else

      if option.description
        if typeof option.description is 'string'
          optionUpdate.description = option.description
        else

      if option.image
        if typeof option.image is 'string'
          optionUpdate.image = option.image
        else

      if option.gender
        if typeof option.gender is 'string'
          optionUpdate.gender = option.gender
        else

      if option.dateOfBirth
        if typeof option.dateOfBirth is 'object'
          optionUpdate.dateOfBirth = option.dateOfBirth
        else

      if option.address
        if typeof option.address is 'string'
          optionUpdate.address = option.address
        else

      if option.email
        if typeof option.email is 'string'
          optionUpdate.email = option.email
        else

      Model.Customer.update customer._id, $set: optionUpdate if _.keys(optionUpdate).length > 0


Customer.remove = (customerId)->
  if Meteor.userId() and customerId
    Model.Customer.remove customerId