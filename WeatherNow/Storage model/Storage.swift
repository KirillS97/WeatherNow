//
//  Storage.swift
//  WeatherNow
//
//  Created by Kirill on 02.08.2023.
//

import Foundation



class Storage {
    
    
    
    // Свойства класса
    /* - - - - - - - - - - - - - - - - - - - */
    static let cityNamesKey = "cityNames"
    static let shared = Storage(); private init() {}
    /* - - - - - - - - - - - - - - - - - - - */
    
    
    
    // Свойства объекта
    /* - - - - - - - - - - - - - - - - - - - */
    private let storage = UserDefaults.standard
    /* - - - - - - - - - - - - - - - - - - - */
    
    
    
    // Метод для сохранения массива городов
    /* - - - - - - - - - - - - - - - - - - - */
    func saveCities(citiesArray: [String]) -> Void {
        self.storage.set(citiesArray, forKey: Storage.cityNamesKey)
    }
    /* - - - - - - - - - - - - - - - - - - - */
    
    
    
    // Метод для добавления нового города в массив городов
    /* - - - - - - - - - - - - - - - - - - - */
    func saveCity(cityName: String) -> Void {
        var savedCities = self.getCities()
        savedCities.append(cityName)
        self.saveCities(citiesArray: savedCities)
    }
    /* - - - - - - - - - - - - - - - - - - - */
    
    
    
    // Метод для удаления города из массива городов
    /* - - - - - - - - - - - - - - - - - - - */
    func removeCity(cityName: String) -> Void {
        var citiesArray = self.getCities()
        for i in 0..<citiesArray.count {
            if citiesArray[i] == cityName {
                citiesArray.remove(at: i)
                break
            }
        }
        self.saveCities(citiesArray: citiesArray)
    }
    /* - - - - - - - - - - - - - - - - - - - */
    
    
    
    // Метод для извлечения массива городов из хранищила
    /* - - - - - - - - - - - - - - - - - - - */
    func getCities() -> [String] {
        if let citiesArray = self.storage.object(forKey: Storage.cityNamesKey) as? [String] {
            return citiesArray
        } else {
            return []
        }
    }
    /* - - - - - - - - - - - - - - - - - - - */
    
}

