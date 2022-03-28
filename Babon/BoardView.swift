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
    @Binding var isFirst: Bool
    @Binding var isSelected: Bool
    @Binding var selectedRow: Int
    @Binding var selectedCol: Int
    @Binding var movablePos: [(Int, Int)]
    @Binding var selectedCellIdx: Int
    
    init(board: Binding<Board>){
        self._cells = board.cells
        self._red = board.red
        self._blue = board.blue
        self._turn = board.turn
        self._isFirst = board.isFirst
        self._isSelected = board.isSelected
        self._selectedRow = board.selectedRow
        self._selectedCol = board.selectedCol
        self._movablePos = board.movablePos
        self._selectedCellIdx = board.selectedCellIdx
    }
    
    private func findMovablePos(cells: [BoardCell], pos: CellPosition, selectedCellIdx: Int) -> [(Int, Int)]{
        // get the selected cell
        var ret: [(Int, Int)] = []
        let movable: [(Int, Int)] = cells[selectedCellIdx].movable
        for (row,col) in movable{
            let cell: BoardCell? = cells.first(where: {($0.row == row) && ($0.col == col) && ($0.position != pos)})
            if cell!.cellStatus == .neutral{
                ret.append((row,col))
            }
        }
        //print()
        return ret
    }
    
    private func resetMovable(){
        for i in 0..<(cells.count){
            cells[i].isMovable = false
        }
    }
    
    private func cellTapGesture(cellIndex: Int, row: Int, col: Int, pos: CellPosition){
        // if no pawn is available
        if (turn == .red && red.numPawnAvailable == 0) || (turn == .blue && blue.numPawnAvailable == 0){
            // if the tapped cell is the player's cell and if no pawn is selected yet...
            if ((cells[cellIndex].cellStatus == .red && turn == .red) || (cells[cellIndex].cellStatus == .blue && turn == .blue)) && !isSelected{
                cells[cellIndex].cellColor = .black
                //cells[cellIndex].cellStatus = .neutral
                isSelected = true
                selectedRow = row
                selectedCol = col
                selectedCellIdx = cellIndex
                movablePos = findMovablePos(cells: cells, pos: pos, selectedCellIdx: selectedCellIdx)
                for (pr, pc) in movablePos{
                    let idx: Int? = cells.firstIndex(where: {$0.row == pr && $0.col == pc && $0.position == pos.rev})
                    cells[idx!].isMovable = true
                }
            // if the player tapped a movable cell...
            }else if isSelected && cells[cellIndex].isMovable{
                cells[cellIndex].isMovable = false
                isSelected = false
                resetMovable()
                switch turn{
                case .red:
                    cells[cellIndex].cellStatus = .red
                    cells[selectedCellIdx].cellStatus = .neutral
                    if pos == .up{
                        cells[cellIndex].cellColor = Color("upRed")
                        cells[selectedCellIdx].cellColor = Color("downNeutral")
                    }else{
                        cells[cellIndex].cellColor = Color("downRed")
                        cells[selectedCellIdx].cellColor = Color("upNeutral")
                    }
                    turn = .blue
                case .blue:
                    cells[cellIndex].cellStatus = .blue
                    cells[selectedCellIdx].cellStatus = .neutral
                    if pos == .up{
                        cells[cellIndex].cellColor = Color("upBlue")
                        cells[selectedCellIdx].cellColor = Color("downNeutral")
                    }else{
                        cells[cellIndex].cellColor = Color("downBlue")
                        cells[selectedCellIdx].cellColor = Color("upNeutral")

                    }
                    turn = .red
                }
            // if the player cancel the cell transition...
            }else if isSelected && cellIndex == selectedCellIdx{
                switch turn{
                case .red:
                    if pos == .up{
                        cells[cellIndex].cellColor = Color("upRed")
                    }else{
                        cells[cellIndex].cellColor = Color("downRed")
                    }
                case .blue:
                    if pos == .up{
                        cells[cellIndex].cellColor = Color("upBlue")
                    }else{
                        cells[cellIndex].cellColor = Color("downBlue")
                    }
                }
                isSelected = false
                resetMovable()
            }
            
            // if a pawn is already selected and if the tapped cell is movable...
            /*if isSelected && (movablePos.contains(where:{
                $0.0 == row && $0.1 == col})){
                //print("ok")
            }*/
        }else{
        if isFirst && ((row != 2 && row != 3) || (col != 2 && col != 3)){
            return
        }
        
        switch turn{
        case .red:
            if red.numPawnAvailable > 0{
                if cells[cellIndex].cellStatus == .neutral{
                    cells[cellIndex].cellStatus = .red
                    if pos == .up{
                        cells[cellIndex].cellColor = Color("upRed")
                    }else{
                        cells[cellIndex].cellColor = Color("downRed")
                    }
                    red.numPawnAvailable -= 1
                    turn = .blue
                }
            }
        case .blue:
            if blue.numPawnAvailable > 0{
                if cells[cellIndex].cellStatus == .neutral{
                    cells[cellIndex].cellStatus = .blue
                    if pos == .up{
                        cells[cellIndex].cellColor = Color("upBlue")
                    }else{
                        cells[cellIndex].cellColor = Color("downBlue")
                    }
                    blue.numPawnAvailable -= 1
                    turn = .red
                }
            }
        }
        if isFirst{
            isFirst = false
        }
        }
    }
    
    
    var body: some View {
        VStack(spacing: 5){
            ForEach(1..<5){ row in
                HStack(spacing: 5){
                    ForEach(1..<5){ col in
                        let cellIndex: Int? = cells.firstIndex(where: {$0.row == row && $0.col == col && $0.position == .up})
                        ZStack{
                            Rectangle()
                                .cornerRadius(6)
                                .frame(width: 60, height: 60)
                                .onTapGesture {
                                    
                                    cellTapGesture(cellIndex: cellIndex!, row: row, col: col, pos: .up)
                                    
                                    /*// if no pawn is available
                                    if (turn == .red && red.numPawnAvailable == 0) || (turn == .blue && blue.numPawnAvailable == 0){
                                        // if the tapped cell is the player's cell and if no pawn is selected yet...
                                        if ((cells[cellIndex!].cellStatus == .red && turn == .red) || (cells[cellIndex!].cellStatus == .blue && turn == .blue)) && !isSelected{
                                            cells[cellIndex!].cellColor = .black
                                            isSelected = true
                                            selectedRow = row
                                            selectedCol = col
                                            movablePos = findMovablePos(cells: cells, selectedRow: selectedRow, selectedCol: selectedCol)
                                            for (pr, pc) in movablePos{
                                                print("\(pr):\(pc)")
                                                let idx: Int? = cells.firstIndex(where: {$0.row == pr && $0.col == pc && $0.position == .down})
                                                cells[idx!].isMovable = true
                                            }
                                        }
                                        
                                        // if a pawn is already selected and if the tapped cell is movable...
                                        if isSelected && (movablePos.contains(where:{
                                            $0.0 == row && $0.1 == col})){
                                            print("ok")
                                        }
                                    }else{
                                    if isFirst && ((row != 2 && row != 3) || (col != 2 && col != 3)){
                                        return
                                    }
                                    
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
                                    if isFirst{
                                        isFirst = false
                                    }
                                    }*/
                                }
                                .foregroundColor(cells[cellIndex!].cellColor)
                            if (row == 2 || row == 3) && (col == 2 || col == 3){
                                if isFirst{
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color("downNeutral"), lineWidth: 5)
                                        .frame(width: 55, height: 55)
                                }
                            }
                            if cells[cellIndex!].isMovable{
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color("downRed"), lineWidth: 5)
                                    .frame(width: 55, height: 55)
                            }
                            Text(cells[cellIndex!].cellStatus.rawValue)
                                .font(.footnote)
                        }
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
                            ZStack {
                                Circle()
                                    .strokeBorder(.white, lineWidth: 4)
                                    .frame(width: 40, height: 40)
                                    .background(Circle().fill(cells[subcellIndex!].cellColor))
                                    .onTapGesture{
                                        if !isFirst{
                                            
                                            cellTapGesture(cellIndex: subcellIndex!, row: subrow, col: subcol, pos: .down)
                                            
                                            /*switch turn{
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
                                            }*/
                                        }
                                }
                                if (cells[subcellIndex!].isMovable){
                                    Circle()
                                        .stroke(Color("downRed"), lineWidth: 6)
                                        .frame(width: 35, height: 35)
                                }
                                Text(cells[subcellIndex!].cellStatus.rawValue)
                                    .font(.footnote)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(board: .constant(Board()))
            .previewDevice("iPhone 12 mini")
    }
}
