//
//  TransactionViewModel.swift
//  TrackerExpensive
//
//  Created by Abdoulaye Aliou SALL on 18/04/2023.
//

import Foundation
import SwiftUI

class TransactionViewModel: ObservableObject {
   // Propreties
    @Published var transactions: [Transaction] = donneesStaticTransactionsUn
    
   

    @Published var dateDedepart : Date = Date()
    @Published var dateDefin : Date = Date()
    @Published var currentMonthStartDate : Date = Date()
    /// Filter View
    @Published var showFilterView: Bool = false
    
    ///Expense / Income Tab
    @Published var tabName: TypeDeTransaction = .sortants
    
    //New Expense Propreties
    @Published var addNewExpense : Bool = false
    @Published var amount : String = ""
    @Published var type : TypeDeTransaction = .touts
    @Published var date : Date = Date()
    @Published var destinataire : String = ""
    
    init(){
        //fetching Current Month Starting Date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())
        
        dateDedepart = calendar.date(from: components) ?? Date()
        currentMonthStartDate = calendar.date(from: components) ?? Date()
    }
    
    //This is a sample Data of Month May
    ///you can Customize this even more with yout data CoreData
    func currentMonthDateString()-> String {
        return currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }
    
    func currentMonthDatesString()-> String {
        return currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }
    
    
    func convertTransactionToCurrency(transaction : [Transaction], types: TypeDeTransaction = .touts) -> String {
        print("\(transaction[1].destinataire)")
        var value : Double = 0
        value = transaction.reduce(0, { partialResult, transaction in
            return partialResult + (type == .touts ? (transaction.types == .entrants ? transaction.montant : -transaction.montant) : (transaction.types == type ? transaction.montant : 0))
        })
       return convertNumberToPrice(value: value)
    }
    
    
    //cinvert Number to price
    func convertNumberToPrice(value : Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: .init(value: value)) ?? "$Ø.00"
    }
    
    // convert Date to string
    func convertDateToString() -> String {
        return dateDedepart.formatted(date: .abbreviated, time: .omitted) + " - " + dateDefin.formatted(date: .abbreviated, time: .omitted)
    }
    
    //Clear Data
    
    func clearData(){
        date = Date()
        type = .touts
        destinataire = ""
        amount = ""
    }
    
    //save Data
    func saveData(env : EnvironmentValues){
        print("save")
        let amoutInDouble = (amount as NSString).doubleValue
        let colors = ["Yellow","Red","Purple","Green"]
        var transaction  = Transaction(destinataire: destinataire, date: date, types: type, amount: amoutInDouble)
        withAnimation{transactions.append(transaction)}
        transactions = transactions.sorted(by: {first, scnd in
            return scnd.date < first.date
        })
        env.dismiss()
    }
    
    
    
}

