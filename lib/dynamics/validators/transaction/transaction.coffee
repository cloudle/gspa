Module 'Wings.Validators',
  transactionUpdateFields: ['transactionAmount', 'receivable', 'debtDate', 'dueDay', 'description']
#------------------------------------------------------------------
  transactionInsert:
    parent:
      type: String
      meta: [
        min: 17
        error: "parentId không chính xác"
      ,
        max: 17
        error: "parentId không chính xác"
      ]

    owner:
      type: String
      optional: true
      meta: [
        min: 17
        error: "parentId không chính xác"
      ,
        max: 17
        error: "parentId không chính xác"
      ]

    transactionAmount:
      type: Match.Integer
      meta: [
        min: 0
        error: "TotalCash phải lớn hơn 0"
      ]

    group:
      type: Match.Integer
      meta: [
        min: 0
        error: "Group phải lớn hơn 0"
      ]

    receivable:
      type: Boolean

    description:
      type: String
      optional: true

    debtDay:
      type: Date
      optional: true

    dueDay:
      type: Date
      optional: true

#------------------------------------------------------------------
  transactionUpdate:
    transactionAmount:
      type: Match.Integer
      meta: [
        min: 0
        error: "TotalCash phải lớn hơn 0"
      ]

    receivable:
      type: Boolean
      optional: true

    debtDate:
      type: Date
      optional: true

    dueDay:
      type: Date
      optional: true

    description:
      type: String
      optional: true