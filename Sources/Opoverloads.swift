//Operator OverLoads

func ==(left:OblVal, right:OblVal) -> Bool {
    switch left {
    case .int(let val):
        switch right {
        case .int(let other):
            return val == other
        case .bool(let other):
            return val == 0 && !other
        default:
            return false
        }
    case .str(let val):
        switch right {
        case .int(_):
            return false
        case .str(let other):
            return val == other
        case .bool(let other):
            return val == "" && !other
        case .null:
            return false
        case .map(let val):
            return false
        case .undef:
            return false
        }
    case .bool(let val):
        switch right {
        case .bool(let other):
            return val == other
        default:
            return false
        }
    case .null:
        switch right {
        case .null:
            return true
        default:
            return false
        }
    case .map(let val):
        switch right {
        //compares the keys of maps, deep compare will come later
        case .map(let other):
            return val.description == other.description
        default:
            return false
        }
    case .undef:
        switch right {
        case .undef:
            return true
        default:
            return false
        }
    }
}
