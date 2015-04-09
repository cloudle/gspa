Module 'Wings.Validators',
  customerGroupUpdateFields: ['name', 'description']
#--------------------------------------------------------------------------------
  customerGroupInsert:
    name:
      type: String
      meta: [
        min: 2
        error: "Tên nhóm khách hàng không thể ngắn hơn 2 ký tự"
      ]

#--------------------------------------------------------------------------------
  customerGroupUpdate:
    name:
      type: String
      optional: true
      meta: [
        min: 2
        error: "Tên nhóm khách hàng không thể ngắn hơn 2 ký tự"
      ]

    description:
      type: String
      optional: true
      meta: [
        min: 2
        error: "Tên nhóm khách hàng không thể ngắn hơn 2 ký tự"
      ]



