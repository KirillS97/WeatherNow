//
//  BackgroundView.swift
//  WeatherNow
//
//  Created by Kirill on 29.07.2023.
//

import UIKit
import SnapKit



class WeatherView: UIView {
    
    
    
    // MARK: Свойства
    /* - - - - - - - - - - - - - - - - - - - - - - */
    private var backgroundViewColor         : ViewColor
    
    private var weatherImage                : UIImage
    private var imageView                   : UIImageView!
    
    private var scrollView                  : UIScrollView!
    
    private var locationLabel               : UILabel!
    private var temperatureLabel            : UILabel!
    private var celsiusSignLabel            : UILabel!
    private var weatherDescriptionLabel     : UILabel!
    private var mainVerticalStackView       : UIStackView!
    
    private var feelsLikeParameterView      : WeatherParameterView!
    private var windSpeedParameterView      : WeatherParameterView!
    private var sunRiseOrSunSetParameterView: WeatherParameterView!
    private var cloudinessParameterView     : WeatherParameterView!
    private var weatherParametersStackView  : UIStackView!
    /* - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка BackgroundView
    /* - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpSelf() {
        self.setUpColor()
        self.setUpScrollView()
        self.setUpImageView()
        self.setUpLocationLabel()
        self.setUpTemperatureLabel()
        self.setUpWeatherDescriptionLabel()
        self.setUpMainVerticalStackView()
        self.setUpFeelsLikeParameterView()
        self.setUpWindSpeedParameterView()
        self.setUpSunRiseOrSunSetParameterView()
        self.setUpCloudinessParameterView()
        self.setUpWeatherParametersStackView()
    }
    
    private func setUpColor() -> Void {
        self.backgroundColor = backgroundViewColor.getColor()
    }
    /* - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка scrollView
    /* - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpScrollView() -> Void {
        self.scrollView = UIScrollView()
        self.addSubview(self.scrollView)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.addConstraintsToScrollView()
    }
    
    private func addConstraintsToScrollView() -> Void {
        self.scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.trailing.equalTo(self.scrollView.contentLayoutGuide.snp.trailing)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка imageView
    /* - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpImageView() -> Void {
        self.imageView = UIImageView(image: self.weatherImage)
        self.imageView.contentMode = .scaleAspectFit
        self.scrollView.addSubview(self.imageView)
        self.addConstraintsToImageView()
    }
    
    private func addConstraintsToImageView() -> Void {
        self.imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.width.lessThanOrEqualTo(self.snp.width).dividedBy(2)
            make.width.lessThanOrEqualTo(self.snp.height).dividedBy(2)
            make.height.equalTo(self.imageView.snp.width)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка locationLabel
    /* - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpLocationLabel() -> Void {
        self.locationLabel = UILabel()
        self.locationLabel.textAlignment = .center
        self.locationLabel.numberOfLines = 0
        self.locationLabel.textColor = .white
        self.locationLabel.font = .systemFont(ofSize: 40, weight: .thin)
        self.locationLabel.text = ""
    }
    /* - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка temperatureLabel
    /* - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpTemperatureLabel() -> Void {
        self.temperatureLabel = UILabel()
        self.temperatureLabel.textAlignment = .center
        self.temperatureLabel.textColor = .white
        self.temperatureLabel.font = .systemFont(ofSize: 100, weight: .thin)
        self.temperatureLabel.text = ""
    }
    /* - - - - - - - - - - - - - - - - - - - - - - */
    
    
    // MARK: Настройка weatherDescriptionLabel
    /* - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpWeatherDescriptionLabel() -> Void {
        self.weatherDescriptionLabel = UILabel()
        self.weatherDescriptionLabel.textAlignment = .center
        self.weatherDescriptionLabel.textColor = .white
        self.weatherDescriptionLabel.numberOfLines = 0
        self.weatherDescriptionLabel.font = .systemFont(ofSize: 25, weight: .thin)
        self.weatherDescriptionLabel.text = ""
    }
    /* - - - - - - - - - - - - - - - - - - - - - - */

    
    
    // MARK: Настройка mainVerticalStackView
    /* - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpMainVerticalStackView() -> Void {
        self.mainVerticalStackView = UIStackView()
        self.scrollView.addSubview(self.mainVerticalStackView)
        self.mainVerticalStackView.axis = .vertical
        self.mainVerticalStackView.spacing = 0
        self.mainVerticalStackView.alignment = .center
        self.mainVerticalStackView.distribution = .equalSpacing
        self.mainVerticalStackView.addArrangedSubview(self.locationLabel)
        self.mainVerticalStackView.addArrangedSubview(self.temperatureLabel)
        self.mainVerticalStackView.addArrangedSubview(self.weatherDescriptionLabel)
        self.addConstraintsToVerticalStackView()
    }
    
    private func addConstraintsToVerticalStackView() -> Void {
        self.mainVerticalStackView.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom)
            make.leading.equalTo(self.scrollView.contentLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.scrollView.contentLayoutGuide.snp.trailing).offset(-20)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка celsiusSignLabel
    /* - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpCelsiusSignLabel() -> Void {
        self.celsiusSignLabel = UILabel()
        self.celsiusSignLabel.textAlignment = .center
        self.celsiusSignLabel.textColor = .white
        self.celsiusSignLabel.font = .systemFont(ofSize: 100, weight: .thin)
        self.celsiusSignLabel.text = "\u{00B0}"
        self.mainVerticalStackView.addSubview(self.celsiusSignLabel)
        self.addConstraintsToCelsiusSignLabel()
    }
    
    private func addConstraintsToCelsiusSignLabel() -> Void {
        self.celsiusSignLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.temperatureLabel.snp.centerY)
            make.leading.equalTo(self.temperatureLabel.snp.trailing)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - */

    
    
    // MARK: Настройка feelsLikeParameterView
    /* - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpFeelsLikeParameterView() -> Void {
        self.feelsLikeParameterView = WeatherParameterView(image: UIImage(named: "IconThermometer") ?? UIImage(),
                                                           parameter: "Ощущается как",
                                                           parameterValue: "value")
    }
    /* - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка windSpeedParameterView
    /* - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpWindSpeedParameterView() -> Void {
        self.windSpeedParameterView = WeatherParameterView(image: UIImage(named: "IconWind") ?? UIImage(),
                                                           parameter: "Скорость ветра",
                                                           parameterValue: "value")
    }
    /* - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка sunRiseOrSunSetParameterView
    /* - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpSunRiseOrSunSetParameterView() -> Void {
        self.sunRiseOrSunSetParameterView = WeatherParameterView(image: UIImage(named: "IconSun") ?? UIImage(),
                                                                 parameter: "Закат через",
                                                                 parameterValue: "value")
    }
    /* - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка cloudinessParameterView
    /* - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpCloudinessParameterView() -> Void {
        self.cloudinessParameterView = WeatherParameterView(image: UIImage(named: "IconCloud") ?? UIImage(),
                                                            parameter: "Облачность",
                                                            parameterValue: "value")
    }
    /* - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка weatherParametersStackView
    /* - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpWeatherParametersStackView() -> Void {
        self.weatherParametersStackView = UIStackView()
        self.scrollView.addSubview(self.weatherParametersStackView)
        self.weatherParametersStackView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        self.weatherParametersStackView.layer.cornerRadius = 25
        self.weatherParametersStackView.axis = .vertical
        self.weatherParametersStackView.alignment = .fill
        self.weatherParametersStackView.distribution = .fill
        self.weatherParametersStackView.spacing = 20
        self.weatherParametersStackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        self.weatherParametersStackView.isLayoutMarginsRelativeArrangement = true
        self.weatherParametersStackView.addArrangedSubview(self.feelsLikeParameterView)
        self.weatherParametersStackView.addArrangedSubview(self.windSpeedParameterView)
        self.weatherParametersStackView.addArrangedSubview(self.sunRiseOrSunSetParameterView)
        self.weatherParametersStackView.addArrangedSubview(self.cloudinessParameterView)
        self.addConstraintsToWeatherParametersStackView()
    }
    
    private func addConstraintsToWeatherParametersStackView() -> Void {
        self.weatherParametersStackView.snp.makeConstraints { make in
            make.top.equalTo(self.mainVerticalStackView.snp.bottom).offset(50)
            make.leading.equalTo(self.mainVerticalStackView.snp.leading)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.scrollView.contentLayoutGuide.snp.bottom)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - */
    
    

    // MARK: Общедоступные методы
    /* - - - - - - - - - - - - - - - - - - - - - - */
    // Установка фактической температуры
    func setTemperature(temperature: Int) -> Void {
        self.temperatureLabel.text = String(temperature)
        self.setUpCelsiusSignLabel()
    }
    
    // Установка локации
    func setLocation(location: String) -> Void {
        self.locationLabel.text = location
    }
    
    // Установка описания погоды
    func setWeatherDescription(description: String) -> Void {
        self.weatherDescriptionLabel.text = description
    }
    
    // Установка ощущаемой температуры
    func setPerceivedTemperature(temperature: Int) -> Void {
        self.feelsLikeParameterView.setParameterValue(value: "\(temperature)\u{00B0}")
    }
    
    // Установка скорости ветра
    func setWindSpeed(speed: Double) -> Void {
        self.windSpeedParameterView.setParameterValue(value: "\(speed) м/с")
    }
    
    // Установка облачности
    func setCloudiness(cloudines: Double) -> Void {
        self.cloudinessParameterView.setParameterValue(value: "\(cloudines) %")
    }
    
    // Установка времени до заката/рассвета + установка изображения
    func setTimeUntilTheSunChangesPosition(image: UIImage, parameter: String, value: String) -> Void {
        self.sunRiseOrSunSetParameterView.setImage(image: image)
        self.sunRiseOrSunSetParameterView.setParameter(parameter: parameter)
        self.sunRiseOrSunSetParameterView.setParameterValue(value: value)
    }
    /* - - - - - - - - - - - - - - - - - - - - - - */
    

    
    // MARK: Инициализаторы
    /* - - - - - - - - - - - - - - - - - - - - - - */
    init(backgroundViewColor: ViewColor, weatherImage: UIImage) {
        self.backgroundViewColor = backgroundViewColor
        self.weatherImage = weatherImage
        super.init(frame: CGRect.zero)
        self.setUpSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /* - - - - - - - - - - - - - - - - - - - - - - */
    

    
}




extension WeatherView {
    
    // MARK: Метод для создания подходящего WeatherView (ClearDayView, ClearNightView и т.д.) на основе данных о погоде
    static func getWeatherView(weather: Weather) -> UIView {
        guard !weather.weather.isEmpty else { return UIView() }
        var weatherView = WeatherView.getEmptyWeatherView(weather: weather)                      // Инициализация вью
        WeatherView.setUpWeatherParametersIntoView(weatherView: &weatherView, weather: weather)  // Установка параметров погоды
        return weatherView
    }
    
    // MARK: Метод для создания пустого (не настроенного) WeatherView
    private static func getEmptyWeatherView(weather: Weather) -> WeatherView {
        
        // Локальные переменные и константы
        var weatherView: WeatherView!                               // Вью, содержащее погодные данные
        let weatherCondition = weather.weather[0].main              // Погодные условия (дождь, снег и т.д.)
        let cloudiness: Double = weather.clouds.all                 // Значение облачности
        let limitCloudiness: Double = 80                            // Значение области, при котором погода считается пасмурной
        let currentUnixTime = Double(Date().timeIntervalSince1970)  // Текущее время в формате Unix
        let sunRiseUnixTime = weather.sys.sunrise                   // Время рассвета в формате Unix
        let sunSetUnixTime  = weather.sys.sunset                    // Время заката в формате Unix
        
        // Инициализация weatherView в соответствии с погодными данными
        if (currentUnixTime > sunRiseUnixTime) && (currentUnixTime < sunSetUnixTime) {
            switch weatherCondition {
            case WeatherCondition.Clear.rawValue:
                weatherView = ClearDayView()
            case WeatherCondition.Clouds.rawValue:
                if cloudiness < limitCloudiness { weatherView = ClearDayView() }
                else { weatherView = CloudyDayView() }
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
                if cloudiness < limitCloudiness { weatherView = ClearNightView() }
                else { weatherView = CloudyNightView() }
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
        
        return weatherView
    }
    
    // MARK: Метод для настройки WeatherView
    private static func setUpWeatherParametersIntoView(weatherView: inout WeatherView, weather: Weather) -> Void {
        
        let currentUnixTime = Double(Date().timeIntervalSince1970)                      // Текущее время в формате Unix
        let sunRiseUnixTime = weather.sys.sunrise                                       // Время рассвета в формате Unix
        let sunSetUnixTime  = weather.sys.sunset                                        // Время заката в формате Unix
        
        weatherView.setLocation(location: weather.name)                                 // Установка локации
        weatherView.setTemperature(temperature: Int(weather.main.temp))                 // Установка фактической температуры
        weatherView.setWeatherDescription(description: weather.weather[0].description)  // Установка описания погоды
        weatherView.setPerceivedTemperature(temperature: Int(weather.main.feels_like))  // Установка ощущаемой температуры
        weatherView.setWindSpeed(speed: weather.wind.speed)                             // Установка скорости ветра
        weatherView.setCloudiness(cloudines: weather.clouds.all)                        // Установка облачности
        
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
    }
    
}
