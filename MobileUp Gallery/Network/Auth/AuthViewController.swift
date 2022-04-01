//
//  AuthViewController.swift
//  MobileUp Gallery
//
//  Created by Михаил on 31.03.2022.
//

import Foundation
import UIKit
import WebKit

protocol AuthViewControllerDelegate: class {
    var authUrl: URL? { get }
    func authServiceSignIn(with token: String)
}

class AuthViewController: UIViewController {
    var webView = WKWebView()
    weak var delegate: AuthViewControllerDelegate?
    
    override func loadView() {
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        guard let url = delegate?.authUrl else {
            return
        }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}

extension AuthViewController:  WKNavigationDelegate {
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if let url = webView.url?.absoluteString {
            let tokenKey = "access_token"
            if (url.range(of: tokenKey) != nil) {
                delegate?.authServiceSignIn(with: url.fetchToken)
            }
        }
    }
}
