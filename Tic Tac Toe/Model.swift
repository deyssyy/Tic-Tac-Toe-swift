//
//  Model.swift
//  Tic Tac Toe
//
//  Created by nikita on 06.12.2023.
//

import Foundation
class Player{
    var move : [Int?] = [nil,nil,nil,nil,nil,nil,nil,nil,nil]
    
    func MakeMove(cell: Int, closure: ()->()){
        move[cell] = cell
    closure()
    }
    
}
