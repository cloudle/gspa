Wings.defineWidget 'navigation',
  events:
    "click .importManagement"   : -> Session.set "activeLayout", {layout: "importManagement", active: ""}
    "click .saleManagement"     : -> Session.set "activeLayout", {layout: "saleManagement", active: "createSales"}
    "click .productManagement"  : -> Session.set "activeLayout", {layout: "productManagement", active: "productSummaries"}
    "click .deliveryManagement" : -> Session.set "activeLayout", {layout: "deliveryManagement", active: ""}
    "click .staffManagement"    : -> Session.set "activeLayout", {layout: "staffManagement", active: ""}
    "click .customerManagement" : -> Session.set "activeLayout", {layout: "customerManagement", active: ""}
    "click .reportManagement"   : -> Session.set "activeLayout", {layout: "reportManagement", active: ""}
    "click .optionManagement"   : -> Session.set "activeLayout", {layout: "optionManagement", active: ""}