//
//  ToolBar.swift
//  WeatherNow
//
//  Created by Kirill on 31.07.2023.
//

import UIKit



// MARK: - Панель инструментов для MainViewController
/*===================================================================================*/
class ToolBar: UIToolbar {
    
    
    
    // MARK: Кнопки для панели инструментов
    /* - - - - - - - - - - - - - - - - - - - */
    private var listButton : UIBarButtonItem! // Кнопка для перехода к ListViewController
    private var emptyButton: UIBarButtonItem! // Пустая кнопка, чтобы сдвинуть кнопку listButton вправо
    /* - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка кнопки перехода к ListViewController
    /* - - - - - - - - - - - - - - - - - - - */
    private func setUpListButton(targetToListButtonHandler: Any?, selector: Selector) -> Void {
        let button = UIButton()
        button.setTitle("Список мест", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.addTarget(targetToListButtonHandler, action: selector, for: .touchUpInside)
        self.listButton = UIBarButtonItem(customView: button)
    }
    /* - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка пустой кнопки
    /* - - - - - - - - - - - - - - - - - - - */
    private func setUpEmptyButton() -> Void {
        self.emptyButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                           target: nil,
                                           action: nil)
    }
    /* - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка панели инструментов
    /* - - - - - - - - - - - - - - - - - - - */
    private func setUpToolBar(targetToListButtonHandler: Any?, selector: Selector) -> Void {
        self.setUpListButton(targetToListButtonHandler: targetToListButtonHandler, selector: selector)
        self.setUpEmptyButton()
        self.setItems([self.emptyButton, self.listButton], animated: false)
        
        // Изображение добавляется для того, чтобы сделать цвет панели инструментов прозрачным т.к. изображение пустое
        let image = UIImage()
        self.setBackgroundImage(image, forToolbarPosition: .any, barMetrics: .default)
    }
    /* - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Инициализаторы
    /* - - - - - - - - - - - - - - - - - - - */
    init(targerForListButtonHandler: Any?, handler: Selector) {
        super.init(frame: CGRect.zero)
        self.setUpToolBar(targetToListButtonHandler: targerForListButtonHandler, selector: handler)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /* - - - - - - - - - - - - - - - - - - - */
    
    
}
/*===================================================================================*/
