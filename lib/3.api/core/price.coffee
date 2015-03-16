Wings.Price = {}
Wings.Price.nextCode = ()-> null
Wings.Price.changStatus = ()-> null

Wings.Price.insertPriceProduct = (priceProductList, priceId)->
  if Meteor.userId() and priceId
    priceProductList = [priceProductList] if Match.test(priceProductList, {productId: String, price: Number})
    if Match.test(priceProductList, [{productId: String, price: Number}])
      if price = Model.Price.findOne(priceId)
        if Wings.Price.allowUpdate()
          Model.Price.update price._id, $addToSet: {productList: {$each: priceProductList} }

Wings.Price.removePriceProduct = (priceProductList, priceId)->
  if Meteor.userId() and priceId
    if Match.test(priceProductList, Match.OneOf({productId: String, price: Number}, [{productId: String, price: Number}]))
      if price = Model.Price.findOne(priceId)
        if Wings.Price.allowUpdate()
          Model.Price.update price._id, $addToSet: {productList: {$each: priceProductList} }


Wings.Price.insert = (name, priceCode = null)->
  if Meteor.userId() and name
    if Wings.Price.allowInsert()
      Model.Price.insert({name: name, priceCode: priceCode})

Wings.Price.update = (option, priceId)->
  if Meteor.userId() and typeof option is 'object'
    if product = Model.Price.findOne(priceId)
      if Wings.Price.allowUpdate(priceId)
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


Wings.Price.remove = (priceId)->
  if Meteor.userId() and priceId
    if Wings.Price.allowRemove(priceId)
      Model.Price.remove priceId

Wings.Price.test = (id, callback)-> callback