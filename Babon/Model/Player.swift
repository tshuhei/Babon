//
//  Player.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import Foundation

struct Player{
    let side: PlayerSide
    var numPawnAvailable: Int
    var pawns: [Pawn]
    var isWin: Bool
    
    init(side: PlayerSide){
        self.side = side
        self.numPawnAvailable = 4
        self.pawns = [
            Pawn(side: side),
            Pawn(side: side),
            Pawn(side: side),
            Pawn(side: side),
        ]
        self.isWin = false
    }
}
