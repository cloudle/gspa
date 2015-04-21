class Model.Product
  constructor: (doc) -> @[key] = value for key, value of doc

  @insert: (name, description)->
    Meteor.call 'insertProduct', name, description, (err, result) -> console.log result

  insert: ()->
    self = @
    return {valid: false, error: 'This record is created'} if @_id
    Meteor.call 'insertProduct', @name, @description,
      (err, result) -> if result.valid then self._id = result.result; console.log result

  update: (fields)->
    return {valid: false, error: 'This _id is required!'} if !@_id
    Meteor.call 'updateProduct', @_id, @, fields, (err, result) -> console.log result

  remove: ->
    return {valid: false, error: 'This _id is required!'} if !@_id
    Meteor.call 'removeProduct', @_id, (err, result) -> console.log result



  addBranchProduct: (branchId)->
    return {valid: false, error: 'This _id is required!'} if !@_id
    Meteor.call 'insertBranchProduct', @_id, branchId, (err, result) -> console.log result

  updateBasicUnit: (unitId)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    if @basicUnit
      return {valid: false, error: 'basicUnit trùng lắp'} if @basicUnit is unitId
      return {valid: false, error: 'không thể sửa đổi basicUnit'} if @conversion.length > 1

    Meteor.call 'updateProduct', @_id, {basicUnit: unitId}, 'basicUnit', (err, result) -> console.log result


  addConversion: (unitId, conversion)->
    return {valid: false, error: 'This _id is required!'} if !@_id

    return {valid: false, error: 'Chưa tạo đơn vị tính cơ bản'} if !@basicUnit
    return {valid: false, error: 'Đơn vị tính bị trùng với ĐVT cơ bản.'} if @basicUnit is unitId

    Meteor.call 'insertConversion', @_id, unitId, conversion, (err, result) -> console.log result