Schema.Account.after.insert (userId, account) ->
  Schema.UserProfile.insert {user: userId, gender: true}
  Schema.UserOption.insert  {user: userId}
  Schema.UserSession.insert {user: userId}

Schema.Account.after.remove (userId, account) ->
  Schema.UserProfile.remove {user: account._id}
  Schema.UserOption.remove  {user: account._id}
  Schema.UserProfile.remove {user: account._id}

Schema.Account.allow
  insert: (userId, account)-> true
  update: (userId, account, fieldNames, modifier)-> true
  remove: (userId, account)-> true