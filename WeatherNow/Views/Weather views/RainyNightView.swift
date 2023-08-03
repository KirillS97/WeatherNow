//
//  RainyNight.swift
//  WeatherNow
//
//  Created by Kirill on 29.07.2023.
//

import Foundation
import UIKit

class RainyNightView: BackgroundView {
    
    init() {
        super.init(backgroundViewColor: ViewColor.cloudyNight,
                   weatherImage: UIImage(named: "RainyNight") ?? UIImage())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
