//
//  NewExpenseView.swift
//  TrackerExpensive
//
//  Created by Abdoulaye Aliou SALL on 06/04/2023.
//

import SwiftUI

struct NewExpenseView: View {
    
    @EnvironmentObject var expenseViewModel :ExpenseViewModel
    //Environement value
    @Environment(\.self) var env
    var body: some View {
        VStack {
            VStack(spacing: 15) {
                Text("Add Expenses")
                    .font(.title)
                    .fontWeight(.semibold)
                    .opacity(0.5)
                //Custom texfield
                //for currency Symbol
                if let symbol = expenseViewModel.convertNumberToPrice(value: 0)
                    .first{
                    TextField("0", text: $expenseViewModel.amount)
                        .font(.system(size: 32))
                        .foregroundColor(Color("Gradient2"))
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background{
                            Text(expenseViewModel.amount == "" ? "0" : expenseViewModel.amount)
                                .font(.system(size: 32))
                                .opacity(0)
                                .overlay(alignment : .leading){
                                    Text(String(symbol))
                                        .opacity(0.5)
                                        .offset(x: -15, y: 5)
                                }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background{
                            Capsule()
                                .fill(.white)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                }
                //CUSTOM LABELS
                Label {
                    TextField("Remark",text: $expenseViewModel.remark)
                        .padding(.leading , 10)
                }icon: {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                .padding(.vertical,20)
                .padding(.horizontal, 15)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill( .white)
                }
                .padding(.top, 20)
                
                Label {
                    CustomCheckBox()
                }icon: {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                .padding(.vertical,20)
                .padding(.horizontal, 15)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill( .white)
                }
                .padding(.top, 20)
                
                Label {
                    DatePicker.init("", selection: $expenseViewModel.date,in:
                                        Date()...Date.distantFuture, displayedComponents:[.date])
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .frame(maxWidth: .infinity ,alignment: .leading)
                        .padding(.leading,10)
                }icon: {
                    Image(systemName: "calendar")
                        .font(.title3)
                        .foregroundColor(Color("Gray"))
                }
                .padding(.vertical,20)
                .padding(.horizontal, 15)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill( .white)
                }
                .padding(.top, 5)
            }
            .frame(maxHeight:.infinity, alignment: .center)
            Button{
                expenseViewModel.saveData(env: env)
//                expenseViewModel.persistenceData()
            }label: {
                Text("SAVE")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(
                            LinearGradient(colors: [
                            Color("Gradient1"),
                            Color("Gradient2"),
                            Color("Gradient3")
                            ], startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
            }
            .disabled(expenseViewModel.remark == "" || expenseViewModel.type == .touts || expenseViewModel.amount == "")
            .opacity(expenseViewModel.remark == "" || expenseViewModel.type == .touts || expenseViewModel.amount == "" ? 0.6 : 1)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Color("BabaGl")
                .ignoresSafeArea()
        }
        .overlay(alignment: .topTrailing){
            //Close Botton
            Button{
                env.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.black)
                    .opacity(0.7)
            }
            .padding()
            .frame(width: 50,height: 50)
        }
    }
    
    //Custom checkoxes
    @ViewBuilder
    func CustomCheckBox() -> some View {
        HStack(spacing: 10){
            ForEach([TypeDeTransaction.entrants, .sortants],id:\.self){type in
                ZStack{
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(.black,lineWidth: 2)
                        .opacity(0.5)
                        .frame(width: 20,height: 20)
                    if expenseViewModel.type == type {
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundColor(Color("Green"))
                            .padding(.trailing, 1)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    expenseViewModel.type =  type
                }
                
                Text(type.rawValue.capitalized)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .opacity(0.7)
            }
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.leading, 10)
    }
    
    
    
}

struct NewExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        NewExpenseView()
            .environmentObject(ExpenseViewModel())
    }
}
