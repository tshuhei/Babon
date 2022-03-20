//
//  StartView.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import SwiftUI

struct StartView: View {
    @State private var cells: [BoardCell] = BoardView_Previews.cells
    var body: some View {
        VStack{
            PawnView(numPawnAvailable: 2, playerSide: .red)
            Spacer().frame(height: 30)
            BoardView(cells: $cells)
            Spacer().frame(height: 30)
            PawnView(numPawnAvailable: 1, playerSide: .blue)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
