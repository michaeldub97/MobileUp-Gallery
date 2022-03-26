//
//  PhotoCell.swift
//  MobileUp Gallery
//
//  Created by Михаил on 25.03.2022.
//

import UIKit

class PhotoCell: BaseCell {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "user")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    
    override func setupView() {
        super.setupView()
        
        addSubview(imageView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
        
        
    }
}
