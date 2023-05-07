//
//  FormExpensesView.swift
//  TrackerExpensive
//
//  Created by Abdoulaye Aliou SALL on 23/04/2023.
//

import SwiftUI

struct FormExpensesView: View {
    @StateObject var expensesViewModel : ExpenseViewModel = .init()
    @Environment(\.self) var env
    var body: some View {
        VStack{
            VStack(spacing: 15){
                Text("Transactions")
                    .font(.title)
                    .fontWeight(.bold)
                    .opacity(0.5)
                
                    TextField("0", text: $expensesViewModel.montant)
                        .font(.system(size: 32))
                        .foregroundColor(Color("Gradient2"))
                        .multilineTextAlignment(.center)
                        .background{
                            Text(expensesViewModel.amount == "" ? "0" : expensesViewModel.amount)
                                .font(.system(size: 32))
                                .opacity(0)
                                .overlay(alignment: .leading){
                                    Text(String())
                                        .opacity(0.5)
                                        .offset(x: -15, y: 5)
                                }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background{Capsule()
                                .fill(.white)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                
                Label {
                    TextField("Destinataire",text: $expensesViewModel.destinataire)
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
                    
            }
            .frame(maxHeight:.infinity, alignment: .center)
            Button{
//                expenseViewModel.persistenceData()
                expensesViewModel.saveTransaction(env: env)
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
            .disabled(expensesViewModel.montant == "" || expensesViewModel.destinataire == "" || expensesViewModel.transactionType == .touts)
            .opacity(expensesViewModel.montant == "" || expensesViewModel.destinataire == "" || expensesViewModel.transactionType == .touts ? 0.5 : 1)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Color("BabaGl")
                .ignoresSafeArea()
        }
        .overlay(alignment: .topTrailing){
            Button {
                env.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.black)
                    .opacity(0.7)
            }
            .padding()
            .frame(width: 50 , height: 50)

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
                    if expensesViewModel.transactionType == type {
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundColor(Color("Green"))
                            .padding(.trailing, 1)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    expensesViewModel.transactionType =  type
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

struct FormExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        FormExpensesView()
    }
}


