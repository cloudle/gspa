Schema.Provider.before.insert (userId, provider) ->
  provider.creator = userId if userId
  provider.createdAt = new Date()

Schema.Provider.before.update (userId, provider, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()


Schema.Provider.after.remove (userId, provider) ->
  Schema.Import.find({provider: provider._id}).forEach(
    (currentImport) ->
      Schema.Import.remove(currentImport._id)
      Schema.ImportDetail.remove({import: currentImport._id})
  )


Schema.Provider.allow
  insert: (userId, provider)-> true
  update: (userId, provider, fieldNames, modifier)-> true
  remove: (userId, provider)-> true