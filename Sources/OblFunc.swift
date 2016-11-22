//Implements function in Oblivion Language


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
    
    //returns a new Env that's linked to the env that calls this method
    func clone() -> Env {
        return Env(args:self)
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
