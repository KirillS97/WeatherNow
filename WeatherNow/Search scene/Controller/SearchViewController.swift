//
//  SearchViewController.swift
//  WeatherNow
//
//  Created by Kirill on 02.08.2023.
//

import UIKit



// MARK: - SearchViewController
/*===================================================================================*/
class SearchViewController: UIViewController {
    
    
    
    // MARK: - Свойства объектов класса
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private let networkManager = NetwokManager.shared
    private let urlCreator     = URLCreator.shared
    private let storage        = Storage.shared
    
    private var weatherForAdding: Weather?
    
    private var searchView: SearchView!
    
    var closureForUpdateListVC: (() -> Void)?
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - loadView
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    override func loadView() {
        super.loadView()
        self.searchView = SearchView(searchButtonTarger: self,
                                     searchButtonAction: #selector(self.search),
                                     addButtonTarger: self,
                                     addButtonAction: #selector(self.addButtonHandler),
                                     keyboardDoneButtonTarger: self,
                                     keyboardDoneButtonAction: #selector(self.search))
        self.view = self.searchView
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для отправки GET-запроса на сервер и обработки ответа
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    @objc func search() -> Void {
        guard let textInTextField = self.searchView.searchTextField.text else { return }
        
        if !textInTextField.isEmpty {
            
            // Инициализация и настройка AlertController, который должен всплывать при неудовлетворительном ответе сервера на запрос
            /* - - - - - - - - - - - - - - - - */
            let alertController = UIAlertController(title: "Топонима с таким названием не существует", message: "Проверьте название", preferredStyle: .alert)
            let alertButtonOk = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(alertButtonOk)
            /* - - - - - - - - - - - - - - - - */
            
            
            
            // Отправка запроса на сервер и обработка ответа сервера
            /* - - - - - - - - - - - - - - - - */
            let url = self.urlCreator.getURL(cityName: textInTextField)
            self.networkManager.fetchData(url: url) { (result: Result<Weather, NetworkError>) in
                switch result {
                case .failure(.errorStatusCode(statusCode: 404)):
                    self.view.backgroundColor = .systemGray6
                    self.searchView.changeTheMainView(view: UIView())
                    self.searchView.hideAddButton(isHidden: true)
                    self.weatherForAdding = nil
                    self.present(alertController, animated: true)
                case .success(let weather):
                    self.searchView.changeTheMainView(view: WeatherView.getWeatherView(weather: weather))
                    self.searchView.updateColor()
                    self.searchView.hideAddButton(isHidden: false)
                    self.weatherForAdding = weather
                default:
                    self.view.backgroundColor = .systemGray6
                    alertController.title = "Ошибка"
                    alertController.message = "Неправильрый код статуса ответа сервера"
                    self.searchView.changeTheMainView(view: UIView())
                    self.searchView.hideAddButton(isHidden: true)
                    self.weatherForAdding = nil
                    self.present(alertController, animated: true)
                }
            }
            /* - - - - - - - - - - - - - - - - */
        }
        
        
        // Сокрытие клавиатуры
        /* - - - - - - - - - - - - - - - - */
        self.hideTheKeyboard()
        /* - - - - - - - - - - - - - - - - */
        
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для обработки нажатия на кнопку "Добавить"
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    @objc func addButtonHandler() -> Void {
        if let weatherForAdding {
            self.storage.saveCity(cityName: weatherForAdding.name)
        }
        self.dismiss(animated: true, completion: { () -> Void in
            if let closureForUpdateListVC = self.closureForUpdateListVC {
                closureForUpdateListVC()
            }
        })
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для сокрытия клавиатуры
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func hideTheKeyboard() -> Void {
        self.view.endEditing(true)
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

}
/*===================================================================================*/
