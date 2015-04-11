Schema.UserProfile.before.insert (userId, userProfile) ->
  userProfile.createdAt = new Date()

Schema.UserProfile.before.update (userId, userProfile, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()

Schema.UserProfile.allow
  insert: (userId, userProfile)-> true
  update: (userId, userProfile, fieldNames, modifier)-> true
  remove: (userId, userProfile)-> true




