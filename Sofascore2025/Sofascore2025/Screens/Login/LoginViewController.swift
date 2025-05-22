//
//  LoginViewController.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 23.04.2025..
//

import SnapKit
import SofaAcademic
import UIKit

class LoginViewController: UIViewController, BaseViewProtocol {

    private enum Padding {

        static let loginButtonBottom: CGFloat = 32
        static let horizontal: CGFloat = 16
    }

    private enum Constants {

        static let verticalSpacing: CGFloat = 32
    }

    private let loginViewModel = LoginViewModel()

    private let headerView = LoginHeaderView()
    private let usernameTextField = OutlineTextField()
    private let passwordTextField = OutlineTextField()
    private let loginButton = SolidButton()
    private let stackView = UIStackView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        styleViews()
        setupConstraints()
        setupBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func addViews() {
        view.addSubview(headerView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(loadingIndicator)
    }

    func styleViews() {
        view.backgroundColor = .surface

        usernameTextField.placeholder = .usernameTextFieldPlaceholder
        usernameTextField.setPreventsSpaces(true)

        passwordTextField.placeholder = .passwordTextFieldPlaceholder
        passwordTextField.setPreventsSpaces(true)
        passwordTextField.isSecureTextEntry = true

        loginButton.setTitle(.loginButtonTitle, for: .normal)

        stackView.axis = .vertical
        stackView.spacing = Constants.verticalSpacing
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        loadingIndicator.color = .surfaceLv2
        loadingIndicator.hidesWhenStopped = true
    }

    func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.horizontal)
            $0.top.greaterThanOrEqualTo(headerView.snp.bottom).inset(Constants.verticalSpacing)
            $0.centerY.equalToSuperview()
            $0.bottom.lessThanOrEqualTo(loginButton.snp.top).offset(Constants.verticalSpacing)
        }

        loginButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(Padding.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Padding.loginButtonBottom)
        }

        loadingIndicator.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(Constants.verticalSpacing)
            $0.centerX.equalToSuperview()
        }
    }

    func setupBinding() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)

        loginViewModel.loginInProgress = { [weak self] isLoading in
            self?.loadingIndicator.isHidden = isLoading
            if isLoading {
                self?.loadingIndicator.startAnimating()
            } else {
                self?.loadingIndicator.stopAnimating()
            }
        }

        loginViewModel.toastErrorAlert = { [weak self] title, message in
            self?.showAlert(title: title, message: message)
        }
    }

    @objc private func handleLogin() {
        let username = usernameTextField.text
        let password = passwordTextField.text
        loginViewModel.login(username, password)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
