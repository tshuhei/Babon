//
//  Board.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import Foundation

struct Board{
    var cells: [BoardCell]
    var red: Player
    var blue: Player
    var turn: PlayerSide
    var isFirst: Bool
    
    init(){
        self.cells = [
            BoardCell(row: 1, col: 1, position: .up),
            BoardCell(row: 1, col: 2, position: .up),
            BoardCell(row: 1, col: 3, position: .up),
            BoardCell(row: 1, col: 4, position: .up),
            BoardCell(row: 2, col: 1, position: .up),
            BoardCell(row: 2, col: 2, position: .up),
            BoardCell(row: 2, col: 3, position: .up),
            BoardCell(row: 2, col: 4, position: .up),
            BoardCell(row: 3, col: 1, position: .up),
            BoardCell(row: 3, col: 2, position: .up),
            BoardCell(row: 3, col: 3, position: .up),
            BoardCell(row: 3, col: 4, position: .up),
            BoardCell(row: 4, col: 1, position: .up),
            BoardCell(row: 4, col: 2, position: .up),
            BoardCell(row: 4, col: 3, position: .up),
            BoardCell(row: 4, col: 4, position: .up),
            
            BoardCell(row: 1, col: 1, position: .down),
            BoardCell(row: 1, col: 2, position: .down),
            BoardCell(row: 1, col: 3, position: .down),
            BoardCell(row: 2, col: 1, position: .down),
            BoardCell(row: 2, col: 2, position: .down),
            BoardCell(row: 2, col: 3, position: .down),
            BoardCell(row: 3, col: 1, position: .down),
            BoardCell(row: 3, col: 2, position: .down),
            BoardCell(row: 3, col: 3, position: .down)
        ]
        self.red = Player(side: .red)
        self.blue = Player(side: .blue)
        self.turn = .blue
        self.isFirst = true
    }
}
