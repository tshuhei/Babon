//
//  BoardCell.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import Foundation
import SwiftUI

struct BoardCell{
    let row: Int
    let col: Int
    let movable: [(Int, Int)]
    let position: CellPosition
    var cellStatus: CellStatus
    var cellColor: Color
    var isMovable: Bool
    
    init(row: Int, col: Int, position: CellPosition, movable: [(Int, Int)]){
        self.row = row
        self.col = col
        self.position = position
        self.cellStatus = .neutral
        if self.position == .up{
            self.cellColor = Color("upNeutral")
        }else{
            self.cellColor = Color("downNeutral")
        }
        self.movable = movable
        self.isMovable = false
    }
}
