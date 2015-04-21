Module 'Model.Diagrams',
  Sale: ->
    seller          : Meteor.userId()
    discountCash    : 0
    totalPrice      : 0
    finalPrice      : 0
    depositCash     : 0
    paymentMethod   : Wings.Enum.salePaymentMethods.debit
    paymentDelivery : Wings.Enum.salePaymentsDeliveries.direct

  SaleDetail: ->
    returnBasicQuality : 0

