//
//  GalleryCollectionView.swift
//  MobileUp Gallery
//
//  Created by Михаил on 25.03.2022.
//

import UIKit

class GalleryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var auth = AuthService.shared
    private let reuseIdentifier = "Cell"
    
    private var provider = NetworkImageManager()
    private var images : [Information] = []
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView?.backgroundColor = .white
        collectionView?.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        setupNavBarButton()
        loadImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Mobile Up Gallery"
    }
    
    func loadImage()  {
        provider.fetchImages { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let images):
                    self.images = images
                    self.collectionView.reloadData()
                case .failure(_):
                    self.showErrorAlert(title: "Ошибка", message: "Не удалось загрузить данные") { [weak self] in
                        guard let self = self else { return }
                        self.loadImage()
                    }
                }
            }
        }
    }

    func setupNavBarButton() {
        let exitBarButtonItem = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(handleExit))
        exitBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItems = [exitBarButtonItem]
    }
    
    @objc func handleExit() {
        auth.logOut()
        let vc = AuthorizationViewController()
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        let data = images[indexPath.row]
        let previewUrl = data.previewImageUrl
        cell.imageView.loadImage(url: previewUrl)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let image = images[indexPath.row]
        vc.imageInfo = image
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = collectionView.bounds.size.width - 2
        let width = collectionWidth/2
        return CGSize(width: width, height: width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
