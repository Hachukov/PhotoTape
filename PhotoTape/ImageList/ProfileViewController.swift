//
//  ProfileViewController.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 05.12.2022.
//

import UIKit

class ProfileViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()

        let profileImage = UIImageView()
        profileImage.image = UIImage(named: "Photo")
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImage)
        profileImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                              constant: 20).isActive = true
        profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: 20).isActive = true
        
        let nameLabel = UILabel()
        nameLabel.text = "Екатерина Новикова"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        nameLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8).isActive = true
        nameLabel.textColor = .white
        
        let mailLabel = UILabel()
        mailLabel.text = "@ekaterina_nov"
        mailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mailLabel)
        mailLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        mailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        mailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        mailLabel.textColor = .ypGray
        mailLabel.font = UIFont(name: "YS Display-Medium", size: 13)
        
        let logoutImag = UIImageView()
        logoutImag.image = UIImage(systemName: "ipad.and.arrow.forward")
        logoutImag.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutImag)
        logoutImag.heightAnchor.constraint(equalToConstant: 22).isActive = true
        logoutImag.widthAnchor.constraint(equalToConstant: 20).isActive = true
        logoutImag.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        logoutImag.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                             constant: -26).isActive = true
        logoutImag.tintColor = .ypRed
        
    }
}
