//
//  Colors.swift
//  WeatherNow
//
//  Created by Kirill on 29.07.2023.
//

import Foundation
import  UIKit

enum ViewColor {
    case clearDay
    case clearNight
    case cloudyDay
    case cloudyNight
    
    func getColor() -> UIColor {
        switch self {
        case .clearDay:
            return UIColor(red: 112/255, green: 157/255, blue: 210/255, alpha: 1)
        case .clearNight:
            return UIColor(red: 41/255, green: 51/255, blue: 82/255, alpha: 1)
        case .cloudyDay:
            return UIColor(red: 158/255, green: 170/255, blue: 180/255, alpha: 1)
        case .cloudyNight:
            return UIColor(red: 43/255, green: 44/255, blue: 51/255, alpha: 1)
        }
    }
    
}
