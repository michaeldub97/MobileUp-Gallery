//
//  DetailViewController.swift
//  MobileUp Gallery
//
//  Created by Михаил on 25.03.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    let rootView = DetailView()
    
    override func loadView() {
        view = rootView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.detailImage.image = UIImage(named: "user")
        navigationItem.title = "Дата"

        
        setupNavBarButton()
    }
   
    private func setupNavBarButton() {
        
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(handleSave))
        
        navigationItem.rightBarButtonItems = [saveBarButtonItem]
    }
    @objc func handleSave() {
        print(321)
    }
    
}
