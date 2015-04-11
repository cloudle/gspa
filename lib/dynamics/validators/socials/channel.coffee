Module 'Wings.Validators.Social',
  channelInsert:
    name:
      type: String
      meta: [
        min: 3
        error: "Tên kênh không thể quá ngắn"
      ,
        max: 25
        error: "Tên kênh không thể quá dài"
      ]
#    creator:
#      type: String
#      meta: [
#        min: 17
#        error: "sellerId không chính xác"
#      ,
#        max: 17
#        error: "sellerId không chính xác"
#      ]