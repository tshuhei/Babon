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
    var cellStatus: CellStatus
    let position: CellPosition
    var cellColor: Color
    
    init(row: Int, col: Int, position: CellPosition){
        self.row = row
        self.col = col
        self.position = position
        self.cellStatus = .neutral
        if self.position == .up{
            self.cellColor = Color("upNeutral")
        }else{
            self.cellColor = Color("downNeutral")
        }
    }
}
