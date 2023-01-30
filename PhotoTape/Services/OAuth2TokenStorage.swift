//
//  OAuth2TokenStorage.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 30.01.2023.
//

import Foundation

final class OAuth2TokenStorage {

    static let shared = OAuth2TokenStorage()
    private let oAuth2Token = "oAuth2Token"

    var token: String? {
        get {
            UserDefaults.standard.string(forKey: oAuth2Token)
        }
        set {
            if let token = newValue {
                UserDefaults.standard.set(token, forKey: oAuth2Token)
            } else {
                UserDefaults.standard.removeObject(forKey: oAuth2Token)
            }
        }
    }
}
