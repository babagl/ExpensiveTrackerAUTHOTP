//
//  HomeTrackerView.swift
//  TrackerExpensive
//
//  Created by Abdoulaye Aliou SALL on 05/04/2023.
//

import SwiftUI

struct HomeTrackerView: View {
    @StateObject var expenseViewModel : ExpenseViewModel = .init()
    @State var showFabButton = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 12){
                HStack(spacing: 15){
                    VStack(alignment: .leading,spacing: 4){
                        Text("Welcome")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Gray"))
                        
                        Text("BabaGalle")
                            .font(.title2.bold())
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    NavigationLink{
                        FilteredDetailView()
                            .environmentObject(expenseViewModel)
                    }label: {
                        Image(systemName: "hexagon.fill")
                            .foregroundColor(.gray)
                            .overlay(content: {
                                Circle()
                                    .stroke(.white, lineWidth: 2)
                                    .padding(7)
                            })
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10 , style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                }
          
                Text("Card")
                    .font(.title2.bold())
                    .opacity(0.7)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                ExpenseCard()
                    .environmentObject(expenseViewModel)
                
                HStack {
                    Text("Budgets")
                        .font(.title2.bold())
                        .opacity(0.7)
                    .frame(maxWidth: .infinity,alignment: .leading)
      
                }
                    
                
                    ScrollView(.horizontal, showsIndicators: false){
                            HStack {
                                ForEach(expenseViewModel.sousComptes){expense in
                                    NavigationLink(destination: {
                                        DetailsBudgetWithTransaction(sousCompte: expense)
                                            .environmentObject(expenseViewModel)
                                            .navigationBarBackButtonHidden()
                                    }, label: {
                                        GridBudgetView(sousCompte: expense)
                                            .environmentObject(expenseViewModel)
                                    })
                                }
                                VStack {
                                    ajouterUnBudget()
                                    Spacer()
                                }
                            }
                            .padding(.top, 12)
                        
                    }
                
                
                TransactionView()
            }
            .padding()
        }
        .background(Color("BabaGl"))
        .fullScreenCover(isPresented: $expenseViewModel.addNewExpense){
            
        } content: {
            NewExpenseView()
                .environmentObject(expenseViewModel)
        }
        .fullScreenCover(isPresented: $expenseViewModel.showNewTransaction){
            
        }content: {
            FormExpensesView()
                .environmentObject(expenseViewModel)
        }
        .overlay(alignment: .bottomTrailing){
            VStack{
                
                if showFabButton{
                        ajouterUnBudget()
                        faireUneTransaction()
                        rechargerUnBudgetExistant()
                }
                FabButton(showfabButton: $showFabButton)
            }
            .animation(.spring())
        }
    }
    
    // Transaction View
    @ViewBuilder
    func TransactionView() -> some View {
        VStack(spacing: 15 ){
            Text("Transactions")
                .font(.title2.bold())
                .opacity(0.7)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.bottom)
            
            ForEach(expenseViewModel.transactionPrincipal){depense in
                //transaction Card View
                Text("hello world")
                ReelTransactionView(depenses: depense)
                    .environmentObject(expenseViewModel)
            }
        }
        .padding(.top)
    }
    
    // Butoon Add Budget
    func ajouterUnBudget() -> some View{
        Button{
            expenseViewModel.addNewExpense.toggle()
            expenseViewModel.clearData()
        } label:{
            Image(systemName: "rectangle.stack.badge.plus")
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
    func faireUneTransaction() -> some View{
        Button{
            expenseViewModel.showNewTransaction.toggle()
            expenseViewModel.clearData()
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
    
    func rechargerUnBudgetExistant() -> some View{
        Button{
            expenseViewModel.addNewExpense.toggle()
            expenseViewModel.clearData()
        } label:{
            Image(systemName: "arrowshape.turn.up.right")
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
    
    //rectangle.stack.badge.plus
    
    
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

struct HomeTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
