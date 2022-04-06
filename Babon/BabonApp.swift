//
//  BabonApp.swift
//  Babon
//
//  Created by 釣谷周平 on 2022/03/20.
//

import SwiftUI
import Firebase
import UserNotifications
import FirebaseMessaging

@main
struct BabonApp: App {
    @UIApplicationDelegateAdaptor (AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                StartMenuView()
            }
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
       func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
          FirebaseApp.configure()
          Messaging.messaging().delegate = self
          UNUserNotificationCenter.current().delegate = self
          
          // Push通知許可のポップアップを表示
          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          //let authOptions: UNAuthorizationOptions = []
          UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, _ in
             guard granted else { return }
             DispatchQueue.main.async {
                application.registerForRemoteNotifications()
             }
          }
           
           /*Messaging.messaging().token { token, error in
             if let error = error {
               print("Error fetching FCM registration token: \(error)")
             } else if let token = token {
               print("FCM registration token: \(token)")
               //self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
             }
           }
           
           let t: String = Messaging.messaging().fcmToken!
           print("this is fcm token:")
           print(t)*/
          return true
       }
        
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            //Messaging.messaging().apnsToken = deviceToken
            Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
            Messaging.messaging().token { token, error in
              if let error = error {
                print("Error fetching FCM registration token: \(error)")
              } else if let token = token {
                print("FCM registration token: \(token)")
                //self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
              }
            }
        }
        
        
        
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            if let messageID = userInfo["gcm.message_id"] {
               print("MessageID: \(messageID)")
            }
            print(userInfo)
            completionHandler(.newData)
        }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            let userInfo = notification.request.content.userInfo
            //print(userInfo)
            let aps = userInfo["aps"] as! NSDictionary
            let alert = aps["alert"] as! NSDictionary
            let body = alert["body"]!
            print("This is message")
            print(body)
            completionHandler([])
           }
        
        func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
          print("Firebase registration token: \(String(describing: fcmToken))")

          let dataDict: [String: String] = ["token": fcmToken ?? ""]
          NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
          )
          // TODO: If necessary send token to application server.
          // Note: This callback is fired at each app startup and whenever a new token is generated.
        }
        
        /*func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
              guard let fcmToken = fcmToken else { return }
              if let uid = Auth.auth().currentUser?.uid {
                 setFcmToken(uid: uid, fcmToken: fcmToken)
              }
           }*/
    }
    
    /*class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            Messaging.messaging().delegate = self

            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
            )
            application.registerForRemoteNotifications()

            Messaging.messaging().token { token, error in
              if let error = error {
                print("Error fetching FCM registration token: \(error)")
              } else if let token = token {
                print("FCM registration token: \(token)")
                //self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
              }
            }
            
            return true
        }
        
        func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
          print("Firebase registration token: \(String(describing: fcmToken))")

          let dataDict: [String: String] = ["token": fcmToken ?? ""]
          NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
          )
          // TODO: If necessary send token to application server.
          // Note: This callback is fired at each app startup and whenever a new token is generated.
        }
    }
    // UIResponder*/
}
