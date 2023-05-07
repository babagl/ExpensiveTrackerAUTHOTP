//
//  ReelTransactionView.swift
//  TrackerExpensive
//
//  Created by Abdoulaye Aliou SALL on 24/04/2023.
//

import SwiftUI

struct ReelTransactionView: View {
    var depenses : Transaction
    @StateObject var expenseViewModel : ExpenseViewModel = .init()
    
    var body: some View {
        
        HStack (spacing: 12){
                VStack{
                    Text(depenses.destinataire)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity ,alignment: .leading)
                        .shadow(color: .black.opacity(0.08), radius: 5, x: 5,y: 5)
                    
                    Text(String(depenses.montant))
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity ,alignment: .leading)
                }
                VStack(alignment: .trailing, spacing: 7){
                    //displaying price
                    let price = expenseViewModel.convertNumberToPrice(value: depenses.types == .sortants ? -depenses.montant : depenses.montant)
                    Text(price)
                        .font(.callout)
                        .opacity(0.7)
                        .foregroundColor(depenses.types == .sortants ? Color("Red"):Color("Green"))
                    Text(depenses.date.formatted(date: .numeric, time: .omitted))
                        .font(.caption)
                        .opacity(0.5)
                        .foregroundColor(.black)
                        
                }
            
        }
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
        }
        }
}

struct ReelTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        ReelTransactionView(depenses: Transaction(destinataire: "Baba", date: Date(), types: .entrants, amount: 0.0))
    }
}
