//
//  TransactionCarView.swift
//  TrackerExpensive
//
//  Created by Abdoulaye Aliou SALL on 05/04/2023.
//

import SwiftUI

struct TransactionCarView: View {
    var expense :SousCompte
    @EnvironmentObject var expenseViewModel : ExpenseViewModel
    
    var body: some View {
        
        HStack (spacing: 12){
            
            if let first = expense.remark.first{
                
                Text(String(first))
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(width: 50,height: 50)
                    .background{Circle()
                        .fill(Color(expense.color))
                        
                    }
                    .shadow(color: .black.opacity(0.08), radius: 5, x: 5,y: 5)
                
                Text(expense.remark)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                VStack(alignment: .trailing, spacing: 7){
                    //displaying price
                    let price = expenseViewModel.convertNumberToPrice(value: expense.type == .sortants ? -expense.amount : expense.amount)
                    Text(price)
                        .font(.callout)
                        .opacity(0.7)
                        .foregroundColor(expense.type == .sortants ? Color("Red"):Color("Green"))
                    Text(expense.date.formatted(date: .numeric, time: .omitted))
                        .font(.caption)
                        .opacity(0.5)
                        .foregroundColor(.black)
                        
                }
            }
        }
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
        }
        }
}

struct TransactionCarView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
