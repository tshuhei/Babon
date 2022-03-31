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
    @Binding var isSandwitched: Bool
    @Binding var selectedRow: Int
    @Binding var selectedCol: Int
    @Binding var movablePos: [(Int, Int)]
    @Binding var selectedCellIdx: Int
    @Binding var sandwitchedCellIdx: Int
    @Binding var isWinner: Bool
    
    init(board: Binding<Board>){
        self._cells = board.cells
        self._red = board.red
        self._blue = board.blue
        self._turn = board.turn
        self._isFirst = board.isFirst
        self._isSelected = board.isSelected
        self._isSandwitched = board.isSandwitdhed
        self._selectedRow = board.selectedRow
        self._selectedCol = board.selectedCol
        self._movablePos = board.movablePos
        self._selectedCellIdx = board.selectedCellIdx
        self._sandwitchedCellIdx = board.sandwitchedCellIdx
        self._isWinner = board.isWinner
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
        return ret
    }
    
    private func resetMovable(){
        for i in 0..<(cells.count){
            cells[i].isMovable = false
        }
    }
    
    private func judgeWinner(cellIndex: Int, row: Int, col: Int, pos: CellPosition){
        judgeHorizontal(cellIndex: cellIndex, row: row, col: col, pos: pos)
        judgeVertical(cellIndex: cellIndex, row: row, col: col, pos: pos)
        judgeTopLeft(cellIndex: cellIndex, row: row, col: col, pos: pos)
        judgeTopRight(cellIndex: cellIndex, row: row, col: col, pos: pos)
        if isWinner{
            print("\(turn) Win!")
            isWinner = false
        }
    }
    
    private func judgeHorizontal(cellIndex: Int, row: Int, col: Int, pos: CellPosition){
        var horcol: Int = col - 1
        var limcol: Int = 4
        var numPlayerPawn: Int = 1
        if pos == .down{
            limcol = 3
        }
        while horcol >= 1{
            let idx: Int = cells.firstIndex(where: {$0.row == row && $0.col == horcol && $0.position == pos})!
            if (cells[idx].cellStatus == .red && turn == .red) || (cells[idx].cellStatus == .blue && turn == .blue){
                horcol -= 1
                numPlayerPawn += 1
            }else{
                break
            }
        }
        horcol = col + 1
        while horcol <= limcol{
            let idx: Int = cells.firstIndex(where: {$0.row == row && $0.col == horcol && $0.position == pos})!
            if (cells[idx].cellStatus == .red && turn == .red) || (cells[idx].cellStatus == .blue && turn == .blue){
                horcol += 1
                numPlayerPawn += 1
            }else{
                break
            }
        }
        if numPlayerPawn == 3{
            isWinner = true
        }
    }
    
    private func judgeVertical(cellIndex: Int, row: Int, col: Int, pos: CellPosition){
        var verrow: Int = row - 1
        var limrow: Int = 4
        var numPlayerPawn: Int = 1
        if pos == .down{
            limrow = 3
        }
        while verrow >= 1{
            let idx: Int = cells.firstIndex(where: {$0.row == verrow && $0.col == col && $0.position == pos})!
            if (cells[idx].cellStatus == .red && turn == .red) || (cells[idx].cellStatus == .blue && turn == .blue){
                verrow -= 1
                numPlayerPawn += 1
            }else{
                break
            }
        }
        verrow = row + 1
        while verrow <= limrow{
            let idx: Int = cells.firstIndex(where: {$0.row == verrow && $0.col == col && $0.position == pos})!
            if (cells[idx].cellStatus == .red && turn == .red) || (cells[idx].cellStatus == .blue && turn == .blue){
                verrow += 1
                numPlayerPawn += 1
            }else{
                break
            }
        }
        if numPlayerPawn == 3{
            isWinner = true
        }
    }
    
    private func judgeTopLeft(cellIndex: Int, row: Int, col: Int, pos: CellPosition){
        var diagrow: Int = row - 1
        var diagcol: Int = col - 1
        var lim: Int = 4
        var numPlayerPawn: Int = 1
        if pos == .down{
            lim = 3
        }
        while diagrow >= 1 && diagcol >= 1{
            let idx: Int = cells.firstIndex(where: {$0.row == diagrow && $0.col == diagcol && $0.position == pos})!
            if (cells[idx].cellStatus == .red && turn == .red) || (cells[idx].cellStatus == .blue && turn == .blue){
                diagrow -= 1
                diagcol -= 1
                numPlayerPawn += 1
            }else{
                break
            }
        }
        diagrow = row + 1
        diagcol = col + 1
        while diagrow <= lim && diagcol <= lim{
            let idx: Int = cells.firstIndex(where: {$0.row == diagrow && $0.col == diagcol && $0.position == pos})!
            if (cells[idx].cellStatus == .red && turn == .red) || (cells[idx].cellStatus == .blue && turn == .blue){
                diagrow += 1
                diagcol += 1
                numPlayerPawn += 1
            }else{
                break
            }
        }
        if numPlayerPawn == 3{
            isWinner = true
        }
    }
    
    private func judgeTopRight(cellIndex: Int, row: Int, col: Int, pos: CellPosition){
        var diagrow: Int = row - 1
        var diagcol: Int = col + 1
        var lim: Int = 4
        var numPlayerPawn: Int = 1
        if pos == .down{
            lim = 3
        }
        while diagrow >= 1 && diagcol <= lim{
            let idx: Int = cells.firstIndex(where: {$0.row == diagrow && $0.col == diagcol && $0.position == pos})!
            if (cells[idx].cellStatus == .red && turn == .red) || (cells[idx].cellStatus == .blue && turn == .blue){
                diagrow -= 1
                diagcol += 1
                numPlayerPawn += 1
            }else{
                break
            }
        }
        diagrow = row + 1
        diagcol = col - 1
        while diagrow <= lim && diagcol >= 1{
            let idx: Int = cells.firstIndex(where: {$0.row == diagrow && $0.col == diagcol && $0.position == pos})!
            if (cells[idx].cellStatus == .red && turn == .red) || (cells[idx].cellStatus == .blue && turn == .blue){
                diagrow += 1
                diagcol -= 1
                numPlayerPawn += 1
            }else{
                break
            }
        }
        if numPlayerPawn == 3{
            isWinner = true
        }
    }
    
    private func findSandwitch(cellIndex: Int, row: Int, col: Int, pos: CellPosition){
        // start find sandwitched pawn
        var idxList: [(Int,Int)] = []
        for r in stride(from: row-2, to: row+3, by: 2){
            for c in stride(from: col-2, to: col+3, by: 2){
                if r == row && c == col{
                    continue
                }
                switch pos{
                case .up:
                    if (0 < r && r < 5) && (0 < c && c < 5){
                        idxList.append((r,c))
                    }
                case .down:
                    if (0 < r && r < 4) && (0 < c && c < 4){
                        idxList.append((r,c))
                    }
                }
            }
        }
        for (r,c) in idxList{
            var swedR: Int = -1 //row of sandwitched cell
            var swedC: Int = -1 //col of sandwitched cell
            //decide swedR
            if row - r == -2{
                swedR = row + 1
            }else if row - r == 0{
                swedR = row
            }else{
                swedR = row - 1
            }
            //decide swedC
            if col - c == -2{
                swedC = col + 1
            }else if col - c == 0{
                swedC = col
            }else{
                swedC = col - 1
            }
            let swIdx: Int = cells.firstIndex(where: {$0.row == r && $0.col == c && $0.position == pos})!
            let swedIdx: Int = cells.firstIndex(where: {$0.row == swedR && $0.col == swedC && $0.position == pos})!
            switch turn{
            case .red:
                if cells[swIdx].cellStatus == .red && cells[swedIdx].cellStatus == .blue{
                    sandwitchedCellIdx = swedIdx
                    isSandwitched = true
                }
            case .blue:
                if cells[swIdx].cellStatus == .blue && cells[swedIdx].cellStatus == .red{
                    sandwitchedCellIdx = swedIdx
                    isSandwitched = true
                }
            }
        }
        // end find sandwitched pawn
        
        if sandwitchedCellIdx != -1{
            cells[sandwitchedCellIdx].cellColor = .black
        }
    }
    
    private func cellTapGesture(cellIndex: Int, row: Int, col: Int, pos: CellPosition){
        // if a sandwitched pawn is moved to a neutral cell
        if isSandwitched && cells[cellIndex].cellStatus == .neutral{
            cells[sandwitchedCellIdx].cellStatus = .neutral
            switch turn{
            case .red:
                cells[cellIndex].cellStatus = .red
                if pos == .up{
                    cells[cellIndex].cellColor = Color("upRed")
                }else{
                    cells[cellIndex].cellColor = Color("downRed")
                }
            case .blue:
                cells[cellIndex].cellStatus = .blue
                if pos == .up{
                    cells[cellIndex].cellColor = Color("upBlue")
                }else{
                    cells[cellIndex].cellColor = Color("upBlue")
                }
            }
            if cells[sandwitchedCellIdx].position == .up{
                cells[sandwitchedCellIdx].cellColor = Color("upNeutral")
            }else{
                cells[sandwitchedCellIdx].cellColor = Color("downNeutral")
            }
            isSandwitched = false
            sandwitchedCellIdx = -1
        }
        // if no pawn is available
        else if (turn == .red && red.numPawnAvailable == 0) || (turn == .blue && blue.numPawnAvailable == 0){
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
                    findSandwitch(cellIndex: cellIndex, row: row, col: col, pos: pos)
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
                    judgeWinner(cellIndex: cellIndex, row: row, col: col, pos: pos)
                    findSandwitch(cellIndex: cellIndex, row: row, col: col, pos: pos)
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
        }else if isFirst && ((row != 2 && row != 3) || (col != 2 && col != 3)){
            return
        }else{
        
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
                    judgeWinner(cellIndex: cellIndex, row: row, col: col, pos: pos)
                    findSandwitch(cellIndex: cellIndex, row: row, col: col, pos: pos)
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
                    judgeWinner(cellIndex: cellIndex, row: row, col: col, pos: pos)
                    findSandwitch(cellIndex: cellIndex, row: row, col: col, pos: pos)
                    turn = .red
                }
            }
        }
        }
        if isFirst{
            isFirst = false
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
                            //Text(cells[cellIndex!].cellStatus.rawValue)
                                //.font(.footnote)
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
                                        }
                                }
                                if (cells[subcellIndex!].isMovable){
                                    Circle()
                                        .stroke(Color("downRed"), lineWidth: 6)
                                        .frame(width: 35, height: 35)
                                }
                                //Text(cells[subcellIndex!].cellStatus.rawValue)
                                    //.font(.footnote)
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
