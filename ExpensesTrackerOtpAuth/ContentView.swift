//
//  ContentView.swift
//  ExpensesTrackerOtpAuth
//
//  Created by Abdoulaye Aliou SALL on 01/05/2023.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @AppStorage("log_status") var log_Status = false
    var body: some View {
        NavigationView{
            if log_Status {
                VStack {
                    MainView()
                }
                
            }else{
                LoginViewView()
            }
        }
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
