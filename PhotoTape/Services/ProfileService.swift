//
//  ProfileService.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 04.02.2023.
//

import Foundation
// MARK:- Модель
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


// TODO: - метод fetchProfile не должен приводить к гонкам
final class ProfileService {
    let session = URLSession.shared
    private var task: URLSessionTask?
    static let shared = ProfileService()
    private(set) var profile: ProfileResult?
}

extension ProfileService {

    func fetchProfile(_ token: String, completion: @escaping (Result<ProfileResult, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        urlComponents.path = "/me"
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        task = object(for: request) { result in
            // TODO: - Нужно потом дописать с использование этого self
            switch result {
            case .success(let body):
                let profile = body
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task!.resume() // TODO: - нужно улучшить "force unwrapping"
    }
}

extension ProfileService {
    private func object(
        for request: URLRequest,
        completion: @escaping (Result<ProfileResult, Error>) -> Void
    ) -> URLSessionTask {
        let decoder = JSONDecoder()
        return session.data(for: request) { (result: Result<Data, Error>) in
            let response = result.flatMap { data -> Result<ProfileResult, Error> in
                Result { try decoder.decode(ProfileResult.self, from: data) }
            }
            completion(response)
        }
    }
}
