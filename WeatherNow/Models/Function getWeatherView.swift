//
//  Function getWeatherView.swift
//  WeatherNow
//
//  Created by Kirill on 02.08.2023.
//

import UIKit



// Функция для выбора подходящего BackgroundView на основе данных о погоде

func getWeatherView(weather: Weather) -> UIView {
    guard !weather.weather.isEmpty else {
        return UIView()
    }
    
    
    // MARK: Локальные переменные и константы
    /* - - - - - - - - - - - - - - - */
    var weatherView: BackgroundView!
    
    let weatherCondition = weather.weather[0].main
    
    let cloudiness: Double = weather.clouds.all
    let limitCloudiness: Double = 80
    
    let currentUnixTime = Double(Date().timeIntervalSince1970)
    let sunRiseUnixTime = weather.sys.sunrise
    let sunSetUnixTime = weather.sys.sunset
    /* - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Выбор подходящего View
    /* - - - - - - - - - - - - - - - */
    if (currentUnixTime > sunRiseUnixTime) && (currentUnixTime < sunSetUnixTime) {
        switch weatherCondition {
        case WeatherCondition.Clear.rawValue:
            weatherView = ClearDayView()
        case WeatherCondition.Clouds.rawValue:
            if cloudiness < limitCloudiness {
                weatherView = ClearDayView()
            } else {
                weatherView = CloudyDayView()
            }
        case let condition where (condition == WeatherCondition.Rain.rawValue) ||
            (condition == WeatherCondition.Drizzle.rawValue):
            weatherView = RainyDayView()
        case WeatherCondition.Snow.rawValue:
            weatherView = SnowyDayView()
        case WeatherCondition.Thunderstorm.rawValue:
            weatherView = StormDayView()
        default:
            weatherView = CloudyDayView()
        }
    } else {
        switch weatherCondition {
        case WeatherCondition.Clear.rawValue:
            weatherView = ClearNightView()
        case WeatherCondition.Clouds.rawValue:
            if cloudiness < limitCloudiness {
                weatherView = ClearNightView()
            } else {
                weatherView = CloudyNightView()
            }
        case let condition where (condition == WeatherCondition.Rain.rawValue) ||
            (condition == WeatherCondition.Drizzle.rawValue):
            weatherView = RainyNightView()
        case WeatherCondition.Snow.rawValue:
            weatherView = SnowyNightView()
        case WeatherCondition.Thunderstorm.rawValue:
            weatherView = StormNightView()
        default:
            weatherView = CloudyNightView()
        }
    }
    /* - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Установка параметров погоды
    /* - - - - - - - - - - - - - - - */
    // Установка локации
    weatherView.setLocation(location: weather.name)
    // Установка фактической температуры
    weatherView.setTemperature(temperature: Int(weather.main.temp))
    // Установка описания погоды
    weatherView.setWeatherDescription(description: weather.weather[0].description)
    // Установка ощущаемой температуры
    weatherView.setPerceivedTemperature(temperature: Int(weather.main.feels_like))
    // Установка скорости ветра
    weatherView.setWindSpeed(speed: weather.wind.speed)
    // Установка облачности
    weatherView.setCloudiness(cloudines: weather.clouds.all)
    // Установка времени до рассвета/заката + установка изображения данного параметра
    if (currentUnixTime > sunRiseUnixTime) && (currentUnixTime < sunSetUnixTime) {
        let timeInSecondsBeforeSunSet = Int((sunSetUnixTime - currentUnixTime).magnitude)
        let hoursBeforeSunSet = timeInSecondsBeforeSunSet / 3600
        let minutesRemind = (timeInSecondsBeforeSunSet%3600) / 60
        weatherView.setTimeUntilTheSunChangesPosition(image: UIImage(named: "IconNight") ?? UIImage(),
                                                      parameter: "Закат через",
                                                      value: "\(hoursBeforeSunSet):\(minutesRemind) ч")
    } else if currentUnixTime < sunRiseUnixTime {
        let timeInSecondsBeforeSunSet = Int((sunRiseUnixTime - currentUnixTime).magnitude)
        let hoursBeforeSunSet = timeInSecondsBeforeSunSet / 3600
        let minutesRemind = (timeInSecondsBeforeSunSet%3600) / 60
        weatherView.setTimeUntilTheSunChangesPosition(image: UIImage(named: "IconSun") ?? UIImage(),
                                                      parameter: "Рассвет через",
                                                      value: "\(hoursBeforeSunSet):\(minutesRemind) ч")
    } else {
        let dayInSeconds: Int = 24 * 3600
        let timeInSecondsBeforeSunRise = dayInSeconds - Int((sunRiseUnixTime - currentUnixTime).magnitude)
        let hoursBeforeSunRise = timeInSecondsBeforeSunRise / 3600
        let minutesRemind = (timeInSecondsBeforeSunRise%3600) / 60
        weatherView.setTimeUntilTheSunChangesPosition(image: UIImage(named: "IconSun") ?? UIImage(),
                                                      parameter: "Рассвет через",
                                                      value: "\(hoursBeforeSunRise):\(minutesRemind) ч")
    }
    /* - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Возврат BackgroundView
    /* - - - - - - - - - - - - - - - */
    return weatherView
    /* - - - - - - - - - - - - - - - */
    
}

