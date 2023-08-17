//
//  ClearDayView.swift
//  WeatherNow
//
//  Created by Kirill on 29.07.2023.
//

import UIKit

class ClearDayView: WeatherView {
    
    init() {
        super.init(backgroundViewColor: ViewColor.clearDay,
                   weatherImage: UIImage(named: "ClearDay") ?? UIImage())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
