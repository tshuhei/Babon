//
//  BabonApp.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import SwiftUI
import Firebase

@main
struct BabonApp: App {
    @UIApplicationDelegateAdaptor (AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                StartMenuView()
            }
        }
    }
    
    class AppDelegate: UIResponder, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            
            return true
        }
    }
}
