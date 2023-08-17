//
//  MainView.swift
//  WeatherNow
//
//  Created by Kirill on 16.08.2023.
//

import UIKit

class MainView: UIView {
    
    
    
    // MARK: - Свойства объектов класса
    /* - - - - - - - - - - - - - - - - - - */
    private var toolBar: ToolBar!
            var mainCollectionView: MainCollectionView!
    private var noticeLabel: UILabel!
    
    private let defaultColor = UIColor.systemGray
    /* - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Настройка MainView
    /* - - - - - - - - - - - - - - - - - - */
    func setUpMainView(toolbarHandlerTarger: Any?,
                       toolbarHandlerSelector: Selector,
                       mainCollectionViewDataSource: UICollectionViewDataSource,
                       mainCollectionViewDelegate: UICollectionViewDelegate) -> Void {
        self.setUpDefaultColor()
        self.setUpToolBar(toolbarHandlerTarger: toolbarHandlerTarger, toolbarHandlerSelector: toolbarHandlerSelector)
        self.setUpMainCollectionView(mainCollectionViewDataSource: mainCollectionViewDataSource,
                                     mainCollectionViewDelegate: mainCollectionViewDelegate)
        self.setUpNoticeLabel()
    }
    /* - - - - - - - - - - - - - - - - - - */
    
    
    
    
    // MARK: Установка цвета корневого UIView
    /* - - - - - - - - - - - - - - - - - - */
    func setUpDefaultColor() -> Void {
        self.backgroundColor = self.defaultColor
    }
    
    func updateColor() -> Void {
        self.backgroundColor = self.mainCollectionView.backgroundColor
    }
    /* - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Настройка ToolBar
    /* - - - - - - - - - - - - - - - - - - */
    private func setUpToolBar(toolbarHandlerTarger: Any?, toolbarHandlerSelector: Selector) -> Void {
        self.toolBar = ToolBar(targerForListButtonHandler: toolbarHandlerTarger, handler: toolbarHandlerSelector)
        self.addSubview(self.toolBar)
        self.addConstraintsToToolBar()
    }
    
    // Установка ограничений панели инструментов
    private func addConstraintsToToolBar() {
        self.toolBar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
    /* - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Настройка UICollectionView
    /* - - - - - - - - - - - - - - - - - - */
    private func setUpMainCollectionView(mainCollectionViewDataSource: UICollectionViewDataSource,
                                         mainCollectionViewDelegate: UICollectionViewDelegate) -> Void {
        self.mainCollectionView = MainCollectionView(frame: CGRect.zero)
        self.addSubview(self.mainCollectionView)
        self.addConstraintsToMainCollectionView()
        self.mainCollectionView.dataSource = mainCollectionViewDataSource
        self.mainCollectionView.delegate   = mainCollectionViewDelegate
    }
    
    // Установка ограничений коллекции MainCollectionView
    private func addConstraintsToMainCollectionView() -> Void {
        self.mainCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.top.equalToSuperview()
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.toolBar.snp.top)
        }
    }
    
    func updateMailCollectionView() -> Void {
        self.mainCollectionView.reloadData()
    }
    
    func updateMainCollectionViewColor() -> Void {
        self.mainCollectionView.updateColor()
    }
    /* - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: - Настройка уведомительной метки
    /* - - - - - - - - - - - - - - - - - - */
    private func setUpNoticeLabel() -> Void {
        self.noticeLabel = UILabel()
        self.addSubview(self.noticeLabel)
        self.addConstraintsToNoticeLabel()
        self.noticeLabel.text = "Список мест для определения погоды пуст. Откройте список по кнопке ниже, чтобы добавить новые места"
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
    
    // Метод для сокрытия уведомительной метки
    func hideTheNoticeLabel(isHidden: Bool) -> Void {
        self.noticeLabel.isHidden = isHidden
    }
    /* - - - - - - - - - - - - - - - - - - */
    
    
}
