Model.UserProfile.before.insert (userId, userProfile) ->
  userProfile.createdAt = new Date()

Model.UserProfile.before.update (userId, userProfile, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()

Model.UserProfile.allow
  insert: (userId, userProfile)-> true
  update: (userId, userProfile, fieldNames, modifier)-> true
  remove: (userId, userProfile)-> true




