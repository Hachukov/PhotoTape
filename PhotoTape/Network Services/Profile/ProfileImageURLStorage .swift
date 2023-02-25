//
//  ProfileImagURL.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 18.02.2023.
//

import Foundation

final class ProfileImageURLStorage {
    static var shared = ProfileImageURLStorage()
    
    private let profileImageURL = "profileImageURL"
    
    var imageURL: String?  {
        get {
            UserDefaults.standard.string(forKey: profileImageURL)
        }
        set {
            if let imageURL = newValue {
                UserDefaults.standard.set(imageURL, forKey: profileImageURL)
            } else {
                UserDefaults.standard.removeObject(forKey: profileImageURL)
            }
        }
    }
}
