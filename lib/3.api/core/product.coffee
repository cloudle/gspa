Wings.Product = {}
Wings.Product.nextCode = ()-> null
Wings.Product.changStatus = ()-> null

Wings.Product.insert = (name, productCode = Wings.Product.nextCode(), warehouseId = null)->
  if Meteor.userId() and name
    if Wings.Product.allowInsert()
      Model.Product.insert({name: name, productCode: productCode, warehouse: warehouseId})

Wings.Product.update = (option, productId)->
  if Meteor.userId() and typeof option is 'object'
    if product = Model.Product.findOne(productId)
      if Wings.Product.allowUpdate(productId)
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

        if option.price
          if typeof option.price is 'number'
            optionUpdate.price = option.price
          else

        Model.Product.update product._id, $set: optionUpdate if _.keys(optionUpdate).length > 0


Wings.Product.remove = (productId)->
  if Meteor.userId() and productId
    if Wings.Product.allowRemove(productId)
      Model.Product.remove productId