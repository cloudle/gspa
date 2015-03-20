CustomerGroup = Wings.Account.Customer.CustomerGroup = {}

CustomerGroup.insert = (name, customerGroupCode = null, description = null)->
  if Meteor.userId() and name
    Model.CustomerGroup.insert({name: name, description: description})

CustomerGroup.update = (option, customerGroupId)->
  if Meteor.userId() and typeof option is 'object'
    if customerGroup = Model.CustomerGroup.findOne(customerGroupId)
      optionUpdate = {}

      if option.name
        if typeof option.name is 'string' and option.name.length > 0
          optionUpdate.name = option.name
        else
          console.log 'name is error'

      if option.description
        if typeof option.description is 'string'
          optionUpdate.description = option.description
        else

      if option.image
        if typeof option.image is 'string'
          optionUpdate.image = option.image
        else

      Model.CustomerGroup.update customerGroup._id, $set: optionUpdate if _.keys(optionUpdate).length > 0

CustomerGroup.remove = (customerGroupId)->
  if Meteor.userId() and customerGroupId
    Model.CustomerGroup.remove customerGroupId


#Customer.insertCustomer = (customerList, customerGroupId)->
#  if Meteor.userId() and customerGroupId
#    if Match.test(customerList, Match.OneOf(String, [String]))
#      if customerGroup = Model.CustomerGroup.findOne(customerGroupId)
#        if Customer.allowUpdate(customerGroupId)
#          Model.CustomerGroup.update customerGroup._id, $addToSet: {customerList: customerList}
#
#Customer.removeCustomer = (customerList, customerGroupId)->
#  if Meteor.userId() and customerGroupId
#    if Match.test(customerList, Match.OneOf(String, [String]))
#      if customerGroup = Model.CustomerGroup.findOne(customerGroupId)
#        if Customer.allowUpdate(customerGroupId)
#          Model.CustomerGroup.update customerGroup._id, $addToSet: {customerList: customerList}