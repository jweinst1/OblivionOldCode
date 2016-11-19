//implementation of condition functions


struct conds {
    //static dictionary of condition functions for cached comparison
    static let STD:[String:(([OblVal]) -> OblVal)] = [
        "==":{(args:[OblVal]) in OblVal.bool(args[0] == args[1])}
    ]
}
