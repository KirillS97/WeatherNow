//
//  URLCreator.swift
//  WeatherNow
//
//  Created by Kirill on 16.08.2023.
//

import Foundation



struct URLCreator {
    
    static let shared = URLCreator(); private init() {}
    
    private let language = "ru"
    private let units = "metric"
    private let appIdkey = "dfce58943f6302ee4604db1d48859bd0"
    private let baseURL: URL? = URL(string: "https://api.openweathermap.org/data/2.5/weather")
    
    func getURL(cityName: String) -> URL? {
        guard  let baseURL else { return nil }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        let queryCityNameItem = URLQueryItem(name: "q", value: cityName)
        let queryLanguageItem = URLQueryItem(name: "lang", value: self.language)
        let queryUnitsitem = URLQueryItem(name: "units", value: self.units)
        let queryAppIdKeyItem = URLQueryItem(name: "APPID", value: self.appIdkey)
        urlComponents?.queryItems = [queryCityNameItem, queryLanguageItem, queryUnitsitem, queryAppIdKeyItem]
        return urlComponents?.url
    }
    
}
