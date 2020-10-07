//
//  ForgotPasswordPresentationLogicSpy.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 05/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling

class ForgotPasswordPresentationLogicSpy: ForgotPasswordPresentationLogic {
    var presentSetupItemsCalled: Bool = false
    
    var presentUpdateItemCalled: Bool = false
    var presentValidationErrorCalled: Bool = false
    
    var presentEnableItemCalled: Bool = false
    var presentDisableItemCalled: Bool = false
    
    var presentLoadingItemCalled: Bool = false
    var presentNotLoadingItemCalled: Bool = false
    
    var presentEnableUserInteractionCalled: Bool = false
    var presentDisableUserInteractionCalled: Bool = false
    
    var presentConfirmationAlertCalled: Bool = false
    var presentConfirmationEmailAlertCalled: Bool = false
    var presentErrorAlertCalled: Bool = false
    
    var presentOpenMailApplicationCalled: Bool = false
    
    func presentSetupItems() {
        self.presentSetupItemsCalled = true
    }
    
    func presentUpdateItem(response: ForgotPasswordModels.UpdateItem.Response) {
        self.presentUpdateItemCalled = true
    }
    
    func presentValidationError(response: ForgotPasswordModels.ValidateItem.Response) {
        self.presentValidationErrorCalled = true
    }
    
    func presentEnableItem(response: ForgotPasswordModels.EnableItem.Response) {
        self.presentEnableItemCalled = true
    }
    
    func presentDisableItem(response: ForgotPasswordModels.EnableItem.Response) {
        self.presentDisableItemCalled = true
    }
    
    func presentLoadingItem(response: ForgotPasswordModels.LoadingItem.Response) {
        self.presentLoadingItemCalled = true
    }
    
    func presentNotLoadingItem(response: ForgotPasswordModels.LoadingItem.Response) {
        self.presentNotLoadingItemCalled = true
    }
    
    func presentEnableUserInteraction() {
        self.presentEnableUserInteractionCalled = true
    }
    
    func presentDisableUserInteraction() {
        self.presentDisableUserInteractionCalled = true
    }
    
    func presentConfirmationAlert(response: ForgotPasswordModels.Confirmation.Response) {
        self.presentConfirmationAlertCalled = true
    }
    
    func presentConfirmationEmailAlert(response: ForgotPasswordModels.ConfirmationEmail.Response) {
        self.presentConfirmationEmailAlertCalled = true
    }
    
    func presentErrorAlert(response: ForgotPasswordModels.ForgotPasswordError.Response) {
        self.presentErrorAlertCalled = true
    }
    
    func presentOpenMailApplication(response: ForgotPasswordModels.OpenApplication.Response) {
        self.presentOpenMailApplicationCalled = true
    }
}