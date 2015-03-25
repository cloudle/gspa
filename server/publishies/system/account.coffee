Model.Account.after.insert (userId, account) ->
  Model.UserProfile.insert {user: userId, gender: true}
  Model.UserOption.insert  {user: userId}
  Model.UserSession.insert {user: userId}

Model.Account.after.remove (userId, account) ->
  Model.UserProfile.remove {user: account._id}
  Model.UserOption.remove  {user: account._id}
  Model.UserProfile.remove {user: account._id}

Model.Account.allow
  insert: (userId, account)-> true
  update: (userId, account, fieldNames, modifier)-> true
  remove: (userId, account)-> true