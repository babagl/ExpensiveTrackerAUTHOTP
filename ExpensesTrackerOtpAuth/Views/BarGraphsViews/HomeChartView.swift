//
//  HomeChartView.swift
//  ChartViewSwiftUi
//
//  Created by Abdoulaye Aliou SALL on 15/05/2023.
//

import SwiftUI

struct HomeChartView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 18){
                HStack{
                    VStack(alignment: .leading, spacing: 8){
                        Text("Weekly Icons")
                            .font(.title.bold())
                        Text("reports is avalaible")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                    Spacer(minLength: 10)
                    Button {
                        
                    } label: {
                        Image(systemName: "bell")
                            .font(.title2)
                            .foregroundColor(.gray)
//                            .overlay(
//                                Text("2")
//                                    .font(.caption2.bold())
//                                    .foregroundColor(.white)
//                                    .padding(8)
//                                    .background(.red)
//                                    .clipShape(Circle())
//                                    .offset(x: 11 , y: -12),
//                                alignment: .topTrailing
//                            )
                            .offset(x: -2)
                            .padding(15)
                    }

                }
                
                //graph view
                BarGraphView(downloads: dowloads)
            }
            .padding()
        }
    }
}

struct HomeChartView_Previews: PreviewProvider {
    static var previews: some View {
        HomeChartView()
    }
}
