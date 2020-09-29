//
//  MyProfileViewController+Subviews.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 27/09/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

extension MyProfileViewController {
    func setupSubviews() {
        self.setupNavigationBar()
        self.setupNavigationItem()
        self.setupContentView()
        self.setupTableView()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = MyProfileStyle.shared.navigationBarModel.isTranslucent
        self.navigationController?.navigationBar.tintColor = MyProfileStyle.shared.navigationBarModel.tintColor
        self.navigationController?.navigationBar.barTintColor = MyProfileStyle.shared.navigationBarModel.barTintColor
        self.navigationController?.navigationBar.titleTextAttributes = MyProfileStyle.shared.navigationBarModel.titleAttributes()
    }
    
    private func setupNavigationItem() {
        self.navigationItem.title = MyProfileLocalization.shared.title
    }
    
    private func setupContentView() {
        self.view.backgroundColor = MyProfileStyle.shared.contentViewModel.backgroundColor
    }
    
    private func setupTableView() {
        self.tableView?.backgroundColor = MyProfileStyle.shared.tableViewModel.backgroundColor
        self.tableView?.tableFooterView = UIView(frame: .zero)
        self.tableView?.register(MyProfileInformationTableViewCell.self, forCellReuseIdentifier: MyProfileInformationTableViewCell.defaultReuseIdentifier)
        self.tableView?.register(MyProfileTitleTableViewCell.self, forCellReuseIdentifier: MyProfileTitleTableViewCell.defaultReuseIdentifier)
        self.tableView?.separatorColor = MyProfileStyle.shared.tableViewModel.separatorColor
    }
    
    func setupActivityIndicatorView() -> UIActivityIndicatorView {
        let size = MyProfileStyle.shared.activityViewModel.size
        let view = UIActivityIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        view.color = MyProfileStyle.shared.activityViewModel.color
        view.hidesWhenStopped = false
        view.startAnimating()
        return view
    }
}
