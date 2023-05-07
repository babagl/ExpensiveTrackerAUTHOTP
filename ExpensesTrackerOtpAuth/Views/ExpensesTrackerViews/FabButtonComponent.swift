//
//  FabButtonComponent.swift
//  TrackerExpensive
//
//  Created by Abdoulaye Aliou SALL on 22/04/2023.
//

import SwiftUI

struct FabButtonComponent: View {
    @State var show = false
    var body: some View {
        expendableFab(show: $show)
    }
}

struct FabButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        FabButtonComponent()
    }
}
struct expendableFab : View{
    @Binding var show : Bool
    var body: some View{
        VStack{
            
            if self.show{
                Button {
                    self.show.toggle()
                } label: {
                    Image(systemName: "chevron.up")
                        .resizable()
                        .frame(width: 40,height: 30)
                        .padding(22)
                        
                }
                .background(LinearGradient(colors: [
                Color("Gradient1"),
                Color("Gradient2"),
                Color("Gradient3"),
                ], startPoint: .topLeading, endPoint: .bottomTrailing))
                .foregroundColor(.white)
                .clipShape(Circle())
                
                Button {
                    self.show.toggle()
                } label: {
                    Image(systemName: "chevron.up")
                        .resizable()
                        .frame(width: 40,height: 30)
                        .padding(22)
                        
                }
                .background(LinearGradient(colors: [
                Color("Gradient1"),
                Color("Gradient2"),
                Color("Gradient3"),
                ], startPoint: .topLeading, endPoint: .bottomTrailing))
                .foregroundColor(.white)
                .clipShape(Circle())
                
                Button {
                    self.show.toggle()
                } label: {
                    Image(systemName: "chevron.up")
                        .resizable()
                        .frame(width: 40,height: 30)
                        .padding(22)
                        
                }
                .background(LinearGradient(colors: [
                Color("Gradient1"),
                Color("Gradient2"),
                Color("Gradient3"),
                ], startPoint: .topLeading, endPoint: .bottomTrailing))
                .foregroundColor(.white)
                .clipShape(Circle())
            }
            Button {
                self.show.toggle()
            } label: {
                Image(systemName: "chevron.up")
                    .resizable()
                    .frame(width: 40,height: 30)
                    .padding(22)
                    
            }
            .background(LinearGradient(colors: [
            Color("Gradient1"),
            Color("Gradient2"),
            Color("Gradient3"),
            ], startPoint: .topLeading, endPoint: .bottomTrailing))
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotationEffect(.init(degrees: self.show ? 180 : 0))
        }
        .animation(.spring())
    }
    
}
