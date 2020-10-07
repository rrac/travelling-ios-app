//
//  ForgotPasswordRoutingLogicSpy.swift
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
import UIKit

class ForgotPasswordRoutingLogicSpy: ForgotPasswordRoutingLogic {
    var popViewControllerCalled: Bool = false
    var navigateToAlertCalled: Bool = false
    var navigateToApplicationCalled: Bool = false
    
    func popViewController() {
        self.popViewControllerCalled = true
    }
    
    func navigateToAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        self.navigateToAlertCalled = true
    }
    
    func navigateToApplication(url: URL) {
        self.navigateToApplicationCalled = true
    }
}