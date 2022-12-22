//
//  ProfileViewController.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 05.12.2022.
//

import UIKit

class ProfileViewController: UIViewController {
  
    private let profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.image = UIImage(named: "Photo")
        
        return profileImage
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = .ypWhite
        return nameLabel
    }()
    
    private let mailLabel: UILabel = {
        let mailLabel = UILabel()
        mailLabel.translatesAutoresizingMaskIntoConstraints = false
        mailLabel.text = "@ekaterina_nov"
        mailLabel.textColor = .ypGray
        mailLabel.font = UIFont(name: "YS Display-Medium", size: 13)
        return mailLabel
    }()

    private let logoutButton: UIButton = {
        let logoutButton = UIButton()
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setImage(UIImage(systemName: "ipad.and.arrow.forward"), for: .normal) 
        logoutButton.tintColor = .ypRed
        return logoutButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(mailLabel)
        view.addSubview(logoutButton)
        
        addConstraints()
        
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        // Установка констрейнтов
        constraints.append(profileImage.heightAnchor.constraint(equalToConstant: 70))
        constraints.append(profileImage.widthAnchor.constraint(equalToConstant: 70))
        constraints.append(profileImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                                 constant: 16))
        constraints.append(profileImage.topAnchor.constraint(equalTo: view.topAnchor,
                                                             constant: 76))
        
        constraints.append(nameLabel.heightAnchor.constraint(equalToConstant: 23))
        constraints.append(nameLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor))
        constraints.append(nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8))
        
        constraints.append(mailLabel.heightAnchor.constraint(equalToConstant: 18))
        constraints.append(mailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor))
        constraints.append(mailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8))
        
        constraints.append(logoutButton.heightAnchor.constraint(equalToConstant: 22))
        constraints.append(logoutButton.widthAnchor.constraint(equalToConstant: 20))
        constraints.append(logoutButton.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor))
        constraints.append(logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26))
        
        // Астивируем констрэинты
        NSLayoutConstraint.activate(constraints)
    }
}
