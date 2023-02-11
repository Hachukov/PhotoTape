//
//  ProfileViewController.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 05.12.2022.
//

import UIKit

struct Profile {

    var username = ""
    var first_name = ""
    var last_name = ""
    var bio = ""
    var name: String {
        first_name + " " + last_name
    }
    var loginName: String {
        "@\(username)"
    }
}

class ProfileViewController: UIViewController {

    private var profile = Profile()
    private let token = OAuth2TokenStorage.shared.token
    private let profileService = ProfileService.shared

    private let profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.image = UIImage(systemName: "person")
        return profileImage
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = ""
        nameLabel.textColor = .ypWhite
        return nameLabel
    }()
    
    private let mailLabel: UILabel = {
        let mailLabel = UILabel()
        mailLabel.translatesAutoresizingMaskIntoConstraints = false
        mailLabel.text = ""
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
    
    // MARK: - Lifecycle

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(mailLabel)
        view.addSubview(logoutButton)
        profileService.fetchProfile(token!) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let body):
                    self.profile.last_name = body.last_name
                    self.profile.first_name = body.first_name
                    self.profile.username = body.username
                    self.profile.bio = body.bio!
                    self.updateProfileDetails(profile: self.profile)
            case .failure(let error):
                print(error)
            }
        }
        addConstraints()
    }

    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()

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
               
        NSLayoutConstraint.activate(constraints)
    }
}

extension ProfileViewController {
    func updateProfileDetails(profile: Profile) {
        print("Проверка \(profile)")
        self.nameLabel.text = profile.name
        self.mailLabel.text = profile.loginName
        
    }
}
