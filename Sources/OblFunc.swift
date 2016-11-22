//Implements function in Oblivion Language

class OblFunc {
    //inner enum to represent arguments
    enum operand {
        case value(OblVal)
        case param(String)
        case fn(OblFunc)
    }
    
    var params:[String]?
    var argumnts:[operand]?
    var env:Env?
}

