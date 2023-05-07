//
//  DetailsBudgetWithTransaction.swift
//  TrackerExpensive
//
//  Created by Abdoulaye Aliou SALL on 18/04/2023.
//

import SwiftUI

struct DetailsBudgetWithTransaction: View {
    var sousCompte : SousCompte
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var expenseViewModel :ExpenseViewModel
    @StateObject var expensesViewModel : ExpenseViewModel = .init()
    var isFilter : Bool = false
    @Environment(\.self) var env
    @Namespace var animation
    @State var formTransaction: Bool = false
        var body: some View {
            
            ScrollView(.vertical , showsIndicators: false) {
                VStack(spacing: 12) {
                    HStack(spacing: 15){
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            VStack(alignment: .leading,spacing: 5) {
                                
                                Text("welcome")
                                    .foregroundColor(Color("Gray"))
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                HStack {
                                    Image(systemName: "chevron.backward")
                                    Text(sousCompte.remark)
                                        .font(.title2.bold())
                                }
                                .foregroundColor(.black)
                                    
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }

                    }
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
                                Text(sousCompte.remark)
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                
                                Text(expenseViewModel.convertTransactionToCurrency(transaction: sousCompte.transactions,types: .touts))
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
                                    Text("Revenue")
                                        .font(.caption)
                                        .opacity(0.7)
                                    
                                    Text(expenseViewModel.convertTransactionToCurrency(transaction: sousCompte.transactions,types: .entrants))
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
                                    Text("Depense")
                                        .font(.caption)
                                        .opacity(0.7)
                                    Text(expenseViewModel.convertTransactionToCurrency(transaction: sousCompte.transactions, types: .sortants))
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
                    HStack{
                        Text("Transactions")
                            .font(.title2.bold())
                            .opacity(0.7)
                        .frame(maxWidth: .infinity,alignment: .leading)
          
                            Menu{
                                Button("filtre1"){
                                    
                                }
                                Button("filtre1"){
                                    
                                }
                            } label: {
                                Image(systemName: "ellipsis")
                                    
                                    .foregroundColor(.black)
                            }

                    }
                    
                    customSegmentCountrol()
                        .padding(.top)
                    
                    ForEach(sousCompte.transactions.filter{
                        return $0.types == expenseViewModel.tabName
                    }){expense in
                        ReelTransactionView(depenses: expense)
                            .environmentObject(expenseViewModel)
                    }
                    
                }
                
                .padding()
                
            }
            .overlay(alignment: .bottomTrailing){
                VStack{
                    if formTransaction{
                            echangeFormTransaction()
                            addFormTransaction()
                            deleteButton()
                    }
                    FabButton(showfabButton: $formTransaction)
                }
                .animation(.spring())
            }
            .background(Color("BabaGl"))
        }
    
    @ViewBuilder
    func customSegmentCountrol() -> some View {
        HStack (spacing: 0){
            ForEach([TypeDeTransaction.entrants , TypeDeTransaction.sortants], id: \.rawValue){tab in
                Text(tab.rawValue.capitalized)
                    .fontWeight(.semibold)
                    .foregroundColor(expenseViewModel.tabName == tab ? .white : .black)
                    .opacity(expenseViewModel.tabName == tab ? 1 : 0.7)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 10 , style: .continuous)
                            .fill(
                        LinearGradient(colors: expenseViewModel.tabName == tab ? [
                            Color("Gradient1"),
                            Color("Gradient2"),
                            Color("Gradient3"),] : [Color(.white)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation{expenseViewModel.tabName = tab}
                            
                    }
            
            }
            
            
        }
        .padding(5)
        .background{
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
        }
    }
    // Butoon Add Budget
    func addFormTransaction() -> some View{
        Button{
            expenseViewModel.addNewExpense.toggle()
        } label:{
            Image(systemName: "plus")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background{
                    Circle()
                        .fill(
                            .linearGradient(colors: [
                            Color("Gradient1"),
                            Color("Gradient2"),
                            Color("Gradient3")
                            
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .shadow(color: .black.opacity(0.5), radius: 5, x: 5, y: 5)
        }
    }
    // Button exchange data
    func echangeFormTransaction() -> some View{
        Button{
            expenseViewModel.addNewExpense.toggle()
        } label:{
            Image(systemName: "square.and.arrow.up.on.square")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background{
                    Circle()
                        .fill(
                            .linearGradient(colors: [
                            Color("Gradient1"),
                            Color("Gradient2"),
                            Color("Gradient3")
                            
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .shadow(color: .black.opacity(0.5), radius: 5, x: 5, y: 5)
        }
    }
    
    func deleteButton() -> some View{
        Button{
            expenseViewModel.addNewExpense.toggle()
        } label:{
            Image(systemName: "minus")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background{
                    Circle()
                        .fill(
                            .linearGradient(colors: [
                            Color("Gradient1"),
                            Color("Gradient2"),
                            Color("Gradient3")
                            
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .shadow(color: .black.opacity(0.5), radius: 5, x: 5, y: 5)
        }
    }
    
    
    struct FabButton : View{
        @Binding var showfabButton: Bool
        var body: some View{
            Button{
                showfabButton.toggle()
            } label:{
                Image(systemName: "chevron.up")
                    .font(.system(size: 25, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 55, height: 55)
                    .background{
                        Circle()
                            .fill(
                                .linearGradient(colors: [
                                Color("Gradient1"),
                                Color("Gradient2"),
                                Color("Gradient3")
                                
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    }
                    .rotationEffect(.init(degrees: showfabButton ? 180 : 0))
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 5, y: 5)
            }
            .padding()
        }
    }
}

//struct DetailsBudgetWithTransaction_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsBudgetWithTransaction(sousCompte: SousCompte(remark: "Facture", amount: 350000, date: Date(), type: .touts, color: "", transactions: donneesStaticTransactionDeux))
//    }
//}
