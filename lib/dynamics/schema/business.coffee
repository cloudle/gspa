Module 'Schema',
  Branch        : new Meteor.Collection 'branches'      , transform: (doc)-> new Model.Branch(doc)
  Provider      : new Meteor.Collection 'providers'     , transform: (doc)-> new Model.Provider(doc)

  Customer      : new Meteor.Collection 'customers'     , transform: (doc)-> new Model.Customer(doc)
  CustomerGroup : new Meteor.Collection 'customerGroups', transform: (doc)-> new Model.Customer.CustomerGroup(doc)

  Warehouse     : new Meteor.Collection 'warehouses'    , transform: (doc)-> new Model.Warehouse(doc)
  Import        : new Meteor.Collection 'imports'       , transform: (doc)-> new Model.Warehouse.Import(doc)
  ImportDetail  : new Meteor.Collection 'importDetails' , transform: (doc)-> new Model.Warehouse.ImportDetail(doc)

  Product       : new Meteor.Collection 'products'      , transform: (doc)-> new Model.Product(doc)
  ProductGroup  : new Meteor.Collection 'productGroups' , transform: (doc)-> new Model.Product.ProductGroup(doc)

  BranchProduct : new Meteor.Collection 'branchProducts', transform: (doc)-> new Model.Product.BranchProduct(doc)
  BranchPrice   : new Meteor.Collection 'branchPrices'  , transform: (doc)-> new Model.Product.BranchPrice(doc)

  Unit          : new Meteor.Collection 'units'         , transform: (doc)-> new Model.Product.Unit(doc)
  Conversion    : new Meteor.Collection 'conversions'   , transform: (doc)-> new Model.Product.Conversion(doc)
  PricePolicy   : new Meteor.Collection 'pricePolicies' , transform: (doc)-> new Model.Product.PricePolicy(doc)

  Sale          : new Meteor.Collection 'sales'         , transform: (doc)-> new Model.Sale(doc)
  SaleDetail    : new Meteor.Collection 'saleDetails'   , transform: (doc)-> new Model.Sale.SaleDetail(doc)

  Delivery      : new Meteor.Collection 'deliveries'    , transform: (doc)-> new Model.Delivery(doc)

  Return        : new Meteor.Collection 'returns'       , transform: (doc)-> new Model.Return(doc)
  ReturnDetail  : new Meteor.Collection 'returnDetails' , transform: (doc)-> new Model.ReturnDetail(doc)

  Transaction   : new Meteor.Collection 'transactions'  , transform: (doc)-> new Model.Transaction(doc)
  SaleTarget    : new Meteor.Collection 'saleTargets'   , transform: (doc)-> new Model.SaleTarget(doc)
