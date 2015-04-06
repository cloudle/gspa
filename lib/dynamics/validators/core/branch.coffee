Module 'Wings.Validators',
  branchUpdateFields: ['name', 'phone', 'description', 'address']
#------------------------------------------------------------------------------>
  branchInsert:
    name:
      type: String
      meta: [
        min: 2
        error: "Tên chi nhánh không thể ngắn hơn 2 ký tự"
      ]

    address:
      type: String
      optional: true

    phone:
      type: String
      optional: true

    description:
      type: String
      optional: true

#------------------------------------------------------------------------------>
  branchUpdate:
    name:
      type: String
      optional: true
      meta: [
        min: 2
        error: "Tên chi nhánh không thể ngắn hơn 2 ký tự"
      ]

    address:
      type: String
      optional: true

    phone:
      type: String
      optional: true

    description:
      type: String
      optional: true