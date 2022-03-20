//
//  ContentView.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import SwiftUI

struct StartMenuView: View {
    var body: some View {
        VStack(alignment: .center) {
            
            Spacer().frame(height: 100)
            
            Text("Babon")
                .padding(.all, 20)
                .font(.title)
                .background(.red)
            
            Spacer().frame(height: 70)
            VStack{
                    NavigationLink(destination: StartView()){
                        Text("Start")
                            .font(.title2)
                            .fontWeight(.light)
                            .frame(width: 150.0, height: 50.0)
                            .background(.yellow)
                            .foregroundColor(Color("Text"))
                            .cornerRadius(15)
                    }
                    Spacer().frame(height:30)
                    NavigationLink(destination: MultiPlayView()){
                        Text("Multi Play")
                            .fontWeight(.light)
                            .frame(width: 150.0, height: 50.0)
                            .background(.orange)
                            .foregroundColor(Color("Text"))
                            .cornerRadius(15)
                    }
                    Spacer().frame(height:30)
                    NavigationLink(destination: HowToPlayView()){
                        Text("How to Play")
                            .fontWeight(.light)
                            .frame(width: 150.0, height: 50.0)
                            .background(.purple)
                            .foregroundColor(Color("Text"))
                            .cornerRadius(15)
                    }
                    Spacer()
                    .navigationBarHidden(true)
            }
        }
    }
}

struct StartMenuView_Previews: PreviewProvider {
    static var previews: some View {
        StartMenuView()
    }
}
