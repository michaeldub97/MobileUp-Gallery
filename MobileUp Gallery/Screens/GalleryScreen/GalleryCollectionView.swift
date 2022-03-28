//
//  GalleryCollectionView.swift
//  MobileUp Gallery
//
//  Created by Михаил on 25.03.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class GalleryCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var authService = AuthService()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Mobile Up Gallery"
        
        
        collectionView?.backgroundColor = .white
        
        self.collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        setupNavBarButton()

    }
    
    func setupNavBarButton() {
        
        let exitBarButtonItem = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(handleExit))
        
        navigationItem.rightBarButtonItems = [exitBarButtonItem]
    }
    
    @objc func handleExit() {
        authService.logout()
        let vc = AuthorizationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = collectionView.bounds.size.width - 2
        let width = collectionWidth/2
        let imageAspectRatio: CGFloat = 400/400
        let height = width * imageAspectRatio
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}


