//
//  MyProfileDisplayLogicSpy.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 27/09/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling

class MyProfileDisplayLogicSpy: MyProfileDisplayLogic {
    var displayWillFetchUserCalled: Bool = false
    var displayDidFetchUserCalled: Bool = false
    var displayUserCalled: Bool = false
    var displayUserViewModel: MyProfileModels.UserPresentation.ViewModel!
    var displayResetUserCalled: Bool = false
    
    var displayWillFetchImageCalled: Bool = false
    var displayDidFetchImageCalled: Bool = false
    var displayImageCalled: Bool = false
    
    var displayWillLogoutUserCalled: Bool = false
    var displayDidLogoutUserCalled: Bool = false
    var displayLoggedOutUserCalled: Bool = false
    
    var displayNavigateToEmailCalled: Bool = false
    
    var displayErrorStateCalled: Bool = false
    var displayRemoveErrorStateCalled: Bool = false
    
    var displayErrorAlertCalled: Bool = false
    
    func displayWillFetchUser() {
        self.displayWillFetchUserCalled = true
    }
    
    func displayDidFetchUser() {
        self.displayDidFetchUserCalled = true
    }
    
    func displayUser(viewModel: MyProfileModels.UserPresentation.ViewModel) {
        self.displayUserCalled = true
        self.displayUserViewModel = viewModel
    }
    
    func displayResetUser() {
        self.displayResetUserCalled = true
    }
    
    func displayWillFetchImage(viewModel: MyProfileModels.ImageFetching.ViewModel) {
        self.displayWillFetchImageCalled = true
    }
    
    func displayDidFetchImage(viewModel: MyProfileModels.ImageFetching.ViewModel) {
        self.displayDidFetchImageCalled = true
    }
    
    func displayImage(viewModel: MyProfileModels.ImagePresentation.ViewModel) {
        self.displayImageCalled = true
    }
    
    func displayWillLogoutUser() {
        self.displayWillLogoutUserCalled = true
    }
    
    func displayDidLogoutUser() {
        self.displayDidLogoutUserCalled = true
    }
    
    func displayLoggedOutUser() {
        self.displayLoggedOutUserCalled = true
    }
    
    func displayNavigateToEmail(viewModel: MyProfileModels.EmailNavigation.ViewModel) {
        self.displayNavigateToEmailCalled = true
    }
    
    func displayErrorState(viewModel: MyProfileModels.ErrorStatePresentation.ViewModel) {
        self.displayErrorStateCalled = true
    }
    
    func displayRemoveErrorState() {
        self.displayRemoveErrorStateCalled = true
    }
    
    func displayErrorAlert(viewModel: MyProfileModels.ErrorAlertPresentation.ViewModel) {
        self.displayErrorAlertCalled = true
    }
}
