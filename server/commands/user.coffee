Meteor.methods
  createNewAccount: (option)->
#    if Meteor.userId()
    userId = Accounts.createUser option
    return userId