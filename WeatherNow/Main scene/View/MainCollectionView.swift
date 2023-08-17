//
//  MainCollectionView.swift
//  WeatherNow
//
//  Created by Kirill on 01.08.2023.
//

import UIKit

class MainCollectionView: UICollectionView {
    
    private var customizedFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = flowLayout.minimumLineSpacing
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    private func setUpMainCollectionView() -> Void {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true
        self.register(WeatherAtTheLocationCell.self, forCellWithReuseIdentifier: WeatherAtTheLocationCell.reuseId)
        self.updateColor()
    }
    
    func updateColor() -> Void {
        if self.visibleCells.isEmpty {
            self.backgroundColor = .systemGray
        }
    }
    
    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: self.customizedFlowLayout)
        self.setUpMainCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
