//
//  WinnerView.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/31.
//

import SwiftUI

struct WinnerView: View {
    @Binding var winner: PlayerSide
    
    var body: some View {
        VStack{
            if winner == .blue{
                Text("Blue Win!")
                    .rotationEffect(Angle(degrees: 180))
                    .foregroundColor(.blue)
                Spacer()
                    .frame(width: 100, height: 100)
                Text("Blue Win!")
                    .foregroundColor(.blue)
            }else{
                Text("Red Win!")
                    .rotationEffect(Angle(degrees: 180))
                    .foregroundColor(.red)
                Spacer()
                    .frame(width: 100, height: 100)
                Text("Red Win!")
                    .foregroundColor(.red)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.3))
    }
}

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        WinnerView(winner: .constant(.blue))
    }
}
