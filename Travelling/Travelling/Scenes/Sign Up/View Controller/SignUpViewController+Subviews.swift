//
//  SignUpViewController+Subviews.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 06/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

extension SignUpViewController {
    func setupSubviews() {
        self.setupNavigationBar()
        self.setupNavigationItem()
        self.setupContentView()
        self.setupTableView()
    }
    
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = SignUpStyle.shared.navigationBarModel.isTranslucent
        self.navigationController?.navigationBar.tintColor = SignUpStyle.shared.navigationBarModel.tintColor
        self.navigationController?.navigationBar.barTintColor = SignUpStyle.shared.navigationBarModel.barTintColor
        self.navigationController?.navigationBar.titleTextAttributes = SignUpStyle.shared.navigationBarModel.titleAttributes()
    }
    
    private func setupNavigationItem() {
        self.navigationItem.title = SignUpLocalization.shared.signUpTitle
    }
    
    private func setupContentView() {
        self.view.backgroundColor = SignUpStyle.shared.contentViewModel.backgroundColor
    }
    
    private func setupTableView() {
        self.tableView?.separatorStyle = .none
        self.tableView?.register(SignUpTextFieldCell.self, forCellReuseIdentifier: SignUpTextFieldCell.defaultReuseIdentifier)
        self.tableView?.register(SignUpButtonCell.self, forCellReuseIdentifier: SignUpButtonCell.defaultReuseIdentifier)
        self.tableView?.register(SignUpPhotoCell.self, forCellReuseIdentifier: SignUpPhotoCell.defaultReuseIdentifier)
        self.tableView?.register(SignUpTextViewCell.self, forCellReuseIdentifier: SignUpTextViewCell.defaultReuseIdentifier)
    }
}
