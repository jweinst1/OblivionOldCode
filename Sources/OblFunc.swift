//Implements function in Oblivion Language

enum OblFunc {
    
    indirect case fn(([OblVal]) -> OblVal, OblFunc)
    //the first function must return a bool oblivion value.
    indirect case cond(([OblVal]) -> OblVal, OblFunc, OblFunc)
    case end
    
    //checks if enum is the end case.
    var isEnd:Bool {
        switch self {
        case .end:
            return true
        default:
            return false
        }
    }
    
    func call(args:[OblVal]) -> OblVal {
        switch self {
        case .fn(let fnc, let next):
            if next.isEnd {
                return fnc(args)
            }
            else {
                return fnc([next.call(args: args)])
            }
            //handles the condition node
        case .cond(let ifs, let t, let f):
            if ifs(args).bool {
                return t.call(args:args)
            }
            else {
                return f.call(args:args)
            }
        default:
            return OblVal.undef
        }
    }
    
}

//Implementation of environment object

class Env {
    var defs:[String:OblVal]
    var parent:Env?
    
    //checks if current env is global
    var isRoot: Bool {
        return self.parent == nil
    }
    
    //global env initializer
    init(){
        self.defs = [String:OblVal]()
    }
    
    //local env initializer
    init(args:Env) {
        self.parent = args
        self.defs = [String:OblVal]()
    }
    
    //getter method that checks local env, then goes up in parent branch
    func get(index:String) -> OblVal {
        if let val = self.defs[index] {
            return val
        }
        else {
            if self.parent != nil {
                return self.parent!.get(index:index)
            }
            else {
                return OblVal.undef
            }
        }
    }
    //basic setter method
    func set(index:String, val:OblVal) -> Void {
        self.defs[index] = val
    }
    //checks if a key is present
    func contains(index:String) -> Bool {
        return self.defs[index] != nil
    }
    
    //updats the environment based on incoming dictionaries of OblVals
    func update(dict:[String:OblVal]) -> Void {
        for (key, value) in dict {
            self.defs[key] = value
        }
    }
    //initalizes an empty variable assigned to null.
    func InitNull(index:String) -> Void {
        self.defs[index] = OblVal.null
    }
}
