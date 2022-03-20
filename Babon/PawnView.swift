//
//  PawnView.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import SwiftUI

struct PawnView: View {
    var numPawnAvailable: Int
    var numPawnUnavailable: Int
    var playerSide: PlayerSide
    
    init(numPawnAvailable: Int, playerSide: PlayerSide){
        self.numPawnAvailable = numPawnAvailable
        self.playerSide = playerSide
        self.numPawnUnavailable = 4 - numPawnAvailable
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
        PawnView(numPawnAvailable: numPawnAvailable, playerSide: playerSide)
            .previewLayout(.fixed(width: 400, height: 70))
    }
}
