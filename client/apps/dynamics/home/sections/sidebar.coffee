Wings.defineWidget 'sidebar',
  importManagementActive  : -> Session.get("activeLayout") is "importManagement"
  saleManagementActive    : -> Session.get("activeLayout") is "saleManagement"
  productManagementActive : -> Session.get("activeLayout") is "productManagement"

  events:
    "click .importManagement" : -> Session.set "activeLayout", "importManagement"
    "click .saleManagement"   : -> Session.set "activeLayout", "saleManagement"
    "click .productManagement": -> Session.set "activeLayout", "productManagement"