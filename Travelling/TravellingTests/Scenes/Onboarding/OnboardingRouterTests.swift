//
//  OnboardingRouterTests.swift
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
import XCTest

class OnboardingRouterTests: XCTestCase {
    var sut: OnboardingRouter!
    var viewControllerSpy: OnboardingViewControllerSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupOnboardingRouter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupOnboardingRouter() {
        self.sut = OnboardingRouter()
        
        self.viewControllerSpy = OnboardingViewControllerSpy()
        self.sut.viewController = self.viewControllerSpy
    }
    
    // MARK: - Tests
    
    func testDismiss() {
        self.sut.dismiss()
        XCTAssertTrue(self.viewControllerSpy.dismissCalled)
    }
    
    func testNavigateToLogin() {
        let navigationControllerSpy = UINavigationControllerSpy(rootViewController: self.sut.viewController!)
        self.sut.navigateToLogin()
        XCTAssertTrue(navigationControllerSpy.pushedViewController is LoginViewController)
    }
    
    func testNavigateToSignUp() {
        let navigationControllerSpy = UINavigationControllerSpy(rootViewController: self.sut.viewController!)
        self.sut.navigateToSignUp()
         XCTAssertTrue(navigationControllerSpy.pushedViewController is SignUpViewController)
    }
}
