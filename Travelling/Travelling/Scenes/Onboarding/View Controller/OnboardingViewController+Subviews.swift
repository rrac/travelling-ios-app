//
//  OnboardingViewController+Subviews.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 04/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

extension OnboardingViewController {
    func setupSubviews() {
        self.setupContentView()
        self.setupDismissButton()
        self.setupLogoImageView()
        self.setupLoginButton()
        self.setupSignUpButton()
    }
    
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupContentView() {
        self.view.backgroundColor = OnboardingStyle.shared.contentViewModel.backgroundColor
    }
    
    private func setupDismissButton() {
        let button: UIButton = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = OnboardingStyle.shared.dismissButtonModel.tintColor
        button.setImage(OnboardingStyle.shared.dismissButtonModel.image, for: .normal)
        button.addTarget(self, action: #selector(OnboardingViewController.touchUpInsideDismissButton), for: .touchUpInside)
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        self.view.addSubview(button)
        self.dismissButton = button
    }
    
    private func setupLogoImageView() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = OnboardingStyle.shared.logoImageViewModel.image
        imageView.tintColor = OnboardingStyle.shared.logoImageViewModel.tintColor
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        self.logoImageView = imageView
    }
    
    private func setupLoginButton() {
        let button: UIButton = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = OnboardingStyle.shared.loginButtonModel.backgroundColor
        button.layer.borderWidth = OnboardingStyle.shared.loginButtonModel.borderWidth
        button.layer.borderColor = OnboardingStyle.shared.loginButtonModel.borderColor
        button.layer.cornerRadius = OnboardingStyle.shared.loginButtonModel.cornerRadius
        button.setAttributedTitle(OnboardingLocalization.shared.loginTitle.attributed(attributes: OnboardingStyle.shared.loginButtonModel.titleAttributes()), for: .normal)
        button.contentEdgeInsets = OnboardingStyle.shared.loginButtonModel.contentEdgeInsets
        button.addTarget(self, action: #selector(OnboardingViewController.touchUpInsideLoginButton), for: .touchUpInside)
        self.view.addSubview(button)
        self.loginButton = button
    }
    
    private func setupSignUpButton() {
        let button: UIButton = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = OnboardingStyle.shared.signUpButtonModel.backgroundColor
        button.layer.borderWidth = OnboardingStyle.shared.signUpButtonModel.borderWidth
        button.layer.borderColor = OnboardingStyle.shared.signUpButtonModel.borderColor
        button.layer.cornerRadius = OnboardingStyle.shared.signUpButtonModel.cornerRadius
        button.setAttributedTitle(OnboardingLocalization.shared.signUpTitle.attributed(attributes: OnboardingStyle.shared.signUpButtonModel.titleAttributes()), for: .normal)
        button.contentEdgeInsets = OnboardingStyle.shared.signUpButtonModel.contentEdgeInsets
        button.addTarget(self, action: #selector(OnboardingViewController.touchUpInsideSignUpButton), for: .touchUpInside)
        self.view.addSubview(button)
        self.signUpButton = button
    }
}

// MARK: - Actions

extension OnboardingViewController {
    @objc func touchUpInsideDismissButton() {
        self.router?.dismiss()
    }
    
    @objc func touchUpInsideLoginButton() {
        self.router?.navigateToLogin()
    }
    
    @objc func touchUpInsideSignUpButton() {
        self.router?.navigateToSignUp()
    }
}

// MARK: - Constraints

extension OnboardingViewController {
    func setupSubviewsConstraints() {
        self.setupDismissButtonConstraints()
        self.setupLogoImageViewConstraints()
        self.setupLoginButtonConstraints()
        self.setupSignUpButtonConstraints()
    }
    
    private func setupDismissButtonConstraints() {
        NSLayoutConstraint.activate([
            self.dismissButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.dismissButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])
    }
    
    private func setupLogoImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.logoImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.logoImageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            self.logoImageView.widthAnchor.constraint(equalToConstant: OnboardingStyle.shared.logoImageViewModel.size),
            self.logoImageView.heightAnchor.constraint(equalToConstant: OnboardingStyle.shared.logoImageViewModel.size)
        ])
    }
    
    private func setupLoginButtonConstraints() {
        NSLayoutConstraint.activate([
            self.loginButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            self.loginButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.loginButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }
    
    private func setupSignUpButtonConstraints() {
        NSLayoutConstraint.activate([
            self.signUpButton.bottomAnchor.constraint(equalTo: self.loginButton.topAnchor, constant: -15),
            self.signUpButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.signUpButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }
}
