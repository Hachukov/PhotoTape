//
//  ProfileImageService.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 11.02.2023.
//

import Foundation

final class ProfileImageService {
    static let shared = ProfileImageService()
    static let DidChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    private var task: URLSessionTask?
    private(set) var avatarURL: String?
    private let session = URLSession.shared
    private var profileImageURL: URL?
}

extension ProfileImageService {
    func fetchProfileImageURL(token: String, _ completion: @escaping (Result<UserResult, Error>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        urlComponents.path = "/me"
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token))", forHTTPHeaderField: "Authorization")
        
        task = object(for: request) { result in
            // TODO: - Нужно потом дописать с использование этого self
            
            switch result {
            case .success(let useImage):
                completion(.success(useImage))
                guard let profileImageURL = URL(string: useImage.profile_image.small) else { return }
                NotificationCenter.default
                    .post(name: ProfileImageService.DidChangeNotification,
                          object: self,
                          userInfo: ["URL": profileImageURL])
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task!.resume() // TODO: - нужно улучшить "force unwrapping"
    }
}


extension ProfileImageService {
    private func object(
        for request: URLRequest,
        completion: @escaping (Result<UserResult, Error>) -> Void
    ) -> URLSessionTask {
        let decoder = JSONDecoder()
        return session.data(for: request) { (result: Result<Data, Error>) in
            let response = result.flatMap { data -> Result<UserResult, Error> in
                Result { try decoder.decode(UserResult.self, from: data) }
            }
            completion(response)
        }
    }
}
