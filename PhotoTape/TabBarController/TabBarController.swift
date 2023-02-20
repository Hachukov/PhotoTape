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
        
        let profileViewController = storybord.instantiateViewController(withIdentifier: "ProfileViewController")
        
        self.viewControllers = [imageListViewController, profileViewController]
    }
}
