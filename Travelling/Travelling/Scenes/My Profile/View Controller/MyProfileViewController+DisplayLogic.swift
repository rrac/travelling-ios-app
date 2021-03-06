//
//  MyProfileViewController+DisplayLogic.swift
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

protocol MyProfileDisplayLogic: class {
    func displayWillFetchUser()
    func displayDidFetchUser()
    func displayUser(viewModel: MyProfileModels.UserPresentation.ViewModel)
    func displayResetUser()
    
    func displayWillFetchImage(viewModel: MyProfileModels.ImageFetching.ViewModel)
    func displayDidFetchImage(viewModel: MyProfileModels.ImageFetching.ViewModel)
    func displayImage(viewModel: MyProfileModels.ImagePresentation.ViewModel)
    
    func displayWillLogoutUser()
    func displayDidLogoutUser()
    func displayLoggedOutUser()
    
    func displayNavigateToEmail(viewModel: MyProfileModels.EmailNavigation.ViewModel)
    
    func displayErrorState(viewModel: MyProfileModels.ErrorStatePresentation.ViewModel)
    func displayRemoveErrorState()
    
    func displayErrorAlert(viewModel: MyProfileModels.ErrorAlertPresentation.ViewModel)
    
    func displayNavigateToFullscreenImage(viewModel: MyProfileModels.FullscreenImageNavigation.ViewModel)
}

extension MyProfileViewController: MyProfileDisplayLogic {
    func displayWillFetchUser() {
        DispatchQueue.main.async {
            self.tableView?.tableFooterView = self.setupActivityIndicatorView()
        }
    }
    
    func displayDidFetchUser() {
        DispatchQueue.main.async {
            self.tableView?.tableFooterView = UIView(frame: .zero)
        }
    }
    
    func displayUser(viewModel: MyProfileModels.UserPresentation.ViewModel) {
        DispatchQueue.main.async {
            self.items = viewModel.items
            self.tableView?.reloadData()
        }
    }
    
    func displayResetUser() {
        DispatchQueue.main.async {
            self.items = []
            self.tableView?.reloadData()
        }
    }
    
    func displayWillFetchImage(viewModel: MyProfileModels.ImageFetching.ViewModel) {
        DispatchQueue.main.async {
            viewModel.model.isLoadingImage = true
            viewModel.model.cellInterface?.setIsLoadingImage(isLoading: true)
        }
    }
    
    func displayDidFetchImage(viewModel: MyProfileModels.ImageFetching.ViewModel) {
        DispatchQueue.main.async {
            viewModel.model.isLoadingImage = false
            viewModel.model.cellInterface?.setIsLoadingImage(isLoading: false)
        }
    }
    
    func displayImage(viewModel: MyProfileModels.ImagePresentation.ViewModel) {
        DispatchQueue.main.async {
            viewModel.model.image = viewModel.image
            viewModel.model.imageContentMode = viewModel.contentMode
            viewModel.model.cellInterface?.setImage(image: viewModel.image, contentMode: viewModel.contentMode)
        }
    }
    
    func displayWillLogoutUser() {
        DispatchQueue.main.async {
            self.tableView?.isUserInteractionEnabled = false
            self.navigationItem.setRightBarButton(UIBarButtonItem(customView: self.setupActivityIndicatorView()), animated: true)
        }
    }
    
    func displayDidLogoutUser() {
        DispatchQueue.main.async {
            self.tableView?.isUserInteractionEnabled = true
            self.navigationItem.setRightBarButton(nil, animated: true)
        }
    }
    
    func displayLoggedOutUser() {
        DispatchQueue.main.async {
            self.delegate?.myProfileViewControllerDidLogoutUser(viewController: self)
        }
    }
    
    func displayNavigateToEmail(viewModel: MyProfileModels.EmailNavigation.ViewModel) {
        DispatchQueue.main.async {
            self.router?.navigateToEmail(recipient: viewModel.recipient, subject: viewModel.subject)
        }
    }
    
    func displayErrorState(viewModel: MyProfileModels.ErrorStatePresentation.ViewModel) {
        DispatchQueue.main.async {
            self.tableView?.backgroundView = self.errorStateView(image: viewModel.image, attributedText: viewModel.text)
        }
    }
    
    func displayRemoveErrorState() {
        DispatchQueue.main.async {
            self.tableView?.backgroundView = nil
        }
    }
    
    func displayErrorAlert(viewModel: MyProfileModels.ErrorAlertPresentation.ViewModel) {
        DispatchQueue.main.async {
            let cancelAction = UIAlertAction(title: viewModel.cancelTitle, style: .cancel, handler: nil)
            self.router?.navigateToAlert(title: viewModel.title, message: viewModel.message, actions: [cancelAction])
        }
    }
    
    func displayNavigateToFullscreenImage(viewModel: MyProfileModels.FullscreenImageNavigation.ViewModel) {
        DispatchQueue.main.async {
            self.router?.navigateToFullscreenImage(imageName: viewModel.imageName)
        }
    }
}
