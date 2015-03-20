ProductGroup = Wings.Product.ProductGroup = {}

ProductGroup.insertProductGroup = (name, productGroupCode, warehouseId = null)->
  if Meteor.userId() and name
    Model.ProductGroup.insert({name: name, productCode: productCode, warehouse: warehouseId})

ProductGroup.updateProductGroup = (option, productId)->
  if Meteor.userId() and typeof option is 'object'
    if product = Model.ProductGroup.findOne(productId)
      optionUpdate = {}

      if option.name
        if typeof option.name is 'string' and option.name.length > 0
          optionUpdate.name = option.name
        else
          console.log 'name is error'

      if option.description
        if typeof option.description is 'string'
          optionUpdate.description = option.description
        else

      if option.image
        if typeof option.image is 'string'
          optionUpdate.image = option.image
        else

      Model.ProductGroup.update product._id, $set: optionUpdate if _.keys(optionUpdate).length > 0

ProductGroup.removeProductGroup = (productId)->
  if Meteor.userId() and productId
    Model.ProductGroup.remove productId

#Group.insertGroup = (productList, productGroupId)->
#  if Meteor.userId() and productGroupId
#    if Match.test(productList, Match.OneOf(String, [String]))
#      if productGroup = Model.GroupGroup.findOne(productGroupId)
#        Model.GroupGroup.update productGroup._id, $addToSet: {productList: productList}
#
#Group.removeGroup = (productList, productGroupId)->
#  if Meteor.userId() and productGroupId
#    if Match.test(productList, Match.OneOf(String, [String]))
#      if productGroup = Model.GroupGroup.findOne(productGroupId)
#        Model.GroupGroup.update productGroup._id, $addToSet: {productList: productList}