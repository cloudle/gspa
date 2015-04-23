scope = logics.home

Wings.defineWidget 'historySales',
  avatarImg: -> "avatars/#{@creator}.jpg"
  mySales: -> Schema.Sale.find({status: "submit"})
  title: ->
    sellerName = Meteor.users.findOne(@seller).profile?.name if @creator
    methodName = if @paymentMethod is 1 then 'bán hàng' else 'đặt hàng'
    customerName = Schema.Customer.findOne(@buyer).name
    sellerName + ' đã ' + methodName + ' cho ' + customerName
