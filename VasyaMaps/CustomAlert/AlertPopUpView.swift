//
//  AlertPopUpView.swift
//  VasyaMaps
//
//  Created by Артем Василенко on 12.11.2020.
//

import UIKit
import SwiftEntryKit

class AlertPopUpView: UIView {
    
    private let message: EKPopUpMessage
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let button = UIButton()
    private let imageView = UIImageView()
    private let buttonDelete = UIButton()
     
    init(with message: EKPopUpMessage) {
        self.message = message
        super.init(frame: UIScreen.main.bounds)
        
        setupElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AlertPopUpView {
    
    func setupElements() {
        titleLabel.content = message.title
        descriptionLabel.content = message.description
        button.buttonContent = message.button
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        message.action()
        
    
    }
    
}


extension AlertPopUpView {
    
    func setupConstraints() {
        addSubview(imageView)
        imageView.layoutToSuperview(.centerX)
        imageView.layoutToSuperview(.top, offset: 40)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
        
        addSubview(descriptionLabel)
        descriptionLabel.layoutToSuperview(axis: .horizontally, offset: 30)
        descriptionLabel.layout(.top, to: .bottom, of: titleLabel, offset: 16)
        descriptionLabel.forceContentWrap(.vertically)
        
        addSubview(button)
        let height: CGFloat = 45
        button.set(.height, of: height)
        button.layout(.top, to: .bottom, of: descriptionLabel, offset: 30)
        button.layoutToSuperview(.bottom, offset: -30)
        button.layoutToSuperview(.left, offset: 20)
        
        let buttonAttributes = message.button
        button.buttonContent = buttonAttributes
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        button.layer.cornerRadius = height * 0.5
    }
    
}
