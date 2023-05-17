//
//  MainView.swift
//  Tabview
//
//  Created by Abdoulaye Aliou SALL on 06/05/2023.
//

import SwiftUI
import Lottie

struct MainView: View {
    init(){
        UITabBar.appearance().isHidden = true
    }
    // view Propreties
    @AppStorage("log_status") var log_Status = false
    @State var currentTab : Tab = .home
    @State var animatedIcons : [AnimatedIcon] = {
        var tabs : [AnimatedIcon] = []
        for tab in Tab.allCases{
            tabs.append(.init(tabIcon: tab, lottieView: LottieAnimationView(name: tab.rawValue,bundle: .main)))
        }
        return tabs
    }()
    @Environment(\.colorScheme) var schema
    var body: some View {
        VStack(spacing: 0){
            TabView(selection: $currentTab){
                HomeTrackerView()
                    .setBG()
                    .tag(Tab.home)
                
                HomeChartView()
                    .setBG()
                    .tag(Tab.chart)
                
                Text("notification")
                    .setBG()
                    .tag(Tab.notification)
                
                Button {
                    log_Status = false
                } label: {
                    Text("Deconnection")
                }
                    .setBG()
                    .tag(Tab.setting)
            }
            //iOS 16 updated
            if #available(iOS 16, *){
                TabBar()
                    .toolbar(.hidden, for: .tabBar)
            }else{
                TabBar()
            }
        }
    }
    @ViewBuilder
    func TabBar() -> some View {
        HStack(spacing: 0){
            ForEach(animatedIcons){icon in
                let tabColor :SwiftUI.Color = currentTab == icon.tabIcon ? (schema == .dark ? .white : .black) : .gray.opacity(0.6)
                ResizableLottieView(lottieView: icon.lottieView, color: tabColor)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30,height: 30)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        currentTab = icon.tabIcon
                        icon.lottieView.play{_ in
                            
                            
                        }
                    }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background{
            (schema == .dark ? Color.black : Color.white)
                .ignoresSafeArea()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension View{
    @ViewBuilder
    func setBG() -> some View{
        self
            .frame(maxWidth: .infinity , maxHeight: .infinity)
            .background{
                Color.primary
                    .opacity(0.05)
                    .ignoresSafeArea()
            }
    }
}


