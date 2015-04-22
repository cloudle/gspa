Module 'Wings.Validators',
  conversionUpdateFields: ['barcode']
#------------------------------------------------------------------------------
  conversionInsertDefault:
    product:
      type: String
      meta: [
        min: 17
        error: "productId không chính xác"
      ,
        max: 17
        error: "productId không chính xác"
      ]

    barcode:
      type: String
      optional: true

#------------------------------------------------------------------------------
  conversionInsert:
    product:
      type: String
      meta: [
        min: 17
        error: "productId không chính xác"
      ,
        max: 17
        error: "productId không chính xác"
      ]

    unit:
      type: String
      meta: [
        min: 17
        error: "unitId không chính xác"
      ,
        max: 17
        error: "unitId không chính xác"
      ]

    conversion:
      type: Match.Integer
      meta: [
        min: 1
        error: "Quy đổi không thể nhỏ hơn 1"
      ]

    barcode:
      type: String
      optional: true


#------------------------------------------------------------------------------
  conversionUpdate:
    barcode:
      type: String
      optional: true
