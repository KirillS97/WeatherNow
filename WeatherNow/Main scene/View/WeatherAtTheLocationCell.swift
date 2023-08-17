//
//  WeatherAtTheLocationCell.swift
//  WeatherNow
//
//  Created by Kirill on 01.08.2023.
//

import UIKit
import SnapKit



// MARK: - Ячейка WeatherAtTheLocationCell для коллекции MainCollectionView
/*===================================================================================*/
class WeatherAtTheLocationCell: UICollectionViewCell {
    
    
    
    // MARK: Свойства класса
    /* - - - - - - - - - - - - - - - - - - - - */
    static let reuseId: String = "WeatherAtTheLocationCell"
    /* - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Свойства объектов класса
    /* - - - - - - - - - - - - - - - - - - - - */
    var weatherView = UIView()
    var noticeLabel = UILabel()
    /* - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка view
    /* - - - - - - - - - - - - - - - - - - - - */
    private func setUpWeatherView() -> Void {
        self.addSubview(self.weatherView)
        self.addConstraintsToWeatherView()
    }
    
    private func addConstraintsToWeatherView() -> Void {
        self.weatherView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.bottom.equalTo(self.snp.bottom)
            make.trailing.equalTo(self.snp.trailing)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка метки с уведомлением
    /* - - - - - - - - - - - - - - - - - - - - */
    private func setUpNoticeLabel() -> Void {
        self.noticeLabel = UILabel()
        self.addSubview(self.noticeLabel)
        self.addConstraintsToNoticeLabel()
        self.noticeLabel.text = "Данные от сервера не были получены"
        self.noticeLabel.textColor = .white
        self.noticeLabel.numberOfLines = 0
        self.noticeLabel.textAlignment = .natural
        self.noticeLabel.font = .systemFont(ofSize: 20, weight: .light)
    }
    
    // Установка ограничений уведомительной метки
    private func addConstraintsToNoticeLabel() -> Void {
        self.noticeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(50)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Метод для изменения цвета
    /* - - - - - - - - - - - - - - - - - - - - */
    func setUpView(weather: Weather) -> Void {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        self.weatherView = WeatherView.getWeatherView(weather: weather)
        self.setUpWeatherView()
    }
    /* - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Инициализаторы
    /* - - - - - - - - - - - - - - - - - - - - */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpWeatherView()
        self.weatherView.backgroundColor = .systemGray
        self.setUpNoticeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /* - - - - - - - - - - - - - - - - - - - - */
    
    
}
/*===================================================================================*/
