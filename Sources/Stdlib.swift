//Oblivion function framework
struct Stdlib {
    
    //reduces lists of int arguments against a base int. Any non int value evaluates to zero
    static func add(args:[OblVal]) -> OblVal {
        var total = args.first!.int
        for elem in args {
            total += elem.int
        }
        return OblVal.int(total)
    }
    
    static func sub(args:[OblVal]) -> OblVal {
        var total = args.first!.int
        for elem in args.dropFirst() {
            total -= elem.int
        }
        return OblVal.int(total)
    }
    
    static func mul(args:[OblVal]) -> OblVal {
        var total = args.first!.int
        for elem in args.dropFirst() {
            total *= elem.int
        }
        return OblVal.int(total)
    }
    
    static func div(args:[OblVal]) -> OblVal {
        var total = args.first!.int
        for elem in args.dropFirst() {
            total /= elem.int
        }
        return OblVal.int(total)
    }
    
    static func rem(args:[OblVal]) -> OblVal {
        var total = args.first!.int
        for elem in args.dropFirst() {
            total %= elem.int
        }
        return OblVal.int(total)
    }
}
