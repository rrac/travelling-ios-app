//
//  MyProfileBusinessLogicSpy.swift
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

class MyProfileBusinessLogicSpy: MyProfileBusinessLogic {
    var shouldSetupUserCalled: Bool = false
    var shouldRefreshUserCalled: Bool = false
    
    var shouldFetchImageCalled: Bool = false
    
    var shouldSelectItemCalled: Bool = false
    var shouldSelectAvatarCalled: Bool = false
    
    var shouldLoginUserCalled: Bool = false
    var shouldLogoutUserCalled: Bool = false
    
    func shouldSetupUser() {
        self.shouldSetupUserCalled = true
    }
    
    func shouldRefreshUser() {
        self.shouldRefreshUserCalled = true
    }
    
    func shouldFetchImage(request: MyProfileModels.ImageFetching.Request) {
        self.shouldFetchImageCalled = true
    }
    
    func shouldSelectItem(request: MyProfileModels.ItemSelection.Request) {
        self.shouldSelectItemCalled = true
    }
    
    func shouldSelectAvatar() {
        self.shouldSelectAvatarCalled = true
    }
    
    func shouldLoginUser(request: MyProfileModels.UserLogin.Request) {
        self.shouldLoginUserCalled = true
    }
    
    func shouldLogoutUser() {
        self.shouldLogoutUserCalled = true
    }
}
