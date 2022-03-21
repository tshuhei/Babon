//
//  PawnView.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import SwiftUI

struct PawnView: View {
    @Binding var numPawnAvailable: Int
    var numPawnUnavailable: Int{
        4 - numPawnAvailable
    }
    var playerSide: PlayerSide
    
    init(numPawnAvailable: Binding<Int>, playerSide: PlayerSide){
        self._numPawnAvailable = numPawnAvailable
        self.playerSide = playerSide
    }
    
    var body: some View {
        HStack{
            ForEach(1..<5){ num in
                if playerSide == .red{
                    if num <= numPawnAvailable{
                        Circle()
                            .foregroundColor(.red)
                            .frame(width: 20, height: 20)
                    }
                    else{
                        Circle()
                            .foregroundColor(.red.opacity(0.2))
                            .frame(width: 20, height: 20)
                    }
                }else{
                    if num <= numPawnAvailable{
                        Circle()
                            .foregroundColor(.blue)
                            .frame(width: 20, height: 20)
                    }
                    else{
                        Circle()
                            .foregroundColor(.blue.opacity(0.2))
                            .frame(width: 20, height: 20)
                    }
                }
            }
        }
    }
}

struct PawnView_Previews: PreviewProvider {
    static let numPawnAvailable = 3
    static let playerSide = PlayerSide.red
    static var previews: some View {
        PawnView(numPawnAvailable: .constant(numPawnAvailable), playerSide: playerSide)
            .previewLayout(.fixed(width: 400, height: 70))
    }
}
