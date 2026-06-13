import Foundation

class Player{
    var move : [Int?] = [nil,nil,nil,nil,nil,nil,nil,nil,nil]
    
    func MakeMove(cell: Int, closure: ()->()){
        move[cell] = cell
    closure()
    }
    
}
