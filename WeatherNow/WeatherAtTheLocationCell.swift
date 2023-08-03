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
    var view: UIView = UIView()
    /* - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка view
    /* - - - - - - - - - - - - - - - - - - - - */
    private func setUpView() -> Void {
        self.addSubview(self.view)
        self.addConstraintsToView()
    }
    
    private func addConstraintsToView() -> Void {
        self.view.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.bottom.equalTo(self.snp.bottom)
            make.trailing.equalTo(self.snp.trailing)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Метод для изменения цвета
    /* - - - - - - - - - - - - - - - - - - - - */
    func changeView(view: UIView) -> Void {
        self.view = view
        self.setUpView()
    }
    /* - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Инициализаторы
    /* - - - - - - - - - - - - - - - - - - - - */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /* - - - - - - - - - - - - - - - - - - - - */
    
    
}
/*===================================================================================*/
