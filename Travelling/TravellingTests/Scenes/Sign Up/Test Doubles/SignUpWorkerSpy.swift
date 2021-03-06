//
//  SignUpWorkerSpy.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 06/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling

class SignUpWorkerSpy: SignUpWorker {
    var signUpUserCalled: Bool = false
    
    override func signUpUser(details: SignUpModels.UserDetails) {
        self.signUpUserCalled = true
    }
}
