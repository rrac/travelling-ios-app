//
//  ForgotPasswordRouterTests.swift
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
import XCTest

class ForgotPasswordRouterTests: XCTestCase {
    var sut: ForgotPasswordRouter!
    var viewControllerSpy: ForgotPasswordViewControllerSpy!
    var urlOpenerSpy: URLOpenableSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupForgotPasswordRouter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupForgotPasswordRouter() {
        self.sut = ForgotPasswordRouter()
        
        self.viewControllerSpy = ForgotPasswordViewControllerSpy()
        self.sut.viewController = self.viewControllerSpy
        
        self.urlOpenerSpy = URLOpenableSpy()
        self.sut.urlOpener = self.urlOpenerSpy
    }
    
    // MARK: - Tests
    
    func testPopViewController() {
        let navigationControllerSpy = UINavigationControllerSpy(rootViewController: self.sut.viewController!)
        self.sut.popViewController()
        XCTAssertTrue(navigationControllerSpy.popViewControllerCalled)
    }
    
    func testNavigateToAlert() {
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        self.sut.navigateToAlert(title: "Title", message: "Message", actions: [action])
        XCTAssertTrue(self.viewControllerSpy.presentCalled)
    }
    
    func testNavigateToApplication() {
        self.sut.navigateToApplication(url: URL(string: "https://url.com")!)
        XCTAssertTrue(self.urlOpenerSpy.openCalled)
    }
}