//
//  ForgotPasswordWorker.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 05/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ForgotPasswordWorkerDelegate: class {
    func successDidSendResetLink(email: String)
    func failureDidSendResetLink(email: String, error: OperationError)
}

class ForgotPasswordWorker {
    weak var delegate: ForgotPasswordWorkerDelegate?
    
    var authenticationTask: AuthenticationTaskProtocol = TaskConfigurator.shared.authenticationTask()
    
    init(delegate: ForgotPasswordWorkerDelegate?) {
        self.delegate = delegate
    }
    
    func sendResetLink(email: String) {
        self.authenticationTask.forgotPassword(model: AuthenticationTaskModels.ForgotPassword.Request(email: email)) { result in
            switch result {
                case .success(_): self.delegate?.successDidSendResetLink(email: email); break
                case .failure(let error): self.delegate?.failureDidSendResetLink(email: email, error: error); break
            }
        }
    }
}
