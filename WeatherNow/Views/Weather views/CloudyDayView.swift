//
//  CloudyDayView.swift
//  WeatherNow
//
//  Created by Kirill on 29.07.2023.
//

import UIKit

class CloudyDayView: BackgroundView {
    
    init() {
        super.init(backgroundViewColor: ViewColor.cloudyDay,
                   weatherImage: UIImage(named: "CloudyDay") ?? UIImage())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
