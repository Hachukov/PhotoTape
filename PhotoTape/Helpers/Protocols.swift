//
//  Protocols.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 17.01.2023.
//

import Foundation


// протокол для обработки полученного code
protocol WebViewViewControllerDelegate: AnyObject {
   func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
   func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}


