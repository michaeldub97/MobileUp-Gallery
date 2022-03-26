//
//  Extensions.swift
//  MobileUp Gallery
//
//  Created by Михаил on 25.03.2022.
//

import UIKit

extension UIView {
    
    func addConstraintsWithFormat(format : String , views : UIView...) {
        var viewDictionary = [String: UIView]()
        for (index,view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictionary))
    }
}
