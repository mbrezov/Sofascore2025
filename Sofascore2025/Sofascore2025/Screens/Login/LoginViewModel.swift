//
//  LoginViewModel.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 24.04.2025..
//

import Foundation

class LoginViewModel {

    var toastErrorAlert: ((String?, String?) -> Void)?
    var loginInProgress: ((Bool) -> Void)?

    func login(_ username: String?, _ password: String?) {
        self.loginInProgress?(true)

        Task { [weak self] in
            do {
                let response = try await APIService.login(username: username, password: password)
                self?.loginDidFinish(response)
            } catch let error as APIErrorWithDetails {
                switch error.type {
                case .invalidURL, .noInternet:
                    self?.loginDidFinish(errorTitle: error.title, errorMessage: error.message)

                default:
                    print(error.title, error.message)
                }
                self?.loginDidFinish(errorTitle: error.title, errorMessage: error.message)
            }
        }
    }

    private func loginDidFinish(
        _ response: APIAuthResponse? = nil,
        errorTitle: String? = nil,
        errorMessage: String? = nil
    ) {
        DispatchQueue.main.async {
            if let response = response {
                AuthService.login(response)
            } else {
                self.toastErrorAlert?(errorTitle, errorMessage)
            }
            self.loginInProgress?(false)
        }
    }
}
