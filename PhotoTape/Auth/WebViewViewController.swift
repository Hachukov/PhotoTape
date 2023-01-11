//
//  WebViewViewController.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 11.01.2023.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController{
    
    
    private let backwardButton: UIButton = {
        let backwardButton = UIButton()
        backwardButton.setImage(UIImage(named: "Backward"), for: .normal)
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
        let myURL = URL(string: "https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        wVCWebView.load(myRequest)
        addConstraints()
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append( wVCWebView.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append( wVCWebView.leftAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor))
        constraints.append( wVCWebView.bottomAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append( wVCWebView.rightAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor))
        
        
        constraints.append(backwardButton.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 59))
        constraints.append(backwardButton.leftAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16))
        constraints.append(backwardButton.heightAnchor
            .constraint(equalToConstant: 15.59))
        constraints.append(backwardButton.widthAnchor
            .constraint(equalToConstant: 8.97))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func didTapBackButton() {
        dismiss(animated: true)
    }
}
