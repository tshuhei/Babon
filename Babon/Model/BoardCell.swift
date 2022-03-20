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
    /*var cellColor: Color{
        switch self.cellStatus{
        case .neutral:
            if position == .up{
                return Color("upNeutral")
            }else{
                return Color("downNeutral")
            }
        case .red:
            if position == .up{
                return Color("upRed")
            }else{
                return Color("downRed")
            }
        case .blue:
            if position == .up{
                return Color("upBlue")
            }else{
                return Color("downBlue")
            }
        }
    }*/
}
