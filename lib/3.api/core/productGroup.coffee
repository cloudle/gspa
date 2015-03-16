Wings.ProductGroup = {}
Wings.ProductGroup.nextCode = ()-> null
Wings.ProductGroup.changStatus = ()-> null

Wings.ProductGroup.insertProduct = (productList, productGroupId)->
  if Meteor.userId() and productGroupId
    if Match.test(productList, Match.OneOf(String, [String]))
      if productGroup = Model.ProductGroup.findOne(productGroupId)
        if Wings.ProductGroup.allowUpdate(productGroupId)
          Model.ProductGroup.update productGroup._id, $addToSet: {productList: productList}

Wings.ProductGroup.removeProduct = (productList, productGroupId)->
  if Meteor.userId() and productGroupId
    if Match.test(productList, Match.OneOf(String, [String]))
      if productGroup = Model.ProductGroup.findOne(productGroupId)
        if Wings.ProductGroup.allowUpdate(productGroupId)
          Model.ProductGroup.update productGroup._id, $addToSet: {productList: productList}

Wings.ProductGroup.insert = (name, productGroupCode = Wings.ProductGroup.nextCode(), warehouseId = null)->
  if Meteor.userId() and name
    if Wings.ProductGroup.allowInsert()
      Model.ProductGroup.insert({name: name, productCode: productCode, warehouse: warehouseId})

Wings.ProductGroup.update = (option, productId)->
  if Meteor.userId() and typeof option is 'object'
    if product = Model.ProductGroup.findOne(productId)
      if Wings.ProductGroup.allowUpdate(productId)
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


Wings.ProductGroup.remove = (productId)->
  if Meteor.userId() and productId
    if Wings.ProductGroup.allowRemove(productId)
      Model.ProductGroup.remove productId