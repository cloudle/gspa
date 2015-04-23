Schema.Transaction.allow
  insert: (userId, transaction)-> true
  update: (userId, transaction, fieldNames, modifier)-> true
  remove: (userId, transaction)-> true