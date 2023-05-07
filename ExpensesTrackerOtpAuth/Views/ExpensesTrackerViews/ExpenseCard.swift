//
//  ExpenseCard.swift
//  TrackerExpensive
//
//  Created by Abdoulaye Aliou SALL on 06/04/2023.
//

import SwiftUI

struct ExpenseCard: View {
    @EnvironmentObject var expenseViewModel : ExpenseViewModel
    var isFilter : Bool = false
    var body: some View {
        GeometryReader{proxy in
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    .linearGradient(colors:[
                    Color("Gradient1"),
                    Color("Gradient2"),
                    Color("Gradient3"),
                    ], startPoint: .topLeading, endPoint: .bottomTrailing))
            VStack(spacing: 15){
                VStack(spacing: 15){
                    // currently Going Month Date String
                    Text(isFilter ? expenseViewModel.convertDateToString() : expenseViewModel.currentMonthDateString())
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    Text(expenseViewModel.convertExpensesToCurrency(depenses: expenseViewModel.sousComptes))
                        .font(.system(size: 32, weight: .bold))
                        .lineLimit(1)
                        .padding(.bottom, 5)
                }
                .offset(y: -10)
                HStack(spacing: 15){
                    Image(systemName: "arrow.down")
                        .font(.caption.bold())
                        .foregroundColor(Color("Green"))
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.7),in: Circle())
                    
                    VStack(alignment: .leading, spacing: 4){
                        Text("Income")
                            .font(.caption)
                            .opacity(0.7)
                        
                        Text(expenseViewModel.convertExpensesToCurrency(depenses: expenseViewModel.sousComptes , type: .entrants))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                    .frame(maxWidth: .infinity , alignment: .leading)
                    
                    Image(systemName: "arrow.up")
                        .font(.caption.bold())
                        .foregroundColor(Color("Red"))
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.7),in: Circle())
                    
                    VStack(alignment: .leading, spacing: 4){
                        Text("Expenses")
                            .font(.caption)
                            .opacity(0.7)
                        Text(expenseViewModel.convertExpensesToCurrency(depenses: expenseViewModel.sousComptes , type: .sortants))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                }
                .padding(.horizontal)
                .padding(.trailing)
                .offset(y: 15)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 220)
        .padding(.top)
    }
}


 
