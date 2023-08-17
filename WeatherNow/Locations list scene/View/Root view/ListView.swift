//
//  ListView.swift
//  WeatherNow
//
//  Created by Kirill on 16.08.2023.
//

import UIKit

class ListView: UIView {
    
    
    // MARK: - Свойства объектов класса
    /* - - - - - - - - - - - - - - - - */
    var tableView: UITableView! // Таблица со списком мест
    /* - - - - - - - - - - - - - - - - */
    
    
    
    private func setUpListView(tableViewDataSource: UITableViewDataSource,
                               tableViewDelegate: UITableViewDelegate) -> Void {
        self.backgroundColor = .systemGray6
        self.setUpTableView(tableViewDataSource: tableViewDataSource, tableViewDelegate: tableViewDelegate)
    }
    
    
    // MARK: - Настройка таблицы
    /* - - - - - - - - - - - - - - - - */
    private func setUpTableView(tableViewDataSource: UITableViewDataSource,
                                tableViewDelegate: UITableViewDelegate) -> Void {
        self.tableView = UITableView()
        self.addSubview(self.tableView)
        self.addConstraintsToTableView()
        self.tableView.backgroundColor = self.backgroundColor
        self.tableView.dataSource = tableViewDataSource
        self.tableView.delegate   = tableViewDelegate
    }
    
    // Установка ограничений
    private func addConstraintsToTableView() -> Void {
        self.tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
    /* - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Инициализаторы
    /* - - - - - - - - - - - - - - - - */
    init(tableViewDataSource: UITableViewDataSource, tableViewDelegate: UITableViewDelegate) {
        super.init(frame: CGRect.zero)
        self.setUpListView(tableViewDataSource: tableViewDataSource, tableViewDelegate: tableViewDelegate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /* - - - - - - - - - - - - - - - - */
    
    
}
