//
//  LoginBusinessLogicSpy.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 04/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling

class LoginBusinessLogicSpy: LoginBusinessLogic {
    var shouldSetupItemsCalled: Bool = false
    
    var shouldUpdateItemCalled: Bool = false
    
    var shouldValidateItemCalled: Bool = false
    
    var shouldActivateTextFieldCalled: Bool = false
    
    var shouldSelectItemCalled: Bool = false
    
    func shouldSetupItems() {
        self.shouldSetupItemsCalled = true
    }
    
    func shouldUpdateItem(request: LoginModels.UpdateItem.Request) {
        self.shouldUpdateItemCalled = true
    }
    
    func shouldValidateItem(request: LoginModels.ValidateItem.Request) {
        self.shouldValidateItemCalled = true
    }
    
    func shouldActivateTextField(request: LoginModels.ActivateTextField.Request) {
        self.shouldActivateTextFieldCalled = true
    }
    
    func shouldSelectItem(request: LoginModels.ItemSelection.Request) {
        self.shouldSelectItemCalled = true
    }
}
