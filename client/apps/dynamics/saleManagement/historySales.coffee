scope = logics.home

Wings.defineWidget 'historySales',
  avatarImg: -> "avatars/#{@creator}.jpg"
  mySales: -> Schema.Sale.find({status: "submit"})
  creatorName: -> Meteor.users.findOne(@creator).profile?.name if @creator
  title: ->
    sellerName = Meteor.users.findOne(@seller).profile?.name if @creator
    methodName = if @paymentMethod is 1 then 'bán hàng' else 'đặt hàng'
    customerName = Schema.Customer.findOne(@buyer).name
    sellerName + ' đã ' + methodName + ' cho ' + customerName
