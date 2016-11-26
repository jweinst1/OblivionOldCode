//Oblivion Core Operations File

//binding alias for Oblivion Operations
typealias OblOp = ([OblVal], Env) -> OblVal

//standard library of oblivion operations
//need argument count errors
struct StdOblOps {
    static let dict:[String:OblOp] = [
        "+":StdOblOps.add,
        "-":StdOblOps.sub,
        "=":StdOblOps.assign
    ]
    
    static func assign(args:[OblVal], env:Env) -> OblVal {
        let key = args[0].str
        env.set(index:key, val:args[1])
        return OblVal.str("\(key) -> set")
    }
    
    static func add(args:[OblVal], env:Env) -> OblVal {
        var total = 0
        for val in args {
            total += val.int
        }
        return OblVal.int(total)
    }
    //subtracting operation reduces against first operand
    static func sub(args:[OblVal], env:Env) -> OblVal {
        var total = args.first!.int
        for val in args.dropFirst() {
            total -= val.int
        }
        return OblVal.int(total)
    }
}
