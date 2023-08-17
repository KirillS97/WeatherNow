//
//  NetworkError.swift
//  WeatherNow
//
//  Created by Kirill on 16.08.2023.
//

import Foundation



enum NetworkError: Error, Equatable {
    case invalidURL
    case errorStatusCode(statusCode: Int)
    case errorFromServer
    case noStatusCode
    case noData
    case dataWasNotDecoded
}
