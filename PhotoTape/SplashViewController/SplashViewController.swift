//
//  SplashViewController.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 24.01.2023.
//

import UIKit
import ProgressHUD

final class SplashViewController: UIViewController {
    
    // MARK: - Properties
    private let showAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    private let oauth2Service = OAuth2Service.shared
    private let oauth2TokenStorage = OAuth2TokenStorage()
    private var profileImageURLStorage = ProfileImageURLStorage.shared
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    
    
    private (set) var profileImageURL: String? {
        get {
            return profileImageURLStorage.imageURL
        }
        set {
            profileImageURLStorage.imageURL = newValue
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let token = OAuth2TokenStorage().token {
            fetchProfile(token: token)
            switchToTabBarController()

        } else {
            performSegue(withIdentifier: showAuthenticationScreenSegueIdentifier, sender: nil)
        }
    }
    
    // MARK: -  Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    // MARK: - Methods
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
            window.rootViewController = tabBarController
    }
}
    
extension SplashViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Проверим, что переходим на авторизацию
        if segue.identifier == showAuthenticationScreenSegueIdentifier {
            
            // Доберёмся до первого контроллера в навигации. Мы помним, что в программировании отсчёт начинается с 0?
            guard
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers[0] as? AuthViewController
            else { fatalError("Failed to prepare for \(showAuthenticationScreenSegueIdentifier)") }
            
            // Установим делегатом контроллера наш SplashViewController
            viewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
           }
    }
}
//
extension SplashViewController {
    func fetchProfile(token: String) {
        profileService.fetchProfile(token) { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let result):
                UIBlockingProgressHUD.dismiss()
                self.switchToTabBarController()
                print("Проверка \(result)")
            case .failure(_):
                self.showErrorAlert()
                UIBlockingProgressHUD.dismiss()
                break
            }
        }
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    // MARK: - Methods AuthViewControllerDelegate
    func authViewViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        UIBlockingProgressHUD.show()
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.fetchOAuthToken(code)
        }
    }
    
    private func fetchOAuthToken(_ code: String) {
        oauth2Service.fetchOAuthToken(code) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let token):
                self.fetchProfile(token: token)
                self.switchToTabBarController()
                UIBlockingProgressHUD.dismiss()
            case .failure:
                self.showErrorAlert()
                UIBlockingProgressHUD.dismiss()
                break
            }
        }
    }
}


extension SplashViewController {
    func showErrorAlert() {
         let alert = UIAlertController(title: "Что-то пошло не так(",
                                       message: "Не удалось войти в систему",
                                       preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
