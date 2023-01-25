//
//  WebViewViewController.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 11.01.2023.
//

import UIKit
import WebKit

final class WebViewViewController: UIViewController{
    
    private let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    
    weak var delegate: WebViewViewControllerDelegate?
    
    private let progressView: UIProgressView = {
       let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .ypBlack
        progressView.progress = 0.5
        return progressView
    }()
    
    private let backwardButton: UIButton = {
        let backwardButton = UIButton()
        backwardButton.setImage(UIImage(named: "Backward")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backwardButton.translatesAutoresizingMaskIntoConstraints = false
        backwardButton.tintColor = .ypBlack
        backwardButton.addTarget(nil, action: #selector(didTapBackButton), for: .touchUpInside)
        return backwardButton
    }()
    
    private let wVCWebView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(wVCWebView)
        view.addSubview(backwardButton)
        view.addSubview(progressView)
        print(UserDefaults.standard.string(forKey: "oAuth2Token") ?? "Что-то такое ")
        
        wVCWebView.navigationDelegate = self
        
        var urlComponents = URLComponents(string: unsplashAuthorizeURLString)!
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: accessKey),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: accessScope)
        ]
        let url = urlComponents.url!
        
        let request = URLRequest(url: url)
        
        wVCWebView.load(request)
        addConstraints()
    }

    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append( wVCWebView.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 33))
        constraints.append( wVCWebView.leftAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor))
        constraints.append( wVCWebView.bottomAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append( wVCWebView.rightAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor))
        
        
        constraints.append(backwardButton.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 33))
        constraints.append(backwardButton.leftAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16))
        constraints.append(backwardButton.heightAnchor
            .constraint(equalToConstant: 15.59))
        constraints.append(backwardButton.widthAnchor
            .constraint(equalToConstant: 8.97))
        
        constraints.append(progressView.topAnchor
            .constraint(equalTo: backwardButton.bottomAnchor))
        constraints.append(progressView.leadingAnchor
            .constraint(equalTo: view.leadingAnchor))
        constraints.append(progressView.trailingAnchor
            .constraint(equalTo: view.trailingAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func didTapBackButton() {
       
        delegate?.webViewViewControllerDidCancel(self)
    }
    

}
// реализация метода WKNavigationDelegate
extension WebViewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let code = code(from: navigationAction) {
            delegate?.webViewViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}

// реализация технологии KVO для отслеживание прогресса загрузки webView
extension WebViewViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        wVCWebView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.estimatedProgress),
            options: .new,
            context: nil)
        updateProgress()
    }
    
    

    // получаем значение code из навигационного действия navigationAction URL
    private func code(from navigationAction: WKNavigationAction) -> String? {
        if
            let url = navigationAction.request.url,
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == "/oauth/authorize/native",
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == "code" })
                
        {
            return codeItem.value
        } else {
            return nil
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        wVCWebView.removeObserver(self,
                                  forKeyPath: #keyPath(WKWebView.estimatedProgress),
                                  context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            updateProgress()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    private func updateProgress() {
        progressView.progress = Float(wVCWebView.estimatedProgress)
        progressView.isHidden = fabs(wVCWebView.estimatedProgress - 1.0) <= 0.0001
    }
    
}
