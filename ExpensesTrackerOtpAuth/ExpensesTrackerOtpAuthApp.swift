//
//  ExpensesTrackerOtpAuthApp.swift
//  ExpensesTrackerOtpAuth
//
//  Created by Abdoulaye Aliou SALL on 01/05/2023.
//

import SwiftUI

@main
struct ExpensesTrackerOtpAuthApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
