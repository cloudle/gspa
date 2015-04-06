Module 'Wings.Validators',
  importUpdateFields: ['provider', 'description', 'depositCash']
#-------------------------------------------------------------------------
  importInsert:
    warehouse:
      type: String
      meta: [
        min: 17
        error: "warehouseId không chính xác"
      ,
        max: 17
        error: "warehouseId không chính xác"
      ]

    provider:
      type: String
      optional: true
      meta: [
        min: 17
        error: "warehouseId không chính xác"
      ,
        max: 17
        error: "warehouseId không chính xác"
      ]

    description:
      type: String
      optional: true


#-------------------------------------------------------------------------
  importUpdate:
    provider:
      type: String
      optional: true
      meta: [
        min: 17
        error: "warehouseId không chính xác"
      ,
        max: 17
        error: "warehouseId không chính xác"
      ]

    depositCash:
      type: Match.Integer
      optional: true
      meta: [
        min: 0
        error: "Tiển trả phải lớn hơn 0"
      ]

    description:
      type: String
      optional: true
