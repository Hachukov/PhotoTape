//
//  ProfileService.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 04.02.2023.
//

import Foundation

struct Profile {
    let username: String
    let first_name: String
    let last_name: String
    var name: String {
        return "\(first_name) \(last_name)"
    }
    
    var loginName: String {
        return "@\(username)"
    }
    
    let bio: String
    
}

struct ProfileResult: Codable {
    
}

// TODO: - метод fetchProfile не должен приводить к гонкам
final class ProfileService {
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        
    }
}
