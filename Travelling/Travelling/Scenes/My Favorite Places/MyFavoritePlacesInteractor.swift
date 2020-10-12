//
//  MyFavoritePlacesInteractor.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 11/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MyFavoritePlacesBusinessLogic {
    func shouldFetchItems()
    func shouldFetchImage(request: MyFavoritePlacesModels.ImageFetching.Request)
    
    func shouldBeginSearchState()
    func shouldEndSearchState()
    func shouldSearchItems(request: MyFavoritePlacesModels.ItemsSearching.Request)
    
    func shouldNavigateToPlaceDetails(request: MyFavoritePlacesModels.ItemNavigation.Request)
    
    func shouldLoginUser(request: MyFavoritePlacesModels.UserLogin.Request)
    func shouldLogoutUser()
}

class MyFavoritePlacesInteractor: MyFavoritePlacesBusinessLogic, MyFavoritePlacesWorkerDelegate {
    var presenter: MyFavoritePlacesPresentationLogic?
    var worker: MyFavoritePlacesWorker?
    
    var user: User?
    var paginationModel: MyFavoritePlacesModels.PaginationModel
    var userDefaultsManager = UserDefaultsManager.shared
    
    init() {
        self.user = self.userDefaultsManager.user()
        self.paginationModel = MyFavoritePlacesModels.PaginationModel()
        self.worker = MyFavoritePlacesWorker(delegate: self)
    }
    
    func shouldBeginSearchState() {
        self.paginationModel.isSearchingItems = true
    }
    
    func shouldEndSearchState() {
        self.paginationModel.isSearchingItems = false
    }
    
    func shouldSearchItems(request: MyFavoritePlacesModels.ItemsSearching.Request) {
        if let text = request.text, !text.isEmpty {
            let searchedItems = self.paginationModel.items.filter({ $0.name?.contains(text: text) == true })
            self.presenter?.presentSearchedItems(response: MyFavoritePlacesModels.ItemsSearching.Response(text: text, items: searchedItems))
        } else {
            self.presenter?.presentItems(response: MyFavoritePlacesModels.ItemsPresentation.Response(items: self.paginationModel.items))
        }
    }
    
    func shouldNavigateToPlaceDetails(request: MyFavoritePlacesModels.ItemNavigation.Request) {
        if let place = self.paginationModel.items.first(where: { $0.id == request.id }) {
            self.presenter?.presentNavigateToPlaceDetails(response: MyFavoritePlacesModels.ItemNavigation.Response(place: place))
        }
    }
    
    func shouldLoginUser(request: MyFavoritePlacesModels.UserLogin.Request) {
        self.user = request.user
        
        self.resetPaginationModel()
        self.presenter?.presentRemoveEmptyState()
        self.presenter?.presentResetItems()
        self.shouldFetchItems()
    }
    
    private func resetPaginationModel() {
        self.paginationModel.isFetchingItems = false
        self.paginationModel.noMoreItems = false
        self.paginationModel.hasError = false
        self.paginationModel.isSearchingItems = false
        self.paginationModel.currentPage = 0
        self.paginationModel.limit = 10
        self.paginationModel.items = []
    }
        
    func shouldLogoutUser() {
        self.user = nil
        self.presenter?.presentResetItems()
    }
}

extension MyFavoritePlacesInteractor {
    func shouldFetchImage(request: MyFavoritePlacesModels.ImageFetching.Request) {
        let item = request.item
        if item.image == nil && item.imageName.isNilOrEmpty() {
            self.presenter?.presentPlaceholderImage(response: MyFavoritePlacesModels.ImagePresentation.Response(item: item, image: nil))
        } else if item.image == nil && !item.imageName.isNilOrEmpty() && !item.isLoadingImage {
            self.presenter?.presentWillFetchImage(response: MyFavoritePlacesModels.ImageFetching.Response(item: item))
            self.worker?.fetchImage(item: item)
        }
    }
    
    func successDidFetchImage(item: MyFavoritePlacesModels.DisplayedItem, image: UIImage?) {
        self.presenter?.presentImage(response: MyFavoritePlacesModels.ImagePresentation.Response(item: item, image: image))
        self.presenter?.presentDidFetchImage(response: MyFavoritePlacesModels.ImageFetching.Response(item: item))
    }
    
    func failureDidFetchImage(item: MyFavoritePlacesModels.DisplayedItem, error: OperationError) {
        self.presenter?.presentPlaceholderImage(response: MyFavoritePlacesModels.ImagePresentation.Response(item: item, image: nil))
        self.presenter?.presentDidFetchImage(response: MyFavoritePlacesModels.ImageFetching.Response(item: item))
    }
}

extension MyFavoritePlacesInteractor  {
    func shouldFetchItems() {
        if self.paginationModel.isSearchingItems {
            return
        }
        
        guard let user = self.user else {
            return
        }
        
        if !self.paginationModel.isFetchingItems && !self.paginationModel.noMoreItems {
            self.paginationModel.isFetchingItems = true
            self.presenter?.presentWillFetchItems()
            self.presenter?.presentDisableSearchBar()
            self.worker?.fetchItems(userId: user.id, page: self.paginationModel.currentPage, limit: self.paginationModel.limit)
        }
    }
    
    func successDidFetchItems(items: [Place]) {
        self.paginationModel.items.append(contentsOf: items)
        self.paginationModel.currentPage += 1
        self.paginationModel.isFetchingItems = false
        self.paginationModel.hasError = false
        self.presenter?.presentDidFetchItems()
        self.presenter?.presentEnableSearchBar()
        self.presenter?.presentRemoveErrorState()
        self.presenter?.presentNewItems(response: MyFavoritePlacesModels.ItemsPresentation.Response(items: items))
        self.shouldVerifyNoMorePlaces(count: items.count)
        self.shouldVerifyEmptyState(count: items.count)
    }
    
    func failureDidFetchItems(error: OperationError) {
        self.paginationModel.isFetchingItems = false
        self.paginationModel.hasError = true
        self.presenter?.presentDidFetchItems()
        self.presenter?.presentEnableSearchBar()
        self.presenter?.presentErrorState()
    }
}

extension MyFavoritePlacesInteractor {
    private func shouldVerifyNoMorePlaces(count: Int) {
        if count < self.paginationModel.limit {
            self.paginationModel.noMoreItems = true
            self.presenter?.presentNoMoreItems()
        }
    }
    
    private func shouldVerifyEmptyState(count: Int) {
        if count == 0 && self.paginationModel.items.count == 0 {
            self.presenter?.presentEmptyState()
            self.presenter?.presentRemoveNoMoreItems()
        }
    }
}
