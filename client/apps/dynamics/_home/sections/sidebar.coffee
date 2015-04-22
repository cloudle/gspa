scope = logics.home

Wings.defineWidget 'sidebar',
  isActiveImportManagement  : -> scope.getActiveLayout("importManagement")
  isActiveSaleManagement    : -> scope.getActiveLayout("saleManagement")
  isActiveProductManagement : -> scope.getActiveLayout("productManagement")
  isActiveCustomerManagement: -> scope.getActiveLayout("customerManagement")
  isActiveStaffManagement   : -> scope.getActiveLayout("staffManagement")
  isActiveReportManagement  : -> scope.getActiveLayout("reportManagement")
  isActiveOptionManagement  : -> scope.getActiveLayout("optionManagement")
  isActiveDeliveryManagement: -> scope.getActiveLayout("deliveryManagement")
