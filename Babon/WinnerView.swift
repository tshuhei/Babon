//
//  WinnerView.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/31.
//

import SwiftUI

struct WinnerView: View {
    @Binding var winner: PlayerSide
    @Binding var board: Board
    var body: some View {
        VStack{
            if winner == .blue{
                Spacer()
                Text("BLUE   WIN!")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding()
                    .font(.largeTitle)
                    .background(.blue)
                Spacer()
                    .frame(width: 100, height: 40)
                Button(action: {
                    board = Board()
                }, label: {
                    ZStack{
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color("downNeutral"))
                        Circle()
                            .stroke(.black, lineWidth: 10)
                            .frame(width: 100, height: 100)
                        Text("Restart")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .font(.title2)
                    }
                })
            }else{
                Spacer()
                Text("RED   WIN!")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding()
                    .font(.largeTitle)
                    .background(.red)
                Spacer()
                    .frame(width: 100, height: 40)
                Button(action: {
                    board = Board()
                }, label: {
                    ZStack{
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color("downNeutral"))
                        Circle()
                            .stroke(.black, lineWidth: 10)
                            .frame(width: 100, height: 100)
                        Text("Restart")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .font(.title2)
                    }
                })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.45))
    }
}

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        WinnerView(winner: .constant(.blue), board: .constant(Board()))
    }
}
