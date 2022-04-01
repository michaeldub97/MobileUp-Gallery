//
//  API.swift
//  MobileUp Gallery
//
//  Created by Михаил on 26.03.2022.
//

import Foundation
import WebKit


protocol AuthServiceDelegate: class {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}


final class AuthService: NSObject {
    private let keychain = KeychainService()
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        keychain.loadPassword(serviceKey: .vk)
    }
    
    static let shared = AuthService()
    
    var authUrl: URL? {
        guard var urlComponent = URLComponents(string: "https://oauth.vk.com/authorize") else { return nil }
        let queryItems = [
            URLQueryItem(name: "client_id", value: "8116771"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "offline"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token")
        ]
        urlComponent.queryItems = queryItems
        return urlComponent.url
    }
}

extension AuthService {
    
    func openAuth() {
        let controller = AuthViewController()
        controller.delegate = self
        self.delegate?.authServiceShouldShow(controller)
    }
    
    func userAuthorized() -> Bool {
        return token != nil
    }
    
    func logOut() {
        keychain.removePassword(serviceKey: .vk)
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
            for record in records {
                if record.displayName.contains("vk.com") {
                    dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: { print("Deleted: " + record.displayName);
                    })
                }
            }
        }
    }
}

extension AuthService: AuthViewControllerDelegate {    
    func authServiceSignIn(with token: String) {
        keychain.updatePassword(token, serviceKey: .vk)
        delegate?.authServiceSignIn()
    }
}
 
