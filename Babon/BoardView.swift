//
//  BoardView.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import SwiftUI

struct BoardView: View {
    @Binding var cells: [BoardCell]
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
                                    switch cells[cellIndex!].cellStatus{
                                    case .neutral:
                                        cells[cellIndex!].cellStatus = .red
                                        cells[cellIndex!].cellColor = Color("upRed")
                                    case .red:
                                        cells[cellIndex!].cellStatus = .blue
                                        cells[cellIndex!].cellColor = Color("upBlue")
                                    case .blue:
                                        cells[cellIndex!].cellStatus = .neutral
                                        cells[cellIndex!].cellColor = Color("upNeutral")
                                    }
                                    
                                    //print("Cell info\nrow: \(cells[cellIndex!].row)\ncol: \(cells[cellIndex!].col)\nposition: \(cells[cellIndex!].position)\nstatus: \(cells[cellIndex!].cellStatus)\ncolor: \(cells[cellIndex!].cellColor)\n\n")
                                    //print("row: \(row), col \(col)")
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
                                .frame(width: 40, height: 40)
                                .onTapGesture{
                                    switch cells[subcellIndex!].cellStatus{
                                    case .neutral:
                                        cells[subcellIndex!].cellStatus = .red
                                        cells[subcellIndex!].cellColor = Color("downRed")
                                    case .red:
                                        cells[subcellIndex!].cellStatus = .blue
                                        cells[subcellIndex!].cellColor = Color("downBlue")
                                    case .blue:
                                        cells[subcellIndex!].cellStatus = .neutral
                                        cells[subcellIndex!].cellColor = Color("downNeutral")
                                    }
                                    
                                    //print("Cell info\nrow: \(subcell!.row)\ncol: \(subcell!.col)\nposition: \(subcell!.position)\nstatus: \(subcell!.cellStatus)\ncolor: \(subcell!.cellColor)\n\n")
                                    //print("subfield row: \(subrow), col: \(subcol)")
                                }
                                .foregroundColor(cells[subcellIndex!].cellColor)
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
        BoardView(cells: .constant(cells))
    }
}
