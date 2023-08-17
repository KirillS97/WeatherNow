//
//  CloudyNightView.swift
//  WeatherNow
//
//  Created by Kirill on 29.07.2023.
//

import UIKit

class CloudyNightView: WeatherView {
    
    init() {
        super.init(backgroundViewColor: ViewColor.cloudyNight,
                   weatherImage: UIImage(named: "CloudyNight") ?? UIImage())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
