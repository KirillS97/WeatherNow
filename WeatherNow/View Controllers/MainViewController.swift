//
//  ViewController.swift
//  WeatherNow
//
//  Created by Kirill on 29.07.2023.
//

import UIKit
import SnapKit



// MARK: - MainViewController
/*===================================================================================*/
class MainViewController: UIViewController {
    
    
    
    // MARK: - Свойства
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private let networkManager = NetwokManager.shared
    private let urlCreator = URLCreator()
    private let storage = Storage()
    
    private var cities: [String] {
        self.storage.getCities()
    }
    
    private var toolBar: ToolBar!
    private var mainCollectionView: MainCollectionView!
    private var noticeLabel: UILabel!
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - viewDidLoad
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // MARK: Установка цвета корневого UIView
        /* - - - - - - - - - - - - - - - - - - */
        self.view.backgroundColor = .systemGray
        /* - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка ToolBar
        /* - - - - - - - - - - - - - - - - - - */
        self.toolBar = ToolBar(targerForListButtonHandler: self,
                               handler: #selector(self.interactionToolBarHandler))
        self.view.addSubview(self.toolBar)
        self.addConstraintsToToolBar()
        /* - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка UICollectionView
        /* - - - - - - - - - - - - - - - - - - */
        self.mainCollectionView = MainCollectionView(frame: CGRect.zero)
        self.view.addSubview(self.mainCollectionView)
        self.mainCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.top.equalToSuperview()
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.toolBar.snp.top)
        }
        self.mainCollectionView.dataSource = self
        self.mainCollectionView.delegate = self
        /* - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка панели навигации
        /* - - - - - - - - - - - - - - - - - - */
        self.navigationItem.backButtonTitle = "Назад"
        /* - - - - - - - - - - - - - - - - - - */
        
        
        
        // MARK: Настройка метки с уведомлением
        /* - - - - - - - - - - - - - - - - - - */
        self.setUpNoticeLabel()
        self.hideTheNoticeLabel()
        /* - - - - - - - - - - - - - - - - - - */
        
        
        
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод для установки ограничений для панели инструментов
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func addConstraintsToToolBar() {
        self.toolBar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Методы для настройки уведомительной метки
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    // Инициализация и настройка уведомительной метки
    /* - - - - - - - - - - - - - - - - - - */
    private func setUpNoticeLabel() -> Void {
        self.noticeLabel = UILabel()
        self.view.addSubview(self.noticeLabel)
        self.noticeLabel.text = "Список мест для определения погоды пуст. Откройте список по кнопке ниже, чтобы добавить новые места"
        self.noticeLabel.textColor = .white
        self.noticeLabel.numberOfLines = 0
        self.noticeLabel.textAlignment = .natural
        self.noticeLabel.font = .systemFont(ofSize: 20, weight: .light)
        self.addConstraintsToNoticeLabel()
    }
    /* - - - - - - - - - - - - - - - - - - */
    
    
    
    // Установка ограничений уведомительной метки
    /* - - - - - - - - - - - - - - - - - - */
    private func addConstraintsToNoticeLabel() -> Void {
        self.noticeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(50)
        }
    }
    /* - - - - - - - - - - - - - - - - - - */
    
    
    
    // Метод для сокрытия уведомительной метки
    /* - - - - - - - - - - - - - - - - - - */
    private func hideTheNoticeLabel() -> Void {
        if self.cities.isEmpty {
            self.noticeLabel.isHidden = false
        } else {
            self.noticeLabel.isHidden = true
        }
    }
    /* - - - - - - - - - - - - - - - - - - */
    
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Метод-обработчик в/д пользователя с панелью инструментов
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    @objc func interactionToolBarHandler() -> Void {
        if let navigationController {
            let listVC = ListViewController()
            listVC.closureForUpdateMainVC = { () -> Void in
                self.mainCollectionView.reloadData()
                self.mainCollectionView.changeColor()
                self.view.backgroundColor = self.mainCollectionView.backgroundColor
                self.hideTheNoticeLabel()
            }
            navigationController.pushViewController(listVC, animated: true)
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
        if let cell = self.mainCollectionView.dequeueReusableCell(withReuseIdentifier: WeatherAtTheLocationCell.reuseId,
                                                                  for: indexPath) as? WeatherAtTheLocationCell {
            let url = urlCreator.getURL(cityName: self.cities[indexPath.item])
            networkManager.fetchData(url: url, completionHandler: { (result: Result<Weather, NetworkError>) in
                switch result {
                case .failure(let error) where error == NetworkError.errorStatusCode(statusCode: 401):
                    print("Проверь ключ доступа к API")
                case .failure(let error) where error == NetworkError.errorStatusCode(statusCode: 404):
                    print("Такого топонима нет в базе данных. Проверь название населённого пункта")
                case .failure(let error):
                    print(error)
                case .success(let weather):
                    if let cell = self.mainCollectionView.cellForItem(at: indexPath) as? WeatherAtTheLocationCell {
                        
                        // Изменение background view ячейки
                        cell.changeView(view: getWeatherView(weather: weather))
                        if self.mainCollectionView.contentOffset.x < self.mainCollectionView.frame.width {
                            self.view.backgroundColor = cell.view.backgroundColor
                            self.mainCollectionView.backgroundColor = cell.view.backgroundColor
                        }
                    }
                }
            })
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
        print("cell \(indexPath.item) will display")
        if let cell = cell as? WeatherAtTheLocationCell {
            UIView.animate(withDuration: 0.4) {
                self.view.backgroundColor = cell.view.backgroundColor
                self.mainCollectionView.backgroundColor = cell.view.backgroundColor
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleCells = self.mainCollectionView.visibleCells
        if !visibleCells.isEmpty {
            if let visibleCell = visibleCells[0] as? WeatherAtTheLocationCell {
                UIView.animate(withDuration: 0.4) {
                    self.view.backgroundColor = visibleCell.view.backgroundColor
                    self.mainCollectionView.backgroundColor = visibleCell.view.backgroundColor
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
        return self.mainCollectionView.frame.size
    }
}
/*===================================================================================*/
