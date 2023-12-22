//
//  Model.swift
//  Tic Tac Toe
//
//  Created by nikita on 06.12.2023.
//

import Foundation
class Player{
    var move : [Int?] = [nil,nil,nil,nil,nil,nil,nil,nil,nil]
    var IsHuman = true
    
    func MakeMove(cell: Int, closure: ()->() ){
        move[cell] = cell
    closure()
    }
}

class Pc{
    var move : [Int?] = [nil,nil,nil,nil,nil,nil,nil,nil,nil]
    
}
