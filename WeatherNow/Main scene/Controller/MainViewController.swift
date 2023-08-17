//
//  ViewController.swift
//  WeatherNow
//
//  Created by Kirill on 29.07.2023.
//

import UIKit



// MARK: - MainViewController
/*===================================================================================*/
class MainViewController: UIViewController {
    
    
    
    // MARK: - Свойства объектов класса
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private let networkManager = NetwokManager.shared
    private let urlCreator     = URLCreator.shared
    private let storage        = Storage.shared
    
    private var cities: [String] { self.storage.getCities() }
    private var citiesWhetherArray: [Weather] = []
    
    private var mainView: MainView!
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - loadView
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    override func loadView() {
        super.loadView()
        self.mainView = MainView()
        self.mainView.setUpMainView(toolbarHandlerTarger: self,
                                    toolbarHandlerSelector: #selector(self.interactionToolBarHandler),
                                    mainCollectionViewDataSource: self,
                                    mainCollectionViewDelegate: self)
        self.view = mainView
        self.hideTheNoticeLabel()
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - viewDidLoad
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка панели навигации
        self.navigationItem.backButtonTitle = "Назад"
        self.fetchWeather()
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для сокрытия уведомительной метки
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func hideTheNoticeLabel() -> Void {
        self.mainView.hideTheNoticeLabel(isHidden: !self.cities.isEmpty)
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод-обработчик в/д пользователя с панелью инструментов
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    @objc func interactionToolBarHandler() -> Void {
        if let navigationController {
            let listVC = ListViewController()
            listVC.closureForUpdateMainVC = { () -> Void in
                self.fetchWeather()
                self.mainView.updateMailCollectionView()
                self.mainView.updateMainCollectionViewColor()
                self.mainView.updateColor()
                self.hideTheNoticeLabel()
            }
            navigationController.pushViewController(listVC, animated: true)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для отправки запроса на сервер и обработки ответа
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    func fetchWeather() -> Void {
        self.citiesWhetherArray = []
        for i in 0..<self.cities.count {
            let url = urlCreator.getURL(cityName: self.cities[i])
            self.networkManager.fetchData(url: url, completionHandler: { (result: Result<Weather, NetworkError>) in
                switch result {
                case .success(let weather):
                    self.citiesWhetherArray.append(weather)
                case .failure(_):
                    print("Error")
                }
                self.mainView.mainCollectionView.reloadData()
            })
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
}
/*===================================================================================*/



// MARK: - Подписка MainViewController на протокол UICollectionViewDataSource
/*===================================================================================*/
extension MainViewController: UICollectionViewDataSource {
    
    
    
    // MARK: Определение количества элементов коллекции
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cities.count
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Возврат ячейки для коллекции
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.mainView.mainCollectionView.dequeueReusableCell(withReuseIdentifier: WeatherAtTheLocationCell.reuseId,
                                                                  for: indexPath) as? WeatherAtTheLocationCell {
            if self.citiesWhetherArray.indices.contains(indexPath.item) {
                cell.setUpView(weather: self.citiesWhetherArray[indexPath.item])
            }
            return cell
        }
        return UICollectionViewCell()
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
}
/*===================================================================================*/



// MARK: - Подписка MainViewController на протокол UICollectionViewDelegate
/*===================================================================================*/
extension MainViewController: UICollectionViewDelegate {
    
    // MARK: Оба следующих метода используются для анимации изменения цвета корневого вью. Если один из них удалить, то периодически цвет может не изменяться
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? WeatherAtTheLocationCell {
            UIView.animate(withDuration: 0.4) {
                self.view.backgroundColor = cell.weatherView.backgroundColor
                self.mainView.mainCollectionView.backgroundColor = cell.weatherView.backgroundColor
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleCells = self.mainView.mainCollectionView.visibleCells
        if !visibleCells.isEmpty {
            if let visibleCell = visibleCells[0] as? WeatherAtTheLocationCell {
                UIView.animate(withDuration: 0.4) {
                    self.view.backgroundColor = visibleCell.weatherView.backgroundColor
                    self.mainView.mainCollectionView.backgroundColor = visibleCell.weatherView.backgroundColor
                }
            }

        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
}
/*===================================================================================*/



// MARK: - Подписка MainViewController на протокол UICollectionViewDelegateFlowLayout
/*===================================================================================*/
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.mainView.mainCollectionView.frame.size
    }
}
/*===================================================================================*/
