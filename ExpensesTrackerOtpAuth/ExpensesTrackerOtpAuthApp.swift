//
//  ExpensesTrackerOtpAuthApp.swift
//  ExpensesTrackerOtpAuth
//
//  Created by Abdoulaye Aliou SALL on 01/05/2023.
//

import SwiftUI
import Firebase

@main
struct ExpensesTrackerOtpAuthApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    
    class AppDelegate : NSObject, UIApplicationDelegate{
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            return true
        }
        // since otp required remote
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
            return .noData
        }
    }
}
