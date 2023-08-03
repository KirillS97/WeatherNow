//
//  ListViewController.swift
//  WeatherNow
//
//  Created by Kirill on 02.08.2023.
//

import UIKit
import SnapKit



// MARK: - ListViewController
/*===================================================================================*/
class ListViewController: UIViewController {
    
    
    
    // MARK: - Свойства объектов класса
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private let storage = Storage()
    private var cities: [String] {
        return self.storage.getCities()
    }
    private var tableView: UITableView!
    
    var closureForUpdateMainVC: (() -> Void)?
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    // MARK: - viewDidLoad
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Настройка цвета
        /* - - - - - - - - - - - - - - - - */
        self.view.backgroundColor = .systemGray6
        /* - - - - - - - - - - - - - - - - */
        
        
        
        // Настройка таблицы
        /* - - - - - - - - - - - - - - - - */
        self.setUpTableView()
        /* - - - - - - - - - - - - - - - - */
        
        
        
        // Настройка панели навигации
        /* - - - - - - - - - - - - - - - - */
        navigationItem.title = "Список мест"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(self.rightBarButtonHandler(sender:)))
        /* - - - - - - - - - - - - - - - - */
        
        
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - viewWillDisappear
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let closureForUpdateMainVC {
            closureForUpdateMainVC()
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Настройка таблицы
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpTableView() -> Void {
        self.tableView = UITableView()
        self.view.addSubview(self.tableView)
        self.addConstraintsToTableView()
        self.tableView.backgroundColor = self.view.backgroundColor
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func addConstraintsToTableView() -> Void {
        self.tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Обработчик нажатия на кнопку "Добавить" на панели навигации
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
    @objc func rightBarButtonHandler(sender: UIBarButtonItem) -> Void {
        guard sender.isEqual(self.navigationItem.rightBarButtonItem) else { return }
        let searchVC = SearchViewController()
        searchVC.closureForUpdateListVC = { () -> Void in
            self.tableView.reloadData()
        }
        searchVC.modalPresentationStyle = .formSheet
        self.present(searchVC, animated: true)
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

    
}
/*===================================================================================*/



// MARK: - Подписка класса ListViewController на UITableViewDataSource
/*===================================================================================*/
extension ListViewController: UITableViewDataSource {
    
    
    
    // Инициализация объекта, инициирующего действие удаления
    /* - - - - - - - - - - - - - */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cities.count
    }
    /* - - - - - - - - - - - - - */
    
    
    
    // Инициализация объекта, инициирующего действие удаления
    /* - - - - - - - - - - - - - */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.cities.count > indexPath.row {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            var cellConfiguration = cell.defaultContentConfiguration()
            cellConfiguration.text = self.cities[indexPath.row]
            cell.contentConfiguration = cellConfiguration
            cell.backgroundColor = self.view.backgroundColor
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    /* - - - - - - - - - - - - - */
    
}
/*===================================================================================*/



// MARK: - Подписка класса ListViewController на UITableViewDelegate
/*===================================================================================*/
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        
        // Инициализация объекта, инициирующего действие удаления
        /* - - - - - - - - - - - - - */
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (action: UIContextualAction,
                                                                                        view: UIView,
                                                                                        bool: @escaping (Bool) -> Void) -> Void  in
            // Удаление города из хранилища
            self.storage.removeCity(cityName: self.cities[indexPath.row])
            
            // Обновление таблицы
            self.tableView.reloadData()
        }
        /* - - - - - - - - - - - - - */
        
        
        
        // Инициализация объекта, инициирующего действие удаления
        /* - - - - - - - - - - - - - */
        let actionsObject = UISwipeActionsConfiguration(actions: [deleteAction])
        /* - - - - - - - - - - - - - */
        
        
        
        // Возврат объекта, содержащего инициируемые действия
        /* - - - - - - - - - - - - - */
        return actionsObject
        /* - - - - - - - - - - - - - */
        
        
    }
}
/*===================================================================================*/
