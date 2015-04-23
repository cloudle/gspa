#----Transaction----->
Meteor.methods
  insertTransaction: (group, parent, receivable, transactionAmount, description, debtDay, dueDay)->
    return {valid: false, error: 'group is empty!'}      if !group
    return {valid: false, error: 'group is not valid!'}  if _.contains(_.values(Wings.Enum.transactionGroups), group)
    return {valid: false, error: 'receivable is empty!'} if !_.contains([true, false], receivable)
    return {valid: false, error: 'amount is empty!'}     if !transactionAmount

    return {valid: false, error: 'parent is empty!'}     if !parent

    newTransaction = Model.Diagrams.Transaction
    newTransaction.group  = group
    newTransaction.parent = parent
    newTransaction.receivable        = receivable
    newTransaction.transactionAmount = transactionAmount
    newTransaction.description = description if description
    newTransaction.debtDay     = debtDay if debtDay
    newTransaction.dueDay      = dueDay if debtDay

    switch group
      when Wings.Enum.transactionGroups.sale
        if sale = Schema.Sale.findOne({_id: parent, status: "submit"}) then newTransaction.owner = sale.buyer
        else return {valid: false, error: 'Sale(parent) not found!'}

      when Wings.Enum.transactionGroups.import
        if findImport = Schema.Import.findOne({_id: parent, status: "submit"}) then newTransaction.owner = findImport.provider
        else return {valid: false, error: 'Import(parent) not found!'}

#      when Wings.Enum.transactionGroups.returnSale
#      when Wings.Enum.transactionGroups.returnImport

    insertResult = Wings.IRUS.insert(Schema.Transaction, newTransaction, Wings.Validators.transactionInsert)
    return insertResult

  updateTransaction: (transactionId, model, fields)->
    transaction = Schema.Transaction.findOne(transactionId)
    return {valid: false, error: 'transactionId is not valid!'} if !transaction

    result = Wings.Validators.checkExistField(fields, "transactionUpdateFields")
    if result.valid then updateFields = result.data else return result

    #TODO: chưa kiểm tra kiểm tra ngày của debtDate, dueDay.
#    if _.contains(updateFields, 'debtDate')
#      return {valid: false, error: 'debtDate is not valid!!'} if model.debtDate ?? điều kiện
#    if _.contains(updateFields, 'dueDay')
#      return {valid: false, error: 'dueDay is not valid!!'} if model.dueDay ?? điều kiện

    updateResult = Wings.IRUS.update(Schema.Transaction, transaction._id, model, updateFields, Wings.Validators.transactionUpdate)
    return updateResult

  removeTransaction: (transactionId)->
    transaction = Schema.Transaction.findOne({_id: transactionId, allowDelete: true})
    return {valid: false, error: 'transactionId is not valid!'} if !transaction

    result = Wings.IRUS.remove(Schema.Transaction, transactionId)
    return result