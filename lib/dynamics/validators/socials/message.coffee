Module 'Wings.Validators.Social',
  messageInsert:
    message:
      type: String
      meta: [
        min: 3
        error: "Thông điệp chat quá ngắn"
      ,
        max: 255
        error: "Thông điệp chat quá dài"
      ]
    parent:
      type: String
      meta: [
        min: 17
        error: "Id không chính xác"
      ,
        max: 17
        error: "Id không chính xác"
      ]