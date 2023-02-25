//
//  OAuth2TokenStorage.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 30.01.2023.
//

import Foundation
import SwiftKeychainWrapper

final class OAuth2TokenStorage {

    static let shared = OAuth2TokenStorage()
    private let oAuth2Token = "oAuth2Token"

    var token: String? {
        get {
            KeychainWrapper.standard.string(forKey: oAuth2Token)
        }
        set {
            if let token = newValue {
                KeychainWrapper.standard.set(token, forKey: oAuth2Token)
            } else {
                KeychainWrapper.standard.removeObject(forKey: oAuth2Token)
                
            }
        }
    }
}
