//Implements function in Oblivion Language




enum OblFunc {
    
    indirect case fn(([OblVal]) -> OblVal, OblFunc)
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
                return fnc(next.call(args: args))
            }
        default:
            return OblVal.undef
        }
    }
}
