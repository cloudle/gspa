Module 'Model',
  Branch        : new Meteor.Collection 'branches'      , transform: (doc)-> new Wings.Branch(doc)
  Warehouse     : new Meteor.Collection 'warehouses'    , transform: (doc)-> new Wings.Warehouse(doc)

  Import        : new Meteor.Collection 'imports'       , transform: (doc)-> new Wings.Warehouse.Import(doc)
  ImportDetail  : new Meteor.Collection 'importDetails' , transform: (doc)-> new Wings.Warehouse.ImportDetail(doc)

  Customer      : new Meteor.Collection 'customers'     , transform: (doc)-> new Wings.Customer(doc)
  CustomerGroup : new Meteor.Collection 'customerGroups', transform: (doc)-> new Wings.Customer.Group(doc)

  Provider      : new Meteor.Collection 'providers'     , transform: (doc)-> new Wings.Provider(doc)

  Product       : new Meteor.Collection 'products'      , transform: (doc)-> new Wings.Product(doc)
  ProductGroup  : new Meteor.Collection 'productGroups' , transform: (doc)-> new Wings.Product.Group(doc)

  BranchProduct : new Meteor.Collection 'branchProducts', transform: (doc)-> new Wings.Product.BranchProduct(doc)
  BranchPrice   : new Meteor.Collection 'branchPrices'  , transform: (doc)-> new Wings.Product.BranchPrice(doc)

  Unit          : new Meteor.Collection 'units'         , transform: (doc)-> new Wings.Product.Unit(doc)
  Conversion    : new Meteor.Collection 'conversions'   , transform: (doc)-> new Wings.Product.Conversion(doc)

  PricePolicy   : new Meteor.Collection 'pricePolicies' , transform: (doc)-> new Wings.PricePolicy(doc)

  Sale          : new Meteor.Collection 'sales'         , transform: (doc)-> new Wings.Sale(doc)
  SaleDetail    : new Meteor.Collection 'saleDetails'   , transform: (doc)-> new Wings.SaleDetail(doc)

  Delivery      : new Meteor.Collection 'deliveries'    , transform: (doc)-> new Wings.Delivery(doc)

  Return        : new Meteor.Collection 'returns'       , transform: (doc)-> new Wings.Return(doc)
  ReturnDetail  : new Meteor.Collection 'returnDetails' , transform: (doc)-> new Wings.ReturnDetail(doc)

  Transaction   : new Meteor.Collection 'transactions'  , transform: (doc)-> new Wings.Transaction(doc)
  SaleTarget    : new Meteor.Collection 'saleTargets'   , transform: (doc)-> new Wings.SaleTarget(doc)
