//
//  SignUpPresenter.swift
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

protocol SignUpPresentationLogic {
    func presentSetupItems()
    
    func presentUpdateItem(response: SignUpModels.UpdateItem.Response)
    func presentValidationError(response: SignUpModels.ValidateItem.Response)
    
    func presentActivateTextField(response: SignUpModels.ActivateTextField.Response)
    
    func presentUpdateImageItem(response: SignUpModels.UpdateImageItem.Response)
    func presentUpdatePlaceholderImageItem(response: SignUpModels.UpdatePlaceholderImageItem.Response)
    
    func presentEnableItem(response: SignUpModels.EnableItem.Response)
    func presentDisableItem(response: SignUpModels.EnableItem.Response)
    
    func presentPhotoLibraryAlert(response: SignUpModels.SourceView.Response)
    func presentPhotoLibraryCameraAlert(response: SignUpModels.SourceView.Response)
    func presentPhotoLibraryRemovePhotoAlert(response: SignUpModels.SourceView.Response)
    func presentPhotoLibraryCameraRemovePhotoAlert(response: SignUpModels.SourceView.Response)
    
    func presentCameraAlert(response: SignUpModels.SourceView.Response)
    func presentCameraRemovePhotoAlert(response: SignUpModels.SourceView.Response)
    
    func presentNavigateToPhotoLibrary(response: SignUpModels.SourceView.Response)
    func presentNavigateToCamera(response: SignUpModels.SourceView.Response)
    
    func presentLoadingItem(response: SignUpModels.LoadingItem.Response)
    func presentNotLoadingItem(response: SignUpModels.LoadingItem.Response)
    
    func presentEnableUserInteraction()
    func presentDisableUserInteraction()
    
    func presentUserDetails(response: SignUpModels.SignUpUser.Response)
    func presentErrorDetails(response: SignUpModels.SignUpError.Response)
}

class SignUpPresenter: SignUpPresentationLogic {
    weak var displayer: SignUpDisplayLogic?
    
    func presentSetupItems() {
        let viewModel = SignUpModels.SetupItems.ViewModel(displayedItems: self.items())
        self.displayer?.displaySetupItems(viewModel: viewModel)
    }
    
    private func items() -> [SignUpModels.Item] {
        return [
            self.photoItem(),
            self.emailItem(),
            self.usernameItem(),
            self.passwordItem(),
            self.firstNameItem(),
            self.lastNameItem(),
            self.descriptionItem(),
            self.signUpItem()
        ]
    }
    
    private func photoItem() -> SignUpModels.Item {
        let model = SignUpModels.DisplayedImageItem()
        model.image = SignUpStyle.shared.photoCellModel.placeholderImage
        model.contentMode = .center
        return SignUpModels.Item(type: SignUpModels.ItemType.photo, model: model)
    }
    
    private func emailItem() -> SignUpModels.Item {
        let model = SignUpModels.DisplayedTextItem()
        model.title = SignUpLocalization.shared.emailTitle
        model.placeholder = SignUpLocalization.shared.emailPlaceholder
        model.keyboardType = .emailAddress
        model.autocapitalizationType = .none
        model.autocorrectionType = .no
        model.errorText = SignUpLocalization.shared.emailErrorText
        return SignUpModels.Item(type: SignUpModels.ItemType.email, model: model)
    }
    
    private func usernameItem() -> SignUpModels.Item {
        let model = SignUpModels.DisplayedTextItem()
        model.title = SignUpLocalization.shared.usernameTitle
        model.placeholder = SignUpLocalization.shared.usernamePlaceholder
        model.keyboardType = .alphabet
        model.autocapitalizationType = .none
        model.autocorrectionType = .no
        model.errorText = SignUpLocalization.shared.usernameErrorText
        return SignUpModels.Item(type: SignUpModels.ItemType.username, model: model)
    }
    
    private func passwordItem() -> SignUpModels.Item {
        let model = SignUpModels.DisplayedTextItem()
        model.title = SignUpLocalization.shared.passwordTitle
        model.placeholder = SignUpLocalization.shared.passwordPlaceholder
        model.autocapitalizationType = .none
        model.autocorrectionType = .no
        model.isSecureText = true
        model.errorText = SignUpLocalization.shared.passwordErrorText
        return SignUpModels.Item(type: SignUpModels.ItemType.password, model: model)
    }
    
    private func firstNameItem() -> SignUpModels.Item {
        let model = SignUpModels.DisplayedTextItem()
        model.title = SignUpLocalization.shared.firstNameTitle
        model.placeholder = SignUpLocalization.shared.firstNamePlaceholder
        model.autocapitalizationType = .words
        model.autocorrectionType = .yes
        model.errorText = SignUpLocalization.shared.firstNameErrorText
        return SignUpModels.Item(type: SignUpModels.ItemType.firstName, model: model)
    }
    
    private func lastNameItem() -> SignUpModels.Item {
        let model = SignUpModels.DisplayedTextItem()
        model.title = SignUpLocalization.shared.lastNameTitle
        model.placeholder = SignUpLocalization.shared.lastNamePlaceholder
        model.autocapitalizationType = .words
        model.autocorrectionType = .yes
        model.errorText = SignUpLocalization.shared.lastNameErrorText
        return SignUpModels.Item(type: SignUpModels.ItemType.lastName, model: model)
    }
    
    private func descriptionItem() -> SignUpModels.Item {
        let model = SignUpModels.DisplayedTextItem()
        model.title = SignUpLocalization.shared.descriptionTitle
        model.placeholder = SignUpLocalization.shared.descriptionPlaceholder
        model.autocapitalizationType = .sentences
        model.autocorrectionType = .yes
        return SignUpModels.Item(type: SignUpModels.ItemType.description, model: model)
    }
    
    private func signUpItem() -> SignUpModels.Item {
        let model = SignUpModels.DisplayedButtonItem()
        model.title = SignUpLocalization.shared.signUpButtonTitle.attributed(attributes: SignUpStyle.shared.buttonCellModel.textAttributes())
        model.isEnabled = false
        return SignUpModels.Item(type: SignUpModels.ItemType.signUp, model: model)
    }
    
    func presentUpdateItem(response: SignUpModels.UpdateItem.Response) {
        let viewModel = SignUpModels.UpdateItem.ViewModel(text: response.text, type: response.type)
        self.displayer?.displayUpdateItem(viewModel: viewModel)
    }
    
    func presentValidationError(response: SignUpModels.ValidateItem.Response) {
        let viewModel = SignUpModels.ValidateItem.ViewModel(type: response.type, displayError: response.displayError)
        self.displayer?.displayValidationError(viewModel: viewModel)
    }
    
    func presentUpdateImageItem(response: SignUpModels.UpdateImageItem.Response) {
        self.displayer?.displayUpdateImageItem(viewModel: SignUpModels.UpdateImageItem.ViewModel(image: response.image, contentMode: .scaleAspectFill, type: response.type))
    }
    
    func presentUpdatePlaceholderImageItem(response: SignUpModels.UpdatePlaceholderImageItem.Response) {
        self.displayer?.displayUpdateImageItem(viewModel: SignUpModels.UpdateImageItem.ViewModel(image: SignUpStyle.shared.photoCellModel.placeholderImage, contentMode: .center, type: response.type))
    }
    
    func presentActivateTextField(response: SignUpModels.ActivateTextField.Response) {
        self.displayer?.displayActivateTextField(viewModel: SignUpModels.ActivateTextField.ViewModel(type: response.type))
    }
    
    func presentEnableItem(response: SignUpModels.EnableItem.Response) {
        self.displayer?.displayEnableItem(viewModel: SignUpModels.EnableItem.ViewModel(type: response.type))
    }
    
    func presentDisableItem(response: SignUpModels.EnableItem.Response) {
        self.displayer?.displayDisableItem(viewModel: SignUpModels.EnableItem.ViewModel(type: response.type))
    }
    
    func presentPhotoLibraryAlert(response: SignUpModels.SourceView.Response) {
        let photoLibraryTitle = SignUpLocalization.shared.photoLibraryTitle
        let cancelTitle = SignUpLocalization.shared.cancelTitle
        let viewModel = SignUpModels.PhotoLibraryAlert.ViewModel(photoLibraryTitle: photoLibraryTitle, cancelTitle: cancelTitle, sourceView: response.sourceView)
        self.displayer?.displayPhotoLibraryAlert(viewModel: viewModel)
    }
    
    func presentPhotoLibraryCameraAlert(response: SignUpModels.SourceView.Response) {
        let photoLibraryTitle = SignUpLocalization.shared.photoLibraryTitle
        let cameraTitle = SignUpLocalization.shared.cameraTitle
        let cancelTitle = SignUpLocalization.shared.cancelTitle
        let viewModel = SignUpModels.PhotoLibraryCameraAlert.ViewModel(photoLibraryTitle: photoLibraryTitle, cameraTitle: cameraTitle, cancelTitle: cancelTitle, sourceView: response.sourceView)
        self.displayer?.displayPhotoLibraryCameraAlert(viewModel: viewModel)
    }
    
    func presentPhotoLibraryRemovePhotoAlert(response: SignUpModels.SourceView.Response) {
        let photoLibraryTitle = SignUpLocalization.shared.photoLibraryTitle
        let removePhotoTitle = SignUpLocalization.shared.removePhotoTitle
        let cancelTitle = SignUpLocalization.shared.cancelTitle
        let viewModel = SignUpModels.PhotoLibraryRemovePhotoAlert.ViewModel(photoLibraryTitle: photoLibraryTitle, removePhotoTitle: removePhotoTitle, cancelTitle: cancelTitle, sourceView: response.sourceView)
        self.displayer?.displayPhotoLibraryRemovePhotoAlert(viewModel: viewModel)
    }
    
    func presentPhotoLibraryCameraRemovePhotoAlert(response: SignUpModels.SourceView.Response) {
        let photoLibraryTitle = SignUpLocalization.shared.photoLibraryTitle
        let cameraTitle = SignUpLocalization.shared.cameraTitle
        let removePhotoTitle = SignUpLocalization.shared.removePhotoTitle
        let cancelTitle = SignUpLocalization.shared.cancelTitle
        let viewModel = SignUpModels.PhotoLibraryCameraRemovePhotoAlert.ViewModel(photoLibraryTitle: photoLibraryTitle, cameraTitle: cameraTitle, removePhotoTitle: removePhotoTitle, cancelTitle: cancelTitle, sourceView: response.sourceView)
        self.displayer?.displayPhotoLibraryCameraRemovePhotoAlert(viewModel: viewModel)
    }
    
    func presentCameraAlert(response: SignUpModels.SourceView.Response) {
        let cameraTitle = SignUpLocalization.shared.cameraTitle
        let cancelTitle = SignUpLocalization.shared.cancelTitle
        let viewModel = SignUpModels.CameraAlert.ViewModel(cameraTitle: cameraTitle, cancelTitle: cancelTitle, sourceView: response.sourceView)
        self.displayer?.displayCameraAlert(viewModel: viewModel)
    }
    
    func presentCameraRemovePhotoAlert(response: SignUpModels.SourceView.Response) {
        let cameraTitle = SignUpLocalization.shared.cameraTitle
        let removePhotoTitle = SignUpLocalization.shared.removePhotoTitle
        let cancelTitle = SignUpLocalization.shared.cancelTitle
        let viewModel = SignUpModels.CameraRemovePhotoAlert.ViewModel(cameraTitle: cameraTitle, removePhotoTitle: removePhotoTitle, cancelTitle: cancelTitle, sourceView: response.sourceView)
        self.displayer?.displayCameraRemovePhotoAlert(viewModel: viewModel)
    }
    
    func presentNavigateToPhotoLibrary(response: SignUpModels.SourceView.Response) {
        self.displayer?.displayNavigateToPhotoLibrary(viewModel: SignUpModels.SourceView.ViewModel(sourceView: response.sourceView))
    }
    
    func presentNavigateToCamera(response: SignUpModels.SourceView.Response) {
        self.displayer?.displayNavigateToCamera(viewModel: SignUpModels.SourceView.ViewModel(sourceView: response.sourceView))
    }
    
    func presentLoadingItem(response: SignUpModels.LoadingItem.Response) {
        self.displayer?.displayLoadingItem(viewModel: SignUpModels.LoadingItem.ViewModel(type: response.type))
    }
    
    func presentNotLoadingItem(response: SignUpModels.LoadingItem.Response) {
        self.displayer?.displayNotLoadingItem(viewModel: SignUpModels.LoadingItem.ViewModel(type: response.type))
    }
    
    func presentEnableUserInteraction() {
        self.displayer?.displayEnableUserInteraction()
    }
    
    func presentDisableUserInteraction() {
        self.displayer?.displayDisableUserInteraction()
    }
    
    func presentUserDetails(response: SignUpModels.SignUpUser.Response) {
        self.displayer?.displayUserDetails(viewModel: SignUpModels.SignUpUser.ViewModel(user: response.user))
    }
    
    func presentErrorDetails(response: SignUpModels.SignUpError.Response) {
        let message = SignUpLocalization.shared.errorMessage
        let okTitle = SignUpLocalization.shared.okTitle
        let viewModel = SignUpModels.SignUpError.ViewModel(message: message, okTitle: okTitle)
        self.displayer?.displayErrorDetails(viewModel: viewModel)
    }
}
