//Implements function in Oblivion Language

/*
 The Oblivion language works off of a homogenous form of function that works like an automatan.
 Every function is a machine that has arguments, parameters, an environment to store variables, a remaining body 
 to execute. When it's call method is invoked it uses it's operation on its arguments array to reduce
 to a single result. Operations are the most basic forms of execution in oblivion.
 */

class OblFunc {
    
    
    var params:[String]
    var arguments:[Operand]
    var env:Env
    var next:OblFunc?
    //this is optional as user-defined functions don't have base operations
    var oper:OblOp?
    //computed property to check if another function in th current body exists
    var hasNext:Bool {
        return self.next != nil
    }
    
    var isOperation:Bool {
        return self.oper != nil
    }
    
    init(penv:Env){
        self.env = penv
        self.params = [String]()
        self.arguments = [Operand]()
    }
    
    //alternate initializer to automatically create oper bound function
    init(penv:Env, opname:String){
        self.env = penv
        self.params = [String]()
        self.arguments = [Operand]()
        self.setOper(key:opname)
    }
    
    func setNext(fn:OblFunc) -> Void {
        self.next = fn
    }
    
    func setOper(key:String) -> Void {
        //needs key not found error
        self.oper = StdOblOps.dict[key]!
    }
    
    func addParam(name:String) -> Void {
        self.params.append(name)
    }
    
    func setParam(name:String, val:OblVal) -> Void {
        //needs error if argued param is not created yet.
        self.env.set(index:name, val:val)
    }
    
    func bindParams(args:[OblVal]) -> Void {
        //needs an error
        for i in 0..<self.params.count {
            self.env.set(index:self.params[i], val:args[i])
        }
    }
    
    //puts arguments in the execution array
    func putArgument(item:String) -> Void {
        //needs error for invalid paramter
        self.arguments.append(Operand.param(item))
    }
    
    func putArgument(item:OblVal) -> Void {
        self.arguments.append(Operand.value(item))
    }
    
    func putArgument(item:OblFunc) -> Void {
        self.arguments.append(Operand.fn(item))
    }
    
    //executes a function's operation
    func call() -> OblVal {
        var newargs = [OblVal]()
        for var elem in self.arguments {
            newargs.append(elem.call(env:self.env))
        }
        if self.hasNext {
            self.oper!(newargs, self.env)
            return self.next!.call()
        }
        else {
            return self.oper!(newargs, self.env)
        }
    }
}

//The operand enum allows items inside the arguments array of an OblFunc to be called with correct parameters
enum Operand {
    
    case value(OblVal)
    case param(String)
    case fn(OblFunc)
    
    //recursive instance method to prepare automata for execution
    mutating func call(env:Env) -> OblVal {
        switch self {
        case .value(let val):
            return val
        case .param(let name):
            return env.get(index:name)
        case .fn(let lambda):
            return lambda.call()
        }
    }
}
