//
//  Weather.swift
//  WeatherNow
//
//  Created by Kirill on 30.07.2023.
//

import Foundation



struct WeatherDescription: Codable {
    let main: String
    let description: String
}

struct Temperature: Codable {
    let temp: Double
    let feels_like: Double
}

struct Wind: Codable {
    let speed: Double
}

struct Clouds: Codable {
    let all: Double
}

struct SolarTime: Codable {
    let sunrise: Double
    let sunset: Double
}

struct Weather: Codable {
    let weather: [WeatherDescription]
    let main: Temperature
    let wind: Wind
    let clouds: Clouds
    let sys: SolarTime
    let timezone: Double
    let name: String
}
