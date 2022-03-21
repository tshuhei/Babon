//
//  Pawn.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import Foundation

struct Pawn{
    var col: Int
    var row: Int
    var side: PlayerSide
    
    init(side: PlayerSide){
        self.col = -1
        self.row = -1
        self.side = side
    }
}
