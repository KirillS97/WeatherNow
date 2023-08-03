//
//  SnowyNightView.swift
//  WeatherNow
//
//  Created by Kirill on 29.07.2023.
//

import Foundation
import UIKit

class SnowyNightView: BackgroundView {
    
    init() {
        super.init(backgroundViewColor: ViewColor.cloudyNight,
                   weatherImage: UIImage(named: "SnowyNight") ?? UIImage())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
