Module 'Wings.Validators',
  warehouseUpdateFields: ['name','description']

  warehouseCreate:
    name:
      type: String
      meta: [
        min: 2
        error: "Tên sản phẩm không thể ngắn hơn 2 ký tự"
      ]
    description:
      type: String
      optional: true

  warehouseUpdate:
    name:
      type: String
      optional: true
      meta: [
        min: 2
        error: "Tên sản phẩm không thể ngắn hơn 2 ký tự"
      ]
    description:
      type: String
      optional: true