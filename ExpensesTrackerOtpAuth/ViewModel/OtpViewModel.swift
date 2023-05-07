//
//  OtpViewModel.swift
//  ExpensesTrackerOtpAuth
//
//  Created by Abdoulaye Aliou SALL on 01/05/2023.
//

import Foundation
import SwiftUI
import Firebase

class OtpViewModel: ObservableObject {
    // login data
    @Published var number : String = ""
    @Published var code : String = ""
    
    @Published var otpText : String = ""
    @Published var otpFields : [String] = Array(repeating: "", count: 6)
    
    // error
    @Published var showAlert :Bool = false
    @Published var errorMsg : String = ""
    
    // otp credentiel
    @Published var verificationCode : String = ""
    @Published var isLoading : Bool = false
    
    @Published var navigationTag : String?
    @AppStorage("log_status") var log_status = false
    
    
    //sending otp
    func sendOtp() async{
        if isLoading{return}
        do{
            isLoading = true
            let result = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(code)\(number)", uiDelegate: nil)
            DispatchQueue.main.async {
                self.isLoading = false
                self.verificationCode = result
                self.navigationTag = "VERIFICATION"
            }
            
        }catch{
            handleError(error: error.localizedDescription)
        }
    }
    
    
    func handleError(error : String){
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMsg = error
            self.showAlert.toggle()
        }
    }
    
    func verifyOtp()async{
        do{
            isLoading = true
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationCode, verificationCode: otpText)
            let _ = try await Auth.auth().signIn(with: credential)
            DispatchQueue.main.async {[self] in
                isLoading = false
                log_status = true
            }
        }catch{
            handleError(error: error.localizedDescription)
        }
        
    }
}
