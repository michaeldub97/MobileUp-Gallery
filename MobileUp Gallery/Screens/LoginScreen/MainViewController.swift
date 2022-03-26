//
//  ViewController.swift
//  MobileUp Gallery
//
//  Created by Михаил on 25.03.2022.
//

import UIKit

class MainViewController: UIViewController {

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
        button.addTarget(self,
                         action: #selector(handlePresenting),
                         for: .touchUpInside)

        return button
    }()
    
    @objc func handlePresenting() {
        let vc = GalleryCollectionView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(buttonInput)
        setupButtonInput()
        setupTitleLabel()
        
    }
    
    func setupButtonInput() {
        
        buttonInput.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: buttonInput)
        view.addConstraint(NSLayoutConstraint(item: buttonInput, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -50))
        view.addConstraint(NSLayoutConstraint(item: buttonInput, attribute: .height, relatedBy: .equal, toItem: buttonInput, attribute: .height, multiplier: 0, constant: 50))
    }
    
    func setupTitleLabel() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: titleLabel)
        view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 164))
    }
    
    
}

