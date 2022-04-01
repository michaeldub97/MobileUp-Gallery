//
//  DetailViewController.swift
//  MobileUp Gallery
//
//  Created by Михаил on 25.03.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var imageInfo: Information?
    let rootView = DetailView()
    var docController: UIDocumentInteractionController?
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageUrl = imageInfo?.detailImageUrl
        rootView.detailImage.loadImage(url: imageUrl)
        
        let date = imageInfo?.date.getDateStringFromUTC()
        navigationItem.title = date
        setupNavBarButton()
        setBackButton()
    }
    
    private func setupNavBarButton() {
        let saveBarButtonItem = UIBarButtonItem(image: UIImage(named: "share")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action:  #selector(handleSave))
        navigationItem.rightBarButtonItems = [saveBarButtonItem]
    }
    
    @objc func handleSave() {
        guard let info = imageInfo, let downloadUrl = info.detailImageUrl,
              let localUrl = FileManager.default.temporaryJPG(fileName: info.date.getDateStringFromUTC()) else {
            return
        }
        getData(from: downloadUrl) { [weak self] data, response, error in
            if let data = data, error == nil {
                FileManager.default.createFile(atPath: localUrl.path, contents: nil, attributes: nil)
                do {
                    try data.write(to: localUrl)
                    DispatchQueue.main.async { [weak self] in
                        self?.showShare(localUrl: localUrl)
                    }
                } catch {
                    try? FileManager.default.removeItem(at: localUrl)
                }
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func showShare(localUrl: URL) {
        let avc = UIActivityViewController(activityItems: [localUrl], applicationActivities: nil)
        present(avc, animated: true, completion: nil)
    }
}
