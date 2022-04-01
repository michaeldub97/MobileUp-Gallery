//
//  Extensions.swift
//  MobileUp Gallery
//
//  Created by Михаил on 25.03.2022.
//

import UIKit
import Kingfisher

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

extension UIImageView {
    func loadImage(_ urlString: String) {
        let url = URL(string: urlString)
        loadImage(url: url)
    }
    
    func loadImage(url: URL?) {
        var kf = self.kf
        kf.indicatorType = .activity
        kf.setImage(with: url, options: [.transition(.fade(0.2))])
    }
}

extension Int {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .long

        return dateFormatter.string(from: date)
    }
}

public extension FileManager {
    func temporaryJPG(fileName: String = UUID().uuidString) -> URL? {
        return URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent(fileName).appendingPathExtension("jpg")
    }
}

extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
}

extension UIViewController {
    func showErrorAlert(title: String, message: String, retryAction: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Обновить", style: .default, handler: { action in
            retryAction()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true, completion: nil)
    }
}

extension String {
    var fetchToken: String {
        let splitStrInHalf = self.components(separatedBy: "%253D")
        let separateStryngBy = splitStrInHalf[1].split(separator: "%").dropLast()
        return separateStryngBy.first?.description ?? ""
    }
}

extension UIViewController {
    func setBackButton() {
        let backIcon = UIImage(named: "chevronLeft")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = backIcon
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backIcon
        navigationController?.navigationBar.topItem?.title = " "
    }
}
