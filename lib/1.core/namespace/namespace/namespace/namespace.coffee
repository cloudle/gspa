@Wings = {}
@Model = {}

Wings.Helper = {}
Wings.Dependency = {}
Wings.Component = {}

Wings.logics = {}
Wings.setups = {}

Wings.Users = Meteor.users


Wings.Users.createUser = (username = null, email = null, password = null)->
  Accounts.createUser({username: username, password: '123'}, (callback)-> console.log callback)

