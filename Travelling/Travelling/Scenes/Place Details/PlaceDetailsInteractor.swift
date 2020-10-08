//
//  PlaceDetailsInteractor.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 08/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PlaceDetailsBusinessLogic {
    func shouldSetupPlace(request: PlaceDetailsModels.PlaceSetup.Request)
    func shouldRefreshPlace()
    
    func shouldFetchImage(request: PlaceDetailsModels.ImageFetching.Request)
}

class PlaceDetailsInteractor: PlaceDetailsBusinessLogic, PlaceDetailsWorkerDelegate {
    var presenter: PlaceDetailsPresentationLogic?
    var worker: PlaceDetailsWorker?
    
    var isFetchingPlace: Bool = false
    var place: Place?
    
    init() {
        self.worker = PlaceDetailsWorker(delegate: self)
    }
    
    func shouldRefreshPlace() {
        if self.isFetchingPlace {
            return
        }
        
        self.isFetchingPlace = true
        self.presenter?.presentResetPlace()
        self.presenter?.presentRemoveErrorState()
        self.presenter?.presentWillFetchPlace()
        self.worker?.fetchPlace(placeId: self.place?.id)
    }
}

// MARK: - Fetch place

extension PlaceDetailsInteractor {
    func shouldSetupPlace(request: PlaceDetailsModels.PlaceSetup.Request) {
        self.place = request.place
        
        self.presenter?.presentRemoveErrorState()
        self.presenter?.presentPlace(response: PlaceDetailsModels.PlacePresentation.Response(place: request.place))
    }
    
    func successDidFetchPlace(place: Place) {
        self.isFetchingPlace = false
        self.place = place
        self.presenter?.presentPlace(response: PlaceDetailsModels.PlacePresentation.Response(place: place))
        self.presenter?.presentRemoveErrorState()
        self.presenter?.presentDidFetchPlace()
    }
    
    func failureDidFetchPlace(error: OperationError) {
        self.isFetchingPlace = false
        self.presenter?.presentErrorState()
        self.presenter?.presentDidFetchPlace()
    }
}

// MARK: - Fetch image

extension PlaceDetailsInteractor {
    func shouldFetchImage(request: PlaceDetailsModels.ImageFetching.Request) {
        let model = request.model
        if model.image == nil && model.imageName.isNilOrEmpty() {
            self.presenter?.presentPlaceholderImage(response: PlaceDetailsModels.ImagePresentation.Response(model: model, image: nil))
        } else if model.image == nil && !model.imageName.isNilOrEmpty() && !model.isLoadingImage {
            self.presenter?.presentWillFetchImage(response: PlaceDetailsModels.ImageFetching.Response(model: model))
            self.worker?.fetchImage(model: model)
        }
    }
    
    func successDidFetchImage(model: PlaceDetailsModels.PhotoModel, image: UIImage?) {
        self.presenter?.presentImage(response: PlaceDetailsModels.ImagePresentation.Response(model: model, image: image))
        self.presenter?.presentDidFetchImage(response: PlaceDetailsModels.ImageFetching.Response(model: model))
    }
    
    func failureDidFetchImage(model: PlaceDetailsModels.PhotoModel, error: OperationError) {
        self.presenter?.presentPlaceholderImage(response: PlaceDetailsModels.ImagePresentation.Response(model: model, image: nil))
        self.presenter?.presentDidFetchImage(response: PlaceDetailsModels.ImageFetching.Response(model: model))
    }
}
