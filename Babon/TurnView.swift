//
//  TurnView.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/21.
//

import SwiftUI

struct TurnView: View {
    @Binding var turn: PlayerSide
    var redColor: Color{
        switch turn{
        case .red:
            return Color("upRed")
        case .blue:
            return Color("upNeutral")
        }
    }
    var blueColor: Color{
        switch turn{
        case .red:
            return Color("upNeutral")
        case .blue:
            return Color("upBlue")
        }
    }
    
    var body: some View {
        VStack{
            Path { path in
                path.addArc(
                    center: CGPoint(x: 100, y: -180),
                    radius: 300,
                    startAngle: .degrees(0),
                    endAngle: .degrees(180),
                    clockwise: false
                )
                path.addLine(to: CGPoint(x: 100, y: -180))
                path.closeSubpath()
            }
            .fill(redColor)
            .frame(width: 200, height: 200)
            
            Spacer()
            
            Path { path in
                path.addArc(
                    center: CGPoint(x: 100, y: 380),
                    radius: 300,
                    startAngle: .degrees(0),
                    endAngle: .degrees(180),
                    clockwise: true
                )
                path.addLine(to: CGPoint(x: 100, y: 380))
                path.closeSubpath()
            }
            .fill(blueColor)
            .frame(width: 200, height: 200)
        }
    }
}

struct TurnView_Previews: PreviewProvider {
    static var previews: some View {
        TurnView(turn: .constant(.blue))
    }
}
