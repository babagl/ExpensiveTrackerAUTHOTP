//
//  Verification.swift
//  ExpensesTrackerOtpAuth
//
//  Created by Abdoulaye Aliou SALL on 01/05/2023.
//

import SwiftUI

struct Verification: View {
    @EnvironmentObject var otpViewModel : OtpViewModel 
    @FocusState var activeField : otpField?
    var body: some View {
        VStack{
            OtpField()
            
            Button {
                Task{await otpViewModel.verifyOtp()}
            } label: {
                Text("Verifier")
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
            .disabled(checkStates())
            .opacity(checkStates() ? 0.5 : 1)
            .padding(.vertical)
            HStack(spacing: 12){
                Text("vous avez pas reçu le code ?")
                    .font(.caption)
                    .foregroundColor(.gray)
                Button("Renvoyer"){
                    
                }
                .font(.callout)
            }

        }
        .padding()
        .frame(maxHeight:.infinity, alignment: .top)
        .navigationTitle("Verification")
        .onChange(of: otpViewModel.otpFields){newValue in
            OTPCondition(value: newValue)
        }
        .alert(otpViewModel.errorMsg, isPresented: $otpViewModel.showAlert){
            
        }
        
    }
    
    
    func checkStates() -> Bool {
        for index in 0..<6{
            if otpViewModel.otpFields[index].isEmpty{
                return true
            }
        }
        return false
    }
    
    func OTPCondition(value: [String]){
        
        
        ///Conditions for custom OTP Field & Limiting Only One Text
        for index in 0..<6{
            if value[index].count == 6{
                DispatchQueue.main.async {
                    otpViewModel.otpText = value[index]
                    otpViewModel.otpFields[index] = ""
                    
                    ///Updating All textfield with value
                    for item in otpViewModel.otpText.enumerated(){
                        otpViewModel.otpFields[item.offset] = String(item.element)
                    }
                }
                return
            }
        }
        /// moving Next field if current Field Type
        for index in 0..<5{
            if value[index].count == 1 && activeStateForIndex(index: index) == activeField {
                activeField = activeStateForIndex(index: index + 1)
            }
        }
        ///moving back if current is empty and previous is not Empty
        for index in 1...5{
            if value[index].isEmpty && !value[index - 1].isEmpty{
                activeField = activeStateForIndex(index: index - 1)
            }
        }
        for index in 0..<6{
            if value[index].count > 1 {
                otpViewModel.otpFields[index] = String(value[index].last!)
            }
        }
    }
    @ViewBuilder
    func OtpField() -> some View {
        HStack(spacing: 15){
            ForEach(0..<6 , id:\.self){index in
                VStack(spacing: 8){
                    TextField("", text: $otpViewModel.otpFields[index])
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($activeField, equals: activeStateForIndex(index: index))
                    
                    Rectangle()
                        .fill(activeField == activeStateForIndex(index: index) ? .blue : .gray.opacity(0.3))
                        .frame(height: 4)
                }
                .frame(width: 40)
            }
        }
    }
    
    func activeStateForIndex(index: Int) -> otpField {
        switch index{
        case 0 : return .field1
        case 1 : return .field2
        case 2 : return .field3
        case 3 : return .field4
        case 4 : return .field5
        default:
            return .field6
        }
    }
}

struct Verification_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// FocusState Enum
enum otpField{
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
}

