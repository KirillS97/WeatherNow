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
    private let urlCreator = URLCreator()
    private let storage = Storage()
    
    private var weatherForAdding: Weather?
    
    private var searchTextField: UITextField!
    private var searchButton: UIButton!
    private var searchStackView: UIStackView!
    private var mainView = UIView()
    private var addButton: UIButton!
    
    var closureForUpdateListVC: (() -> Void)?
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - viewDidLoad
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // MARK: Настройка цвета фона
        /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.view.backgroundColor = .systemGray6
        /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка дочерних графических элементов
        /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
        self.setUpSearchTextField()
        self.setUpSearchButton()
        self.setUpSearchStackView()
        self.setUpAddButton()
        self.setUpMainView()
        /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка панели инструментов для input view (клавиатуры)
        /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let emptyButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let keyboardButtonDone = UIBarButtonItem(title: "Готово",
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(self.search))
        toolbar.setItems([emptyButton, keyboardButtonDone], animated: false)
        self.searchTextField.inputAccessoryView = toolbar
        /* - - - - - - - - - - - - - - - - - - - - - - - - - - */
        
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Настройка searchTextField
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpSearchTextField() -> Void {
        self.searchTextField = UITextField()
        self.searchTextField.placeholder = "Введите название населённого пункта"
        self.searchTextField.textColor = .black
        self.searchTextField.font = .systemFont(ofSize: 17, weight: .light)
        self.searchTextField.backgroundColor = .white
        self.searchTextField.borderStyle = .roundedRect
        self.searchTextField.snp.contentCompressionResistanceHorizontalPriority = 249
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Настройка searchButton
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpSearchButton() -> Void {
        self.searchButton = UIButton()
        self.searchButton.setImage(UIImage(systemName: "magnifyingglass")?.withTintColor(.black) ?? UIImage(),
                                   for: .normal)
        self.searchButton.setImage(UIImage(systemName: "magnifyingglass")?.withTintColor(.systemGray3) ?? UIImage(),
                                   for: .normal)
        self.searchButton.snp.contentCompressionResistanceHorizontalPriority = 250
        self.searchButton.addTarget(self, action: #selector(self.search), for: .touchUpInside)
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Настройка searchStackView
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpSearchStackView() -> Void {
        self.searchStackView = UIStackView(arrangedSubviews: [self.searchTextField, self.searchButton])
        self.view.addSubview(self.searchStackView)
        self.searchStackView.axis = .horizontal
        self.searchStackView.alignment = .center
        self.searchStackView.distribution = .fill
        self.searchStackView.spacing = 10
        self.searchStackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        self.searchStackView.isLayoutMarginsRelativeArrangement = true
        self.searchStackView.backgroundColor = .white
        self.addConstraintsToSearchStackView()
    }
    
    private func addConstraintsToSearchStackView() -> Void {
        self.searchStackView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Настройка вью, отображающего погоду
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpMainView() {
        self.view.addSubview(self.mainView)
        self.addConstraintsToMainView()
    }
    
    private func addConstraintsToMainView() -> Void {
        self.mainView.snp.makeConstraints { make in
            make.top.equalTo(self.searchStackView.snp.bottom).offset(50)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.addButton.snp.top).offset(-25)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для изменения вью, отображающего погоду
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func changeTheMainView(view: UIView) -> Void {
        self.mainView.removeFromSuperview()
        self.mainView = view
        self.setUpMainView()
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    

    
    // MARK: - Настройка кнопки Добавить
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpAddButton() -> Void {
        self.addButton = UIButton()
        self.view.addSubview(self.addButton)
        self.addButton.setTitle("Добавить", for: .normal)
        self.addButton.setTitleColor(.black, for: .normal)
        self.addButton.setTitleColor(.systemGray3, for: .highlighted)
        self.addButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        self.addButton.backgroundColor = .white
        self.addButton.layer.cornerRadius = 25
        self.addButton.addTarget(self, action: #selector(self.addButtonHandler), for: .touchUpInside)
        self.addConstraintsToAddButton()
        self.addButton.isHidden = true
    }
    
    private func addConstraintsToAddButton() -> Void {
        self.addButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для отправки GET-запроса на сервер и обработки ответа
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    @objc func search() -> Void {
        guard let textInTextField = self.searchTextField.text else { return }
        
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
                    self.changeTheMainView(view: UIView())
                    self.addButton.isHidden = true
                    self.weatherForAdding = nil
                    self.present(alertController, animated: true)
                case .success(let weather):
                    self.changeTheMainView(view: getWeatherView(weather: weather))
                    self.view.backgroundColor = self.mainView.backgroundColor
                    self.addButton.isHidden = false
                    self.weatherForAdding = weather
                default:
                    self.view.backgroundColor = .systemGray6
                    alertController.title = "Ошибка"
                    alertController.message = "Неправильрый код статуса ответа сервера"
                    self.changeTheMainView(view: UIView())
                    self.addButton.isHidden = true
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
