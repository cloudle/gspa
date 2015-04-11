Module 'Wings.Validators',
  unitUpdateFields: ['name', 'description']
#------------------------------------------------------------------------------
  unitInsert:
    name:
      type: String
      meta: [
        min: 2
        error: "Tên đơn vị tính không thể ngắn hơn 2 ký tự"
      ]

    description:
      type: String
      optional: true

#------------------------------------------------------------------------------
  unitUpdate:
    name:
      type: String
      optional: true
      meta: [
        min: 2
        error: "Tên đơn vị tính không thể ngắn hơn 2 ký tự"
      ]


    description:
      type: String
      optional: true
