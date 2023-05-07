//
//  ListExpenseView.swift
//  TrackerExpensive
//
//  Created by Abdoulaye Aliou SALL on 11/04/2023.
//

import SwiftUI

struct ListExpenseView: View {
    @EnvironmentObject var expenseViewModel : ExpenseViewModel
    var contenue : [Transaction]
    var body: some View {
       
        ScrollView(.vertical , showsIndicators: false){
            ExpenseCard(isFilter: true)
                .environmentObject(expenseViewModel)
                .padding()
            ///Expense Card View For Currency
            
        }
    }
}

//struct ListExpenseView_Previews: PreviewProvider {
//    var expenses : SousCompte = SousCompte(remark: "", amount: 0, date: Date(), type: .sortants, color: "", transactions: [])
//    static var previews: some View {
//        Group {
//            ListExpenseView(contenue:expenses)
//                .environmentObject(ExpenseViewModel())
//                
//        }
//    }
//}
