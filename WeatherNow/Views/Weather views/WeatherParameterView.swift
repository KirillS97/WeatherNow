//
//  WeatherParameterCell.swift
//  WeatherNow
//
//  Created by Kirill on 31.07.2023.
//

import UIKit
import SnapKit

class WeatherParameterView: UIView {
    
    
    
    // MARK: Свойства объекта
    /* - - - - - - - - - - - - - - - - - - - - - - - */
    private let fontSize            : CGFloat = 18
    private let imageViewSize       : CGFloat = 25
    private var parameterImageView  : UIImageView!
    private var parameterNameLabel  : UILabel!
    private var parameterValueLabel : UILabel!
    /* - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка WeatherParameterView
    /* - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpSelf() -> Void {
        self.setUpParameterImageView()
        self.setUpParameterNameLabel()
        self.setUpParameterValueLabel()
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка parameterImageView
    /* - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpParameterImageView() -> Void {
        self.parameterImageView = UIImageView()
        self.contentMode = .scaleAspectFit
        self.addSubview(self.parameterImageView)
        self.addConstraintsToParameterImageView()
    }
    
    private func addConstraintsToParameterImageView() -> Void {
        self.parameterImageView.snp.makeConstraints { make in
            make.width.equalTo(self.imageViewSize)
            make.height.equalTo(self.imageViewSize)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    private func setImageToParameterImageView(image: UIImage) -> Void {
        self.parameterImageView.image = image.withTintColor(.white)
    }
    
    func setImage(image: UIImage) -> Void {
        self.setImageToParameterImageView(image: image)
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка parameterNameLabel
    /* - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpParameterNameLabel() -> Void {
        self.parameterNameLabel = UILabel()
        self.parameterNameLabel.textAlignment = .left
        self.parameterNameLabel.numberOfLines = 0
        self.parameterNameLabel.textColor = .white
        self.parameterNameLabel.font = .systemFont(ofSize: self.fontSize, weight: .light)
        self.parameterNameLabel.text = ""
        self.addSubview(self.parameterNameLabel)
        self.addConstraintsToParameterNameLabel()
    }
    
    private func addConstraintsToParameterNameLabel() -> Void {
        self.parameterNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.parameterImageView.snp.centerY)
            make.leading.equalTo(self.parameterImageView.snp.trailing).offset(10)
            //make.width.equalToSuperview().dividedBy(1.7)
            make.top.equalToSuperview()
        }
        self.parameterNameLabel.snp.contentHuggingHorizontalPriority = 249
    }
    
    private func setTextToParameterNameLabel(parameter: String) -> Void {
        self.parameterNameLabel.text = parameter
    }
    
    func setParameter(parameter: String) -> Void {
        self.setTextToParameterNameLabel(parameter: parameter)
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Настройка parameterValueLabel
    /* - - - - - - - - - - - - - - - - - - - - - - - */
    private func setUpParameterValueLabel() -> Void {
        self.parameterValueLabel = UILabel()
        self.parameterValueLabel.textAlignment = .left
        self.parameterValueLabel.numberOfLines = 1
        self.parameterValueLabel.textColor = .white
        self.parameterValueLabel.font = .systemFont(ofSize: self.fontSize, weight: .light)
        self.parameterValueLabel.text = ""
        self.addSubview(self.parameterValueLabel)
        self.addConstraintsToParameterValueLabel()
    }
    
    private func addConstraintsToParameterValueLabel() -> Void {
        self.parameterValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.parameterNameLabel.snp.centerY)
            make.leading.equalTo(self.parameterNameLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
        }
        self.parameterValueLabel.snp.contentHuggingHorizontalPriority = 250
    }
    
    private func setTextToParameterValueLabel(parameterValue: String) -> Void {
        self.parameterValueLabel.text = parameterValue
    }
    
    func setParameterValue(value: String) -> Void {
        self.setTextToParameterValueLabel(parameterValue: value)
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - */
    
    
    
    // MARK: Инициализаторы
    /* - - - - - - - - - - - - - - - - - - - - - - - */
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(image: UIImage, parameter: String, parameterValue: String) {
        super.init(frame: CGRect.zero)
        self.setUpSelf()
        self.setImageToParameterImageView(image: image)
        self.setTextToParameterNameLabel(parameter: parameter)
        self.setTextToParameterValueLabel(parameterValue: parameterValue)
    }
    /* - - - - - - - - - - - - - - - - - - - - - - - */
    
    
}
