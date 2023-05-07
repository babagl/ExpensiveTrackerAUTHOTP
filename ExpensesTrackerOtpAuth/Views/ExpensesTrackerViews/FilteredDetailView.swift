//
//  FilteredDetailView.swift
//  TrackerExpensive
//
//  Created by Abdoulaye Aliou SALL on 06/04/2023.
//

import SwiftUI

struct FilteredDetailView: View {
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    @Environment(\.self) var env
    
    @Namespace var animation
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack {
                HStack(spacing: 15){
                    //Button Back
                    Button(action:{
                        env.dismiss()
                    } , label: {
                        Image(systemName: "arrow.backward.circle.fill")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10 , style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    })
                    Text("Transaction")
                        .font(.title.bold())
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Button{
                        expenseViewModel.showFilterView = true
                    }label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10 , style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }          
                }
                ExpenseCard(isFilter: true)
                    .environmentObject(expenseViewModel)
                ///Expense Card View For Currency
                customSegmentCountrol()
                    .padding(.top)
                
                //Currently filtered Date with Amount
                VStack(spacing: 15){
                    Text(expenseViewModel.convertDateToString())
                        .opacity(0.7)
                    Text(expenseViewModel.convertExpensesToCurrency(depenses: expenseViewModel.sousComptes, type: expenseViewModel.tabName))
                        .font(.title.bold())
                        .opacity(0.9)
                        .animation(.none, value: expenseViewModel.tabName)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background{
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                }
                .padding(.vertical,20)
                
                ForEach(expenseViewModel.sousComptes.filter{
                    return $0.type == expenseViewModel.tabName
                }){expense in
                    TransactionCarView(expense: expense)
                        .environmentObject(expenseViewModel)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .background{
            Color("BabaGl")
                .ignoresSafeArea()
        }
        .overlay{
            FilterView()
        }
    }

    //Filter View
    @ViewBuilder
    func FilterView() -> some View {
        ZStack{
            Color.black
                .opacity(expenseViewModel.showFilterView ? 0.25 : 0)
                .ignoresSafeArea()
            
            //Based on the date Filter
            if expenseViewModel.showFilterView{
                VStack(alignment: .leading, spacing: 10){
                    Text("Start Date")
                        .font(.caption)
                        .opacity(0.5)
                    DatePicker("", selection: $expenseViewModel.dateDedepart,in: Date.distantPast...Date(), displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                    
                    Text("End Date")
                        .font(.caption)
                        .opacity(0.5)
                        .padding(.top,10)
                    DatePicker("", selection: $expenseViewModel.dateDefin,in: Date.distantPast...Date(), displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                }
                .padding(20)
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
                //Close Boutton
                .overlay(alignment: .topTrailing){
                    Button{
                        expenseViewModel.showFilterView = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(5)
                    }
                }
                .padding()
            }
        }
        .animation(.easeInOut, value: expenseViewModel.showFilterView)
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
                        //with matched Geometry Effect
                        if expenseViewModel.tabName == tab{
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(
                                LinearGradient(colors:[
                                    Color("Gradient1"),
                                    Color("Gradient2"),
                                    Color("Gradient3"),
                                                        
                                ],startPoint: .topLeading,
                                               endPoint: .bottomTrailing)
                                )
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
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
}

struct FilteredDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredDetailView()
            .environmentObject(ExpenseViewModel())
    }
}
