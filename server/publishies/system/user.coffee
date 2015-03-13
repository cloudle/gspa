Meteor.users.after.insert (userId, doc) ->
  Model.UserProfile.insert {account: userId, createdAt: new Date(), gender: true}
  Model.UserOption.insert  {account: userId, createdAt: new Date()}
  Model.UserSession.insert {account: userId, createdAt: new Date()}

Meteor.users.after.remove (userId, doc) ->
  Model.UserProfile.remove {account: doc._id}
  Model.UserOption.remove  {account: doc._id}
  Model.UserProfile.remove {account: doc._id}


Meteor.users.allow
  insert: (userId, user)-> true
  update: (userId, user)-> true
  remove: (userId, user)-> true