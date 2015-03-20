Price = Wings.Product.Price = {}

Price.insert = (name, priceCode = null)->
  if Meteor.userId() and name
    Model.Price.insert({name: name, priceCode: priceCode})

Price.update = (option, priceId)->
  if Meteor.userId() and typeof option is 'object'
    if product = Model.Price.findOne(priceId)
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

      Model.Price.update product._id, $set: optionUpdate if _.keys(optionUpdate).length > 0

Price.remove = (priceId)->
  if Meteor.userId() and priceId
    Model.Price.remove priceId


#Price.insertPricePrice = (pricePriceList, priceId)->
#  if Meteor.userId() and priceId
#    pricePriceList = [pricePriceList] if Match.test(pricePriceList, {productId: String, price: Number})
#    if Match.test(pricePriceList, [{productId: String, price: Number}])
#      if price = Model.Price.findOne(priceId)
#        Model.Price.update price._id, $addToSet: {productList: {$each: pricePriceList} }
#
#Price.removePricePrice = (pricePriceList, priceId)->
#  if Meteor.userId() and priceId
#    if Match.test(pricePriceList, Match.OneOf({productId: String, price: Number}, [{productId: String, price: Number}]))
#      if price = Model.Price.findOne(priceId)
#        Model.Price.update price._id, $addToSet: {productList: {$each: pricePriceList} }