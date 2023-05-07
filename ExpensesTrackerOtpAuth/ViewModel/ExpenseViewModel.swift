//
//  ExpenseViewModel.swift
//  TrackerExpensive
//
//  Created by Abdoulaye Aliou SALL on 05/04/2023.
//

import SwiftUI

class ExpenseViewModel: ObservableObject {
    // Propreties
     @Published var sousComptes: [SousCompte] = donneesStatic_souscompte
     @Published  var transactionPrincipal : [Transaction] = donneeP
    
     @Published var dateDedepart : Date = Date()
     @Published var dateDefin : Date = Date()
     @Published var currentMonthStartDate : Date = Date()
     /// Filter View
     @Published var showFilterView: Bool = false
     
     ///Expense / Income Tab
     @Published var tabName: TypeDeTransaction = .sortants
     
     //New Expense Propreties
     //New Page
     @Published var addNewExpense : Bool = false
     @Published var showNewTransaction = false
     
    //Donnees Des Budget
     @Published var amount : String = ""
     @Published var type : TypeDeTransaction = .touts
     @Published var date : Date = Date()
     @Published var remark : String = ""
    
    // Donnees de transaction
    
    @Published var montant : String = ""
    @Published var destinataire : String = ""
    @Published var transactionType : TypeDeTransaction = .touts
    
//    func printTransaction(){
//        print("mes transactions sont : ", transactionPrincipale.first ?? "rien")
//    }
//
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
     
     func convertExpensesToCurrency(depenses : [SousCompte], type: TypeDeTransaction = .touts) -> String {
         print("\(depenses[1].transactions[0].destinataire)")
         var value : Double = 0
         value = depenses.reduce(0, { partialResult, expence in
             return partialResult + (type == .touts ? (expence.type == .entrants ? expence.amount : -expence.amount) : (expence.type == type ? expence.amount : 0))
         })
        return convertNumberToPrice(value: value)
     }
     
     func convertTransactionToCurrency(transaction : [Transaction], types: TypeDeTransaction = .touts) -> String {
         //print("\(transaction[1].destinataire)")
         var values : Double = 0
         values = transaction.reduce(0, { partialResult, transaction in
             return partialResult + (types == .touts ? (transaction.types == .entrants ? transaction.montant : -transaction.montant) : (transaction.types == types ? transaction.montant : 0))
         })
        return convertNumberToPrice(value: values)
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
         remark = ""
         amount = ""
     }
    
    func clearDataDepense(){
         montant = ""
         type = .touts
         destinataire = ""
     }
     
     //save Data
     func saveData(env : EnvironmentValues){
         print("save")
         let amoutInDouble = (amount as NSString).doubleValue
         let colors = ["Yellow","Red","Purple","Green"]
         let expense = SousCompte( remark: remark, amount: amoutInDouble, date: date, type: type, color: colors.randomElement() ?? "Yellow", transactions: [Transaction(destinataire: "name", date: Date(), types: type, amount: amoutInDouble)])
         withAnimation{sousComptes.append(expense)}
         sousComptes = sousComptes.sorted(by: {first, scnd in
             return scnd.date > first.date
         })
         print(expense.transactions.count)
         env.dismiss()
     }
    
    func saveTransaction(env: EnvironmentValues){
        
        print("save transaction")
        let montantDelaTransaction = (montant as NSString).doubleValue
        let transaction = Transaction(destinataire: destinataire, date: Date(), types: transactionType, amount: montantDelaTransaction)
        withAnimation{
            transactionPrincipal.append(transaction)
        }
        print("\(transaction.id) et \(transaction.destinataire)  sauvegarder avec success \n Merci")
        env.dismiss()
    }
     
     
     
}
