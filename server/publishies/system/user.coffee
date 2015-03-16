Model.User.after.insert (userId, doc) ->
  Model.UserProfile.insert {user: userId, gender: true}
  Model.UserOption.insert  {user: userId}
  Model.UserSession.insert {user: userId}

Model.User.after.remove (userId, doc) ->
  Model.UserProfile.remove {user: doc._id}
  Model.UserOption.remove  {user: doc._id}
  Model.UserProfile.remove {user: doc._id}


Model.User.allow
  insert: (userId, doc)-> true if userId
  update: (userId, doc)-> true if userId
  remove: (userId, doc)-> true if userId