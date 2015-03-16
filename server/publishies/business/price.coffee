Model.Price.before.insert (userId, doc) ->
  doc.creator = userId
  doc.createdAt = new Date()

Model.Price.before.update (userId, doc, fieldNames, modifier, options) ->
  console.log 'before Update'
  modifier.$set = modifier.$set || {}
  modifier.$set.updateAt = new Date()

Model.Price.after.update (userId, doc, fieldNames, modifier, options) ->
  console.log 'after Update'



Model.Price.allow
  insert: (userId, doc)-> true if userId
  update: (userId, doc, fieldNames, modifier)->
    console.log 'allow Update'
#    console.log 'this allow:' + _.findWhere(doc.productList, {productId:'12312'});
#    console.log 'this allow:' + modifier.$addToSet
    true if userId
  remove: (userId, doc)-> true if userId