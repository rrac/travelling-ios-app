//
//  MyProfileRouterTests.swift
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
import XCTest

class MyProfileRouterTests: XCTestCase {
    var sut: MyProfileRouter!
    var viewControllerSpy: MyProfileViewControllerSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupMyProfileRouter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupMyProfileRouter() {
        self.sut = MyProfileRouter()
        
        self.viewControllerSpy = MyProfileViewControllerSpy()
        self.sut.viewController = self.viewControllerSpy
    }
    
    // MARK: - Tests
    
    func testNavigateToEmail() {
        self.sut.navigateToEmail(recipient: "recipient", subject: "subject")
        XCTAssertTrue(self.viewControllerSpy.presentCalled)
    }
    
    func testNavigateToAlert() {
        self.sut.navigateToAlert(title: "Title", message: "Message", actions: [UIAlertAction(title: "Cancel", style: .cancel, handler: nil)])
        XCTAssertTrue(self.viewControllerSpy.presentCalled)
    }
}
