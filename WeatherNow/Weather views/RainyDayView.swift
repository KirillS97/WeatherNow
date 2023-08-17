//
//  RainyDayView.swift
//  WeatherNow
//
//  Created by Kirill on 29.07.2023.
//

import Foundation
import UIKit

class RainyDayView: WeatherView {
    
    init() {
        super.init(backgroundViewColor: ViewColor.cloudyDay,
                   weatherImage: UIImage(named: "RainyDay") ?? UIImage())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

