//
//  DetailView.swift
//  MobileUp Gallery
//
//  Created by Михаил on 25.03.2022.
//

import UIKit

class DetailView: BaseView {
    
    let detailImage: UIImageView = {
        let detailImage = UIImageView()
        detailImage.backgroundColor = .lightGray
        detailImage.contentMode = .scaleAspectFill
        detailImage.clipsToBounds = true
        return detailImage
    }()
    
    override func setupViewHierarchy() {
        addSubview(detailImage)
    }
    
    override func didSetupView() {

        backgroundColor = .white
    }
    override func setupConstraints() {
        addConstraintsWithFormat(format: "H:|[v0]|", views: detailImage)
        addConstraint(NSLayoutConstraint(item: detailImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: detailImage, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0))
        
    }

}

