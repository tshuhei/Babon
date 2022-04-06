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
    @State private var statusText: String = ""
    @State private var inputDisable: Bool = false
    @State private var isMove: Bool = false
    let functions = Functions.functions()
    
    init(){
        functions.useEmulator(withHost: "localhost", port: 5001)
    }
    
    var body: some View {
        ZStack {
            NavigationLink(destination: StartView(), isActive: $isMove){
                EmptyView()
            }
            VStack{
                Spacer()
                TextField("Input roomID", text: $roomID)
                                .padding()
                                .multilineTextAlignment(.center)
                                .disabled(inputDisable)
                
                Spacer()
                    .frame(height: 50)
                
                Button(action: {
                    print(roomID)
                    inputDisable = true
                    statusText = "Making Room: \(roomID)"
                    functions.httpsCallable("makeRoom").call(["roomID": roomID]){ result, error in
                        if let error = error{
                            debugPrint(error.localizedDescription)
                        }else{
                        let data = result?.data as? [String: Any]
                        let message = (data?["message"] as? String)!
                        let status = (data?["status"] as? Int)!
                        print(message)
                        print(String(status))
                        // if the room is successfully made
                        if (status) == 1{
                            statusText = message
                            isMove = true
                        }
                        // if the room already exists
                        else if (status) == 2{
                            statusText = message
                            inputDisable = false
                        }
                        }
                    }
                }, label: {
                    Text("Make room")
                })
                .disabled(inputDisable)
                
                Spacer()
                    .frame(height: 30)
                
                Button(action: {
                    inputDisable = true
                    statusText = "Connecting Room: \(roomID)"
                    print(roomID)
                    functions.httpsCallable("connectRoom").call(["roomID": roomID]){ result, error in
                        if let error = error{
                            debugPrint(error.localizedDescription)
                        }else{
                            let data = result?.data as? [String: Any]
                            let message = (data?["message"] as? String)!
                            let status = (data?["status"] as? Int)!
                            print(message)
                            print(String(status))
                            // if the connection is successfully made
                            if (status) == 1{
                                statusText = message
                                isMove = true
                            }
                            // if the room doesn't exist
                            else if (status) == 2{
                                statusText = message
                                inputDisable = false
                            }
                        }
                    }
                }, label: {
                    Text("Connect room")
                })
                .disabled(inputDisable)
                
                Spacer()
                    .frame(height: 30)
                
                Text(statusText)
                Spacer()
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
