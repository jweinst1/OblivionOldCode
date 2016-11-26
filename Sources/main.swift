//main swift file


var d = Env()
var a = OblFunc(penv:d, opname:"-")
var s = OblFunc(penv:d, opname:"-")
s.putArgument(item:OblVal(val:6))
s.putArgument(item:OblVal(val:2))
a.putArgument(item:OblVal(val:1))
a.putArgument(item:s)
print(a.call())
