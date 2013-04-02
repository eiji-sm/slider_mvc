class numberManager
  isMutable = true
  val: 0
  constructor: (mutable = true)-> isMutable = mutable
  lock:   -> isMutable = false
  unlock: -> isMutable = true
  increase: (number = 1)-> if isMutable then @val += number
  decrease: (number = 1)-> if isMutable then @val -= number
  set:      (number)->     if isMutable then @val  = number