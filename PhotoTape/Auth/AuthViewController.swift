//
//  AuthViewController.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 10.01.2023.
//

import UIKit

class AuthViewController: UIViewController {
    //MARK: - Propeties
    //let segueIdForWebView = "ShowWebView"
    
    weak var delegate: AuthViewControllerDelegate?
    let webWiewController = WebViewViewController.shared
    
    private let unsplashLogo: UIImageView = {
        let unsplashLogo = UIImageView()
        unsplashLogo.translatesAutoresizingMaskIntoConstraints = false
        unsplashLogo.image = UIImage(named: "logoUnsplash")
        return unsplashLogo
    }()
    
    private let  loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Войти", for: .normal)
        loginButton.backgroundColor = .ypWhite
        loginButton.setTitleColor(UIColor.ypBlack, for: .normal)
        loginButton.layer.cornerRadius = 16
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(nil,
                              action: #selector(presentWebView),
                              for: .touchUpInside)
        
        return loginButton
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(unsplashLogo)
        view.addSubview(loginButton)
        addConstraints()
    }
        
    // MARK: - Methods
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(unsplashLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor ))
        constraints.append(unsplashLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(unsplashLogo.heightAnchor.constraint(equalToConstant: 60))
        constraints.append(unsplashLogo.widthAnchor.constraint(equalToConstant: 60))
        
        constraints.append(loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -124))
        constraints.append(loginButton.heightAnchor.constraint(equalToConstant: 48))
        constraints.append(loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16))
        constraints.append(loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func presentWebView() {
        webWiewController.modalPresentationStyle = .fullScreen
        present(webWiewController, animated: true)
       // performSegue(withIdentifier: segueIdForWebView, sender: nil)
    }
//
//    override  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == segueIdForWebView {
//            guard let webViewController = segue.destination as? WebViewViewController
//            else { fatalError("Failed to prepare for \(segueIdForWebView)") }
//            webViewController.delegate = self
//        } else {
//            super.prepare(for: segue, sender: sender)
//        }
//    }
}

extension AuthViewController: WebViewViewControllerDelegate {
    
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        self.delegate?.authViewViewController(self, didAuthenticateWithCode: code)
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }
}
