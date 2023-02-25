//
//  TabBarController.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 19.02.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        let storybord = UIStoryboard(name: "Main", bundle: .main)
        
        let imageListViewController = storybord.instantiateViewController(withIdentifier: "ImagesListViewController")
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: "Profile",
                                                        image: UIImage(systemName: "person.crop.circle.fill"),
                                                        selectedImage: nil)
        
        self.viewControllers = [imageListViewController, profileViewController]
    }
}
