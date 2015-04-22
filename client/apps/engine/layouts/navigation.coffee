Wings.defineWidget 'navigation',
  events:
    "click .navigation .saleManagement"     : -> logics.home.setActiveLayout("saleManagement"     , "home")
    "click .navigation .staffManagement"    : -> logics.home.setActiveLayout("staffManagement"    , "home")
    "click .navigation .reportManagement"   : -> logics.home.setActiveLayout("reportManagement"   , "home")
    "click .navigation .optionManagement"   : -> logics.home.setActiveLayout("optionManagement"   , "home")
    "click .navigation .importManagement"   : -> logics.home.setActiveLayout("importManagement"   , "home")
    "click .navigation .productManagement"  : -> logics.home.setActiveLayout("productManagement"  , "home")
    "click .navigation .customerManagement" : -> logics.home.setActiveLayout("customerManagement" , "home")
    "click .navigation .deliveryManagement" : -> logics.home.setActiveLayout("deliveryManagement" , "home")
