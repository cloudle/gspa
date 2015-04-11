Schema.PricePolicy.before.insert (userId, pricePolicy) ->
  pricePolicy.creator = userId if userId
  pricePolicy.createdAt = new Date()

Schema.PricePolicy.before.update (userId, pricePolicy, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()

Schema.PricePolicy.allow
  insert: (userId, pricePolicy)-> true
  update: (userId, pricePolicy, fieldNames, modifier)-> true
  remove: (userId, pricePolicy)-> true