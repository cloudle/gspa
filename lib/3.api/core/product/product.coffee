Product = Wings.Product

Product.insert = (name, productCode = Product.nextCode(), warehouseId = null)->
  if Meteor.userId() and name
    Model.Product.insert({name: name, productCode: productCode, warehouse: warehouseId})

Product.update = (option, productId)->
  if Meteor.userId() and typeof option is 'object'
    if product = Model.Product.findOne(productId)
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

Product.remove = (productId)->
  if Meteor.userId() and productId
    Model.Product.remove productId
