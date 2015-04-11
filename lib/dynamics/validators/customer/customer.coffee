Module 'Wings.Validators',
  customerUpdateFields: ['name', 'phone', 'gender', 'description', 'dateOfBirth', 'email', 'address']
#----------------------------------------------------------------------------------------
  customerInsert:
    name:
      type: String
      meta: [
        min: 2
        error: "Tên khách hàng không thể ngắn hơn 2 ký tự"
      ]

    phone:
      type: String
      optional: true
      meta: [
        min: 9
        error: "Số điện thoại không thể ngắn hơn 9 ký tự"
      ]

#------------------------------------------------------------------------------------------
  customerUpdate:
    name:
      type: String
      optional: true
      meta: [
        min: 2
        error: "Tên khách hàng không thể ngắn hơn 2 ký tự"
      ]

    phone:
      type: String
      optional: true
      meta: [
        min: 9
        error: "Số điện thoại không thể ngắn hơn 9 ký tự"
      ]

    gender:
      type: Boolean
      optional: true

    dateOfBirth:
      type: Date
      optional: true

    description:
      type: String
      optional: true

    address:
      type: String
      optional: true

    email:
      type: String
      optional: true



