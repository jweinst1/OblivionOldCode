//Core OblVal enum of Oblivion Language

enum OblVal:CustomStringConvertible {
    case int(Int)
    case str(String)
    case bool(Bool)
    indirect case map([String:OblVal])
    case null
    case undef
    
    //indvidual initializers
    init(val:Int){
        self = .int(val)
    }
    
    init(val:String){
        self = .str(val)
    }
    
    init(val:Bool){
        self = .bool(val)
    }
    
    init(){
        self = .map([String:OblVal]())
    }
    
    var description: String {
        //recursive pretty printer for map cases
        func repr(space:Int, map:[String:OblVal]) -> String {
            guard !map.isEmpty else { return "()" }
            let spacer = String(repeating: " ", count: space)
            var keyval = ""
            for (key, val) in map {
                switch val {
                case .map(let dict):
                    keyval += "\(spacer) \"\(key)\":\(repr(space:space+1, map:dict)),\n"
                case .str(_):
                    keyval += "\(spacer) \"\(key)\":\"\(val)\",\n"
                default:
                    keyval += "\(spacer) \"\(key)\":\(val),\n"
                }
            }
            return "(\n\(keyval))"
            
        }
        switch self {
        case .str(let val):
            return String(val)
        case .int(let val):
            return String(val)
        case .bool(let val):
            return String(val)
        case .map(let map):
            return repr(space:0, map:map)
        case .null:
            return "null"
        case .undef:
            return "undef"
        }
    }
    
    //computed getter variables
    var int:Int {
        switch self {
        case .int(let val):
            return val
        default:
            return 0
        }
    }
    
    var str:String {
        switch self {
        case .str(let val):
            return val
        default:
            return ""
        }
    }
    
    var bool:Bool {
        switch self {
        case .bool(let val):
            return val
        default:
            return false
        }
    }
    
    subscript (index:OblVal) -> OblVal {
        get {
            switch self {
            case .map(let map):
                if let val = map[index.description] {
                    return val
                }
                else {
                    return OblVal.undef
                }
            default:
                return OblVal.undef
            }
        }
        set {
            switch self {
            case .map(var map):
                switch index {
                case.map(_):
                    break
                default:
                    map[index.description] = newValue
                    self = OblVal.map(map)
                }
            default:
                break
            }
        }
    }
    
    //methods that transform the oblval into a different type or form
    mutating func transMap() -> Void {
        self = .map([String:OblVal]())
    }
    
    mutating func transInt(value:Int) -> Void {
        self = .int(value)
    }
    
    mutating func transStr(value:String) -> Void {
        self = .str(value)
    }
    
    mutating func transBool(value:Bool) -> Void {
        self = .bool(value)
    }
    
    //computed property that determines if a OblVal evaluats to true or not
    //used for condition nodes
    var boolEval: Bool {
        switch self {
        case .int(let val):
            if val == 0 {
                return false
            } else {
                return true
            }
        case .str(let val):
            if val == "" {
                return false
            } else {
                return true
            }
        case .bool(let val):
            return val
        case .map(_):
            return true
        default:
            return false
        }
    }
}



