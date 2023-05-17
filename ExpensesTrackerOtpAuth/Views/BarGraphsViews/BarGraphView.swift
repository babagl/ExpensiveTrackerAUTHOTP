//
//  BarGraphView.swift
//  ChartViewSwiftUi
//
//  Created by Abdoulaye Aliou SALL on 15/05/2023.
//

import SwiftUI

struct BarGraphView: View {
    var downloads : [Downlaod]
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Depense Hebdo")
                    .fontWeight(.bold)
                Spacer()
                
                Menu{
                    Button("Month"){}
                    Button("Year"){ }
                    Button("Day"){ }
                }label: {
                    HStack(spacing: 4){
                        Text("Cette semaine")
                        Image(systemName: "arrowtriangle.down.fill")
                            .scaleEffect(0.7)
                    }
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
                }
            }
            HStack(spacing: 10){
                Capsule()
                    .fill(Color("Gradient1"))
                    .frame(width: 20, height: 8)
                Text("text1")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity ,alignment: .leading)
            //Graph View
            GraphView()
                .padding(.top, 20)
            
        }
        .padding(20)
        .background(.white.opacity(0.1))
        .cornerRadius(20)
        .padding(.top, 25)
    }
    @ViewBuilder
    func GraphView() -> some View {
        
        GeometryReader{proxy in
            ZStack{
                VStack(spacing: 0){
                    ForEach(getGraphLines(), id: \.self){line in
                        HStack(spacing: 8){
                            Text("\(Int(line))")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(height: 20)
                            Rectangle()
                                .fill(.gray.opacity(0.3))
                                .frame(height: 1)
                            
                        }
                        .frame(maxHeight: .infinity,alignment: .bottom)
                        .offset(y: -15)
                        
                    }
                }
                HStack{
                    ForEach(downloads){downloads in
                        VStack(spacing: 0){
                            VStack(spacing: 5){
                                Capsule()
                                    .fill(Color("Gradient1"))
                                Capsule()
                                    .fill(Color("Gradient2"))
                            }
                            .frame(width: 8)
                            .frame(height: getBarHeight(point: downloads.download, size: proxy.size))
                            
                            
                            Text(downloads.weekDay)
                                .font(.caption)
                                .frame(height: 25, alignment: .bottom)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .padding(.leading, 30)
                
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .center)
            
        }
        .frame(height: 190)
    }
    func getBarHeight(point : CGFloat, size : CGSize) -> CGFloat {
        let max = getMax()
        
        let height = (point / max) * (size.height - 30)
        return height
    }
    
    //Getting Simple Graph Lines base on max Value
    func getGraphLines() -> [CGFloat]  {
        let max = getMax()
        var lines: [CGFloat] = []
        lines.append(max)
        for index in 1...4{
            let progress = max / 4
            lines.append(max - (progress * CGFloat(index)))
        }
        return lines
    }
    //Getting Max
    
    func getMax() -> CGFloat {
        let max = downloads.max{first , scnd  in
            return scnd.download > first.download
        }?.download ?? 0
        
        return max
    }
}

struct BarGraphView_Previews: PreviewProvider {
    static var previews: some View {
        HomeChartView()
    }
}
