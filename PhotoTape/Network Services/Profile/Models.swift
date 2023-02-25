//
//  Models.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 18.02.2023.
//

import Foundation

// MARK:- Модель ProfileImage
struct UserResult: Codable {
    let profile_image: ProfileImagesSize
    enum CodingKeys: String, CodingKey {
        case profile_image = "profile_image"
    }
}

struct ProfileImagesSize: Codable {
    let small: String
    enum CodingKeys: String, CodingKey {
        case small = "small"
    }
}


// MARK:- Модель ProfileService
struct ProfileResult: Codable {
    let username: String
    let first_name: String
    let last_name: String
    let bio: String?
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case first_name = "first_name"
        case last_name = "last_name"
        case bio = "bio"
  
    }
}

