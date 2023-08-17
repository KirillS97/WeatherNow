//
//  SearchView.swift
//  WeatherNow
//
//  Created by Kirill on 16.08.2023.
//

import UIKit

class SearchView: UIView {
    
    
    
    // MARK: - Свойства объектов класса
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
            var searchTextField: UITextField!
    private var searchButton: UIButton!
    private var searchStackView: UIStackView!
    private var mainView = UIView()
    private var addButton: UIButton!
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Настройка SearchView
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpSearchView(searchButtonTarger: Any,
                                 searchButtonAction: Selector,
                                 addButtonTarger: Any,
                                 addButtonAction: Selector,
                                 keyboardDoneButtonTarger: Any,
                                 keyboardDoneButtonAction: Selector) {
        self.setUpSearchTextField()
        self.setUpSearchButton(searchButtonTarger: searchButtonTarger, searchButtonAction: searchButtonAction)
        self.setUpSearchStackView()
        self.setUpAddButton(addButtonTarger: addButtonTarger, addButtonAction: addButtonAction)
        self.setUpMainView()
        
        // Настройка цвета
        self.backgroundColor = .systemGray6
        
        // Настройка панели инструментов для input view (клавиатуры)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let emptyButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let keyboardButtonDone = UIBarButtonItem(title: "Готово",
                                                  style: .done,
                                                  target: keyboardDoneButtonTarger,
                                                  action: keyboardDoneButtonAction)
        toolbar.setItems([emptyButton, keyboardButtonDone], animated: false)
        self.searchTextField.inputAccessoryView = toolbar
    }
    
    func updateColor() -> Void {
        self.backgroundColor = self.mainView.backgroundColor
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
    private func setUpSearchButton(searchButtonTarger: Any, searchButtonAction: Selector) -> Void {
        self.searchButton = UIButton()
        self.searchButton.setImage(UIImage(systemName: "magnifyingglass")?.withTintColor(.black) ?? UIImage(),
                                   for: .normal)
        self.searchButton.setImage(UIImage(systemName: "magnifyingglass")?.withTintColor(.systemGray3) ?? UIImage(),
                                   for: .normal)
        self.searchButton.snp.contentCompressionResistanceHorizontalPriority = 250
        self.searchButton.addTarget(searchButtonTarger, action: searchButtonAction, for: .touchUpInside)
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Настройка searchStackView
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpSearchStackView() -> Void {
        self.searchStackView = UIStackView(arrangedSubviews: [self.searchTextField, self.searchButton])
        self.addSubview(self.searchStackView)
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
            make.leading.top.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Настройка вью, отображающего погоду
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpMainView() {
        self.addSubview(self.mainView)
        self.addConstraintsToMainView()
    }
    
    private func addConstraintsToMainView() -> Void {
        self.mainView.snp.makeConstraints { make in
            make.top.equalTo(self.searchStackView.snp.bottom).offset(50)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.addButton.snp.top).offset(-25)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для изменения вью, отображающего погоду
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    func changeTheMainView(view: UIView) -> Void {
        self.mainView.removeFromSuperview()
        self.mainView = view
        self.setUpMainView()
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    

    
    // MARK: - Настройка кнопки Добавить
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpAddButton(addButtonTarger: Any?, addButtonAction: Selector) -> Void {
        self.addButton = UIButton()
        self.addSubview(self.addButton)
        self.addButton.setTitle("Добавить", for: .normal)
        self.addButton.setTitleColor(.black, for: .normal)
        self.addButton.setTitleColor(.systemGray3, for: .highlighted)
        self.addButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        self.addButton.backgroundColor = .white
        self.addButton.layer.cornerRadius = 25
        self.addButton.addTarget(addButtonTarger, action:addButtonAction, for: .touchUpInside)
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
    
    func hideAddButton(isHidden: Bool) -> Void {
        self.addButton.isHidden = isHidden
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Инициализаторы
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    init(searchButtonTarger: Any,
         searchButtonAction: Selector,
         addButtonTarger: Any,
         addButtonAction: Selector,
         keyboardDoneButtonTarger: Any,
         keyboardDoneButtonAction: Selector) {
        super.init(frame: CGRect.zero)
        self.setUpSearchView(searchButtonTarger: searchButtonTarger,
                             searchButtonAction: searchButtonAction,
                             addButtonTarger: addButtonTarger,
                             addButtonAction: addButtonAction,
                             keyboardDoneButtonTarger: keyboardDoneButtonTarger,
                             keyboardDoneButtonAction: keyboardDoneButtonAction)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
}
