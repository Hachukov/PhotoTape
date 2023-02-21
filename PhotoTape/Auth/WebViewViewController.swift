//
//  WebViewViewController.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 11.01.2023.
//

import UIKit
import WebKit

final class WebViewViewController: UIViewController{
    
    //MARK: - Properties
    static let shared = WebViewViewController()
    private let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    private var estimatedProgressObservation: NSKeyValueObservation?
    weak var delegate: WebViewViewControllerDelegate?
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .ypBlack
        progressView.backgroundColor = .white
        progressView.progress = 0.0
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
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(wVCWebView)
        view.addSubview(backwardButton)
        view.addSubview(progressView)
        
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
        
        estimatedProgressObservation = wVCWebView.observe(\.estimatedProgress,
                                                           changeHandler: { [weak self] _, _ in
            guard let self = self else { return }
            self.updateProgress()
        })
        
        wVCWebView.load(request)
        addConstraints()
    }
    
    // MARK: - Methods
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
  
        constraints.append(wVCWebView.widthAnchor.constraint(equalTo: view.widthAnchor))
        constraints.append(wVCWebView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(wVCWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
        constraints.append(backwardButton.topAnchor
            .constraint(equalTo: view.topAnchor, constant: 33))
        constraints.append(backwardButton.leftAnchor
            .constraint(equalTo: view.leftAnchor, constant: 16))
        constraints.append(backwardButton.heightAnchor
            .constraint(equalToConstant: 44))
        constraints.append(backwardButton.widthAnchor
            .constraint(equalToConstant: 44))
        
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
    // MARK: - Methods
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
}

// реализация технологии KVO для отслеживание прогресса загрузки webView
extension WebViewViewController {

    private func updateProgress() {
        progressView.setProgress(Float(wVCWebView.estimatedProgress), animated: true)
        progressView.isHidden = fabs(wVCWebView.estimatedProgress - 1.0) <= 0.0001
    }
}
