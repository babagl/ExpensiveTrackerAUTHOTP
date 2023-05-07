//
//  LoginViewView.swift
//  ExpensesTrackerOtpAuth
//
//  Created by Abdoulaye Aliou SALL on 02/05/2023.
//

import SwiftUI

struct LoginViewView: View {
    @StateObject var otpViewModel : OtpViewModel = .init()
    var body: some View {
        VStack{
            HStack(spacing: 10){
                VStack(spacing: 8){
                    TextField("+221", text: $otpViewModel.code)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                    Rectangle()
                        .fill(otpViewModel.code == "" ? .gray.opacity(0.35) :.blue)
                        .frame(height: 2)
                }
                .frame(width: 40)
                VStack(spacing: 8){
                    TextField("771234567", text: $otpViewModel.number)
                        .keyboardType(.numberPad)
                    Rectangle()
                        .fill(otpViewModel.number == "" ? .gray.opacity(0.35) :.blue)
                        .frame(height: 2)
                }
            }
            .padding(.vertical)
            Button {
                Task{await otpViewModel.sendOtp()}
            } label: {
                Text("Connexion")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical,12)
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius:10,style: .continuous)
                            .fill(.blue)
                            .opacity(otpViewModel.isLoading ? 0 : 1)
                    }
                    .overlay{
                        ProgressView()
                            .opacity(otpViewModel.isLoading ? 1 : 0)
                    }
            }
            .disabled(otpViewModel.code == "" || otpViewModel.number == "")
            .opacity(otpViewModel.code == "" || otpViewModel.number == "" ? 0.4 : 1)
        }
        .navigationTitle("Connexion")
        .padding()
        .frame(maxHeight:.infinity , alignment:.top)
        .background{
            NavigationLink(tag: "VERIFICATION", selection: $otpViewModel.navigationTag){
                Verification()
                    .environmentObject(otpViewModel)
            }label: {}
            .labelsHidden()
        }
        .alert(otpViewModel.errorMsg, isPresented: $otpViewModel.showAlert){
            
        }
    }
}

struct LoginViewView_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewView()
    }
}
