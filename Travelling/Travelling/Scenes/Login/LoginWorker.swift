//
//  LoginWorker.swift
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

protocol LoginWorkerDelegate: class {
    func successDidLoginUser(user: User)
    func failureDidLoginUser(details: LoginModels.LoginDetails, error: OperationError)
}

class LoginWorker {
    weak var delegate: LoginWorkerDelegate?
    
    var authenticationTask: AuthenticationTaskProtocol = TaskConfigurator.shared.authenticationTask()
    
    init(delegate: LoginWorkerDelegate?) {
        self.delegate = delegate
    }
    
    func loginUser(details: LoginModels.LoginDetails) {
        self.authenticationTask.loginUser(model: AuthenticationTaskModels.LoginUser.Request(account: details.account, password: details.password)) { result in
            switch result {
                case .success(let response): self.delegate?.successDidLoginUser(user: response.user); break
                case .failure(let error): self.delegate?.failureDidLoginUser(details: details, error: error); break
            }
        }
    }
}
