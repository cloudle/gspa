Wings.defineWidget 'sidebar',
  isActiveImportManagement  : -> Session.get("activeLayout")?.layout is "importManagement"
  isActiveSaleManagement    : -> Session.get("activeLayout")?.layout is "saleManagement"
  isActiveProductManagement : -> Session.get("activeLayout")?.layout is "productManagement"
