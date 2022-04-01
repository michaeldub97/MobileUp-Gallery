//
//  ViewController.swift
//  MobileUp Gallery
//
//  Created by Михаил on 25.03.2022.
//

import UIKit

class AuthorizationViewController: UIViewController {

    private let authService: AuthService = .shared
    private let rootView = AuthorizationView()
    
    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService.delegate = self
        rootView.buttonInput.addTarget(self,
                                       action: #selector(handlePresenting),
                                       for: .touchUpInside)
    }
    
    @objc func handlePresenting() {
        authService.openAuth()
    }
}

extension AuthorizationViewController: AuthServiceDelegate {
    func authServiceShouldShow(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    func authServiceSignIn() {
        let navVC = UINavigationController(rootViewController: GalleryCollectionViewController())
        UIApplication.shared.windows.first?.rootViewController = navVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    func authServiceDidSignInFail() {
        showErrorAlert(title: "Ошибка авторизации", message: "Плохое соединение с интернетом") { [weak self] in
            guard let self = self else { return }
            self.handlePresenting()
        }
    }
}
