//
//  MultiPlayView.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import SwiftUI
import FirebaseFunctions

struct MultiPlayView: View {
    @Environment(\.dismiss) var dismiss
    @State private var roomID = ""
    @State private var labelStr: String = "default"
    let functions = Functions.functions()
    
    init(){
        functions.useEmulator(withHost: "localhost", port: 5001)
    }
    
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                TextField("Input roomID", text: $roomID)
                                .padding()
                                .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 50)
                Button(action: {
                    print(roomID)
                    functions.httpsCallable("helloWorld").call(["text": roomID]){ result, error in
                        if let error = error{
                            debugPrint(error.localizedDescription)
                        }else{
                            labelStr = result!.data as! String
                        }
                    }
                }, label: {
                    Text("Connect")
                })
                Spacer()
                Text(labelStr)

            }
            .navigationBarHidden(true)
            
            VStack {
                HStack {
                    Button(
                        action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "arrow.backward")
                        }
                    )
                    .tint(.black)
                    Spacer()
                }
                Spacer()
            }
            .padding(.leading)
            
        }
       
    }
}

struct MultiPlayView_Previews: PreviewProvider {
    static var previews: some View {
        MultiPlayView()
    }
}
