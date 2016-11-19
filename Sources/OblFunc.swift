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
