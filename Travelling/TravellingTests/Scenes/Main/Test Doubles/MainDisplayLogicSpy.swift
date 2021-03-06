//
//  MainDisplayLogicSpy.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 12/09/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling

class MainDisplayLogicSpy: MainDisplayLogic {
    var displaySetupScenesCalled: Bool = false
    var displaySelectSceneCalled: Bool = false
    
    var displayNavigateToOnboardingCalled: Bool = false
    var displayDismissOnboardingCalled: Bool = false
    
    var displayLoginUserCalled: Bool = false
    var displayLogoutUserCalled: Bool = false
    
    func displaySetupScenes(viewModel: MainModels.ScenesSetup.ViewModel) {
        self.displaySetupScenesCalled = true
    }
    
    func displaySelectScene(viewModel: MainModels.SceneSelection.ViewModel) {
        self.displaySelectSceneCalled = true
    }
    
    func displayNavigateToOnboarding() {
        self.displayNavigateToOnboardingCalled = true
    }
    
    func displayDismissOnboarding() {
        self.displayDismissOnboardingCalled = true
    }
    
    func displayLoginUser(viewModel: MainModels.UserLogin.ViewModel) {
        self.displayLoginUserCalled = true
    }
    
    func displayLogoutUser() {
        self.displayLogoutUserCalled = true
    }
}
