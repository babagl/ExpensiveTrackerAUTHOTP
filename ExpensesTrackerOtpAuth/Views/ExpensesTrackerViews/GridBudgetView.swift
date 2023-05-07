//
//  GridBudgetView.swift
//  TrackerExpensive
//
//  Created by Abdoulaye Aliou SALL on 13/04/2023.
//

import SwiftUI

struct GridBudgetView: View {
    var sousCompte : SousCompte
    @EnvironmentObject var expenseViewModel : ExpenseViewModel
    
    @StateObject var expensesViewModel : ExpenseViewModel = .init()
    var body: some View {
            VStack{
                HStack{
                    VStack {
                        HStack {
                            Text(sousCompte.remark)
                                .foregroundColor(.white)
                                .font(.caption)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(. horizontal, 5)
                        .padding(.bottom, 20)
                        
                        let price = expenseViewModel.convertNumberToPrice(value: sousCompte.type == .sortants ? -sousCompte.amount : sousCompte.amount)
                        Text(price)
                            .font(.callout)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        
                        HStack {
                            Spacer()
                        }
                        .padding(.top, 1)
                        
                    }
                    
                    
                }
                .padding()
                
                
            }
            .frame(width: 120, height: 120)
            .background(.linearGradient(colors: [
                Color("Gradient1"),
                Color("Gradient2"),
                Color("Gradient3"),
            ], startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
        
    }
}

struct GridBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
