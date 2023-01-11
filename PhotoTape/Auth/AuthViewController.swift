//
//  AuthViewController.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 10.01.2023.
//

import UIKit

class AuthViewController: UIViewController {
    
    private let unsplashLogo: UIImageView = {
        let unsplashLogo = UIImageView()
        unsplashLogo.translatesAutoresizingMaskIntoConstraints = false
        unsplashLogo.image = UIImage(named: "logoUnsplash")
        return unsplashLogo
    }()
    
    private let  loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Войти ", for: .normal)
        loginButton.backgroundColor = .ypWhite
        loginButton.setTitleColor(UIColor.ypBlack, for: .normal)
        loginButton.layer.cornerRadius = 16
        loginButton.layer.masksToBounds = true
        return loginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(unsplashLogo)
        view.addSubview(loginButton)
        
        addConstraints()
    }

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
 
}
