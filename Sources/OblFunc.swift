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
    var lambda:(([OblVal]) -> OblVal)?
    //computed property to check if another function in th current body exists
    var hasNext:Bool {
        return self.next != nil
    }
    
    init(penv:Env){
        self.env = penv
        self.params = [String]()
        self.arguments = [Operand]()
    }
    
    func setNext(fn:OblFunc) -> Void {
        self.next = fn
    }
    
    //executes a function's lambda or sub functions
    func call() -> OblVal {
        //not implemented
        return OblVal.undef
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
