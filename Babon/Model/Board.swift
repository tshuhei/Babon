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
    var isSelected: Bool
    var selectedRow: Int
    var selectedCol: Int
    var movablePos: [(Int, Int)] //(row, col)
    var selectedCellIdx: Int
    
    init(){
        self.cells = [
            BoardCell(row: 1, col: 1, position: .up, movable: [(1,1)]),
            BoardCell(row: 1, col: 2, position: .up, movable: [(1,1),(1,2)]),
            BoardCell(row: 1, col: 3, position: .up, movable: [(1,2),(1,3)]),
            BoardCell(row: 1, col: 4, position: .up, movable: [(1,3)]),
            BoardCell(row: 2, col: 1, position: .up, movable: [(1,1),(2,1)]),
            BoardCell(row: 2, col: 2, position: .up, movable: [(1,1),(1,2),(2,1),(2,2)]),
            BoardCell(row: 2, col: 3, position: .up, movable: [(1,2),(2,2),(1,3),(2,3)]),
            BoardCell(row: 2, col: 4, position: .up, movable: [(1,3),(2,3)]),
            BoardCell(row: 3, col: 1, position: .up, movable: [(2,1),(3,1)]),
            BoardCell(row: 3, col: 2, position: .up, movable: [(2,1),(3,1),(2,2),(3,2)]),
            BoardCell(row: 3, col: 3, position: .up, movable: [(2,2),(3,2),(2,3),(3,3)]),
            BoardCell(row: 3, col: 4, position: .up, movable: [(2,3),(3,3)]),
            BoardCell(row: 4, col: 1, position: .up, movable: [(3,1)]),
            BoardCell(row: 4, col: 2, position: .up, movable: [(3,1),(3,2)]),
            BoardCell(row: 4, col: 3, position: .up, movable: [(3,2),(3,3)]),
            BoardCell(row: 4, col: 4, position: .up, movable: [(3,3)]),
            
            BoardCell(row: 1, col: 1, position: .down, movable: [(1,1),(1,2),(2,1),(2,2)]),
            BoardCell(row: 1, col: 2, position: .down, movable: [(1,2),(1,3),(2,2),(2,3)]),
            BoardCell(row: 1, col: 3, position: .down, movable: [(1,3),(1,4),(2,3),(2,4)]),
            BoardCell(row: 2, col: 1, position: .down, movable: [(2,1),(2,2),(3,1),(3,2)]),
            BoardCell(row: 2, col: 2, position: .down, movable: [(2,2),(2,3),(3,2),(3,3)]),
            BoardCell(row: 2, col: 3, position: .down, movable: [(2,3),(2,4),(3,3),(3,4)]),
            BoardCell(row: 3, col: 1, position: .down, movable: [(3,1),(3,2),(4,1),(4,2)]),
            BoardCell(row: 3, col: 2, position: .down, movable: [(3,2),(3,3),(4,2),(4,3)]),
            BoardCell(row: 3, col: 3, position: .down, movable: [(3,3),(3,4),(4,3),(4,4)])
        ]
        self.red = Player(side: .red)
        self.blue = Player(side: .blue)
        self.turn = .blue
        self.isFirst = true
        self.isSelected = false
        self.selectedRow = -1
        self.selectedCol = -1
        self.movablePos = []
        self.selectedCellIdx = -1
    }
}
