Wings.defineApp 'home',
  customers: -> Model.Customer.find({})
  groupName: -> console.log @groupName; @groupName
#  rendered: -> Meteor.subscribe("customer")
