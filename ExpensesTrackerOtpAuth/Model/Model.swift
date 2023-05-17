//
//  Model.swift
//  ChartViewSwiftUi
//
//  Created by Abdoulaye Aliou SALL on 15/05/2023.
//

import Foundation
import SwiftUI

struct Downlaod: Identifiable {
    var id = UUID().uuidString
    var download : CGFloat
    var weekDay: String;
    
}

var dowloads: [Downlaod] = [
    
    Downlaod(download: 550, weekDay: "Mon"),
    Downlaod(download: 200, weekDay: "Tue"),
    Downlaod(download: 400, weekDay: "Wed"),
    Downlaod(download: 255, weekDay: "thu"),
    Downlaod(download: 300, weekDay: "Fri"),
    Downlaod(download: 200, weekDay: "Sat"),
    Downlaod(download: 125, weekDay: "Sun")
]
