//
//  StartView.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import SwiftUI

struct StartView: View {
    @Environment(\.dismiss) var dismiss
    @State private var board: Board = Board()
    var body: some View {
        ZStack{
            
            TurnView(turn: $board.turn)
            
            VStack{
                PawnView(numPawnAvailable: $board.red.numPawnAvailable, playerSide: .red)
                Spacer().frame(height: 30)
                BoardView(board: $board)
                Spacer().frame(height: 30)
                PawnView(numPawnAvailable: $board.blue.numPawnAvailable, playerSide: .blue)
            }
            
            Button(
                action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.backward")
                }
            )
            .tint(.black)
            .position(x: 20, y: 10)
        }
        .navigationBarHidden(true)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .previewDevice("iPhone 12 mini")
    }
}
