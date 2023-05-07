//
//  AnimatedIcons.swift
//  Tabview
//
//  Created by Abdoulaye Aliou SALL on 06/05/2023.
//

import SwiftUI
import Lottie

struct AnimatedIcon : Identifiable {
    var id : String = UUID().uuidString
    var tabIcon : Tab
    var lottieView : LottieAnimationView
}
