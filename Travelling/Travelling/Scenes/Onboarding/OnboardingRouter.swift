//
//  OnboardingRouter.swift
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

protocol OnboardingRoutingLogic {
    func dismiss()
    func navigateToLogin()
    func navigateToSignUp()
}

class OnboardingRouter: OnboardingRoutingLogic {
    weak var viewController: OnboardingViewController?
    
    func dismiss() {
        self.viewController?.dismiss(animated: true, completion: nil)
    }
    
    func navigateToLogin() {
        
    }
    
    func navigateToSignUp() {
        
    }
}