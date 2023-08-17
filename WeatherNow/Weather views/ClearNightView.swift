//
//  ClearNight.swift
//  WeatherNow
//
//  Created by Kirill on 29.07.2023.
//

import UIKit

class ClearNightView: WeatherView {
    
    init() {
        super.init(backgroundViewColor: ViewColor.clearNight,
                   weatherImage: UIImage(named: "ClearNight") ?? UIImage())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
