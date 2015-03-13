Meteor.methods
  createNewUser: (option)->
#    if Meteor.userId()
    userId = Accounts.createUser option
    return userId