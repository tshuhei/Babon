//
//  BoardView.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import SwiftUI

struct BoardView: View {
    @Binding var cells: [BoardCell]
    @Binding var red: Player
    @Binding var blue: Player
    @Binding var turn: PlayerSide
    
    init(board: Binding<Board>){
        self._cells = board.cells
        self._red = board.red
        self._blue = board.blue
        self._turn = board.turn
    }
    
    var body: some View {
        VStack(spacing: 5){
            ForEach(1..<5){ row in
                HStack(spacing: 5){
                    ForEach(1..<5){ col in
                        let cellIndex: Int? = cells.firstIndex(where: {$0.row == row && $0.col == col && $0.position == .up})
                        Rectangle()
                            .cornerRadius(6)
                            .frame(width: 60, height: 60)
                            .onTapGesture {
                                
                                switch turn{
                                case .red:
                                    if red.numPawnAvailable > 0{
                                        if cells[cellIndex!].cellStatus == .neutral{
                                            cells[cellIndex!].cellStatus = .red
                                            cells[cellIndex!].cellColor = Color("upRed")
                                            red.numPawnAvailable -= 1
                                            turn = .blue
                                        }
                                    }
                                case .blue:
                                    if blue.numPawnAvailable > 0{
                                        if cells[cellIndex!].cellStatus == .neutral{
                                            cells[cellIndex!].cellStatus = .blue
                                            cells[cellIndex!].cellColor = Color("upBlue")
                                            blue.numPawnAvailable -= 1
                                            turn = .red
                                        }
                                    }
                                }
                            }
                            .foregroundColor(cells[cellIndex!].cellColor)
                    }
                }
            }
        }
        .overlay(){
            VStack(spacing: 25){
                ForEach(1..<4){ subrow in
                    HStack(spacing: 25){
                        ForEach(1..<4){ subcol in
                            let subcellIndex: Int? = cells.firstIndex(where: {$0.row == subrow && $0.col == subcol && $0.position == .down})
                            Circle()
                                .strokeBorder(.white, lineWidth: 4)
                                .frame(width: 40, height: 40)
                                .background(Circle().fill(cells[subcellIndex!].cellColor))
                                .onTapGesture{
                                    
                                    switch turn{
                                    case .red:
                                        if red.numPawnAvailable > 0{
                                            if cells[subcellIndex!].cellStatus == .neutral{
                                                cells[subcellIndex!].cellStatus = .red
                                                cells[subcellIndex!].cellColor = Color("upRed")
                                                red.numPawnAvailable -= 1
                                                turn = .blue
                                            }
                                        }
                                    case .blue:
                                        if blue.numPawnAvailable > 0{
                                            if cells[subcellIndex!].cellStatus == .neutral{
                                                cells[subcellIndex!].cellStatus = .blue
                                                cells[subcellIndex!].cellColor = Color("upBlue")
                                                blue.numPawnAvailable -= 1
                                                turn = .red
                                            }
                                        }
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var cells = [
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
        BoardCell(row: 3, col: 3, position: .down),
    ]
    static var previews: some View {
        BoardView(board: .constant(Board()))
            .previewDevice("iPhone 12 mini")
    }
}
