//
//  SignUpLocalization.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 06/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class SignUpLocalization {
    static let shared = SignUpLocalization()
    
    private init() {
        
    }
    
    struct LocalizedKey {
        static let
        signUpTitle = "SignUp.scene.title",
        
        uploadPhotoTitle = "SignUp.scene.upload.photo.title",
        emailTitle = "SignUp.scene.email.title",
        usernameTitle = "SignUp.scene.username.title",
        passwordTitle = "SignUp.scene.password.title",
        firstNameTitle = "SignUp.scene.first.name.title",
        lastNameTitle = "SignUp.scene.last.name.title",
        descriptionTitle = "SignUp.scene.description.title",
        
        emailPlaceholder = "SignUp.scene.email.placeholder",
        usernamePlaceholder = "SignUp.scene.username.placeholder",
        passwordPlaceholder = "SignUp.scene.password.placeholder",
        firstNamePlaceholder = "SignUp.scene.first.name.placeholder",
        lastNamePlaceholder = "SignUp.scene.last.name.placeholder",
        descriptionPlaceholder = "SignUp.scene.description.placeholder",
        
        signUpButtonTitle = "SignUp.scene.button.title",
        
        emailErrorText = "SignUp.scene.email.error.text",
        usernameErrorText = "SignUp.scene.username.error.text",
        passwordErrorText = "SignUp.scene.password.error.text",
        firstNameErrorText = "SignUp.scene.first.name.error.text",
        lastNameErrorText = "SignUp.scene.last.name.error.text",
        
        photoLibraryTitle = "SignUp.scene.photo.library.title",
        cameraTitle = "SignUp.scene.camera.title",
        removePhotoTitle = "SignUp.scene.remove.photo.title",
        cancelTitle = "SignUp.scene.cancel.title",
        
        errorMessage = "SignUp.scene.generic.error.message",
        okTitle = "SignUp.scene.ok.title"
    }
    
    let signUpTitle = LocalizedKey.signUpTitle.localized()
    
    let uploadPhotoTitle = LocalizedKey.uploadPhotoTitle.localized()
    let emailTitle = LocalizedKey.emailTitle.localized()
    let usernameTitle = LocalizedKey.usernameTitle.localized()
    let passwordTitle = LocalizedKey.passwordTitle.localized()
    let firstNameTitle = LocalizedKey.firstNameTitle.localized()
    let lastNameTitle = LocalizedKey.lastNameTitle.localized()
    let descriptionTitle = LocalizedKey.descriptionTitle.localized()
    
    let emailPlaceholder = LocalizedKey.emailPlaceholder.localized()
    let usernamePlaceholder = LocalizedKey.usernamePlaceholder.localized()
    let passwordPlaceholder = LocalizedKey.passwordPlaceholder.localized()
    let firstNamePlaceholder = LocalizedKey.firstNamePlaceholder.localized()
    let lastNamePlaceholder = LocalizedKey.lastNamePlaceholder.localized()
    let descriptionPlaceholder = LocalizedKey.descriptionPlaceholder.localized()
    
    let signUpButtonTitle = LocalizedKey.signUpButtonTitle.localized()
    
    let emailErrorText = LocalizedKey.emailErrorText.localized()
    let usernameErrorText = LocalizedKey.usernameErrorText.localized()
    let passwordErrorText = LocalizedKey.passwordErrorText.localized()
    let firstNameErrorText = LocalizedKey.firstNameErrorText.localized()
    let lastNameErrorText = LocalizedKey.lastNameErrorText.localized()
    
    let photoLibraryTitle = LocalizedKey.photoLibraryTitle.localized()
    let cameraTitle = LocalizedKey.cameraTitle.localized()
    let removePhotoTitle = LocalizedKey.removePhotoTitle.localized()
    let cancelTitle = LocalizedKey.cancelTitle.localized()
    
    let errorMessage = LocalizedKey.errorMessage.localized()
    let okTitle = LocalizedKey.okTitle.localized()
}
