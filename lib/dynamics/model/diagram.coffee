Module 'Model.Diagrams',
  Sale:
    seller          : @userId
    discountCash    : 0
    totalPrice      : 0
    finalPrice      : 0
    depositCash     : 0
    paymentMethod   : Wings.Enum.salePaymentMethods.debit
    paymentDelivery : Wings.Enum.salePaymentsDeliveries.direct
  SaleDetail:
    returnBasicQuality : 0

  Product:
    productGroup       : []
    conversion         : []
    branch             : []
    unit               : []
    availableQuality   : 0
    inOderQuality      : 0
    inStockQuality     : 0
    saleQuality        : 0
    returnSaleQuality  : 0
    importQuality      : 0
    returnImportQuality: 0
    allowDelete        : true
  ProductGroup:
    productList : []

  BranchProduct:
    availableQuality   : 0
    inOderQuality      : 0
    inStockQuality     : 0
    saleQuality        : 0
    returnSaleQuality  : 0
    importQuality      : 0
    returnImportQuality: 0
    allowDelete        : true
  BranchPrice:
    price      : 0
    importPrice: 0
  Conversion:
    allowDelete : true

  Customer:
    debtCash    : 0
    loadCash    : 0
    paidCash    : 0
    gender      : true
    allowDelete : true
  CustomerGroup:
    customerList : []

  Transaction:
    allowDelete : true