//
//  AuthorizationView.swift
//  MobileUp Gallery
//
//  Created by Михаил on 31.03.2022.
//

import UIKit

class AuthorizationView: BaseView {
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Mobile Up Gallery"
        label.font = UIFont.systemFont(ofSize: 48)
        label.numberOfLines = 0
        
        return label
    }()
    
    let buttonInput: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.setTitle("Вход через VK", for: .normal)
        return button
    }()
    
    override func setupViewHierarchy() {
        addSubview(titleLabel)
        addSubview(buttonInput)
    }
    
    override func setupConstraints() {
        setupTitle()
        setupButton()
    }
    
    
    override func didSetupView() {
        backgroundColor = .white
    }

    func setupButton() {
        buttonInput.translatesAutoresizingMaskIntoConstraints = false
        addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: buttonInput)
        addConstraint(NSLayoutConstraint(item: buttonInput, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -50))
        addConstraint(NSLayoutConstraint(item: buttonInput, attribute: .height, relatedBy: .equal, toItem: buttonInput, attribute: .height, multiplier: 0, constant: 50))
    }
    
    func setupTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: titleLabel)
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 164))
    }
}
