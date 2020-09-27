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
    var viewController: MyProfileViewController!
    
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
        
        self.viewController = MyProfileViewController()
        self.sut.viewController = self.viewController
    }
    
    // MARK: - Tests
    
    
}
