//main swift file


var d = OblVal.int(4)
var f = OblVal.int(3)
let test = [f, d]
let give = OblFunc.fn({(args:[OblVal]) in args[0]}, OblFunc.end)
let dive = OblFunc.fn({(args:[OblVal]) in args[1]}, OblFunc.end)
let lambda = OblFunc.cond(conds.STD["=="]!, give, dive)
print(lambda.call(args:test))
print("helo")
