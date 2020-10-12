//
//  MyFavoritePlacesPresenterTests.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 11/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling
import XCTest

class MyFavoritePlacesPresenterTests: XCTestCase {
    var sut: MyFavoritePlacesPresenter!
    var displayerSpy: MyFavoritePlacesDisplayLogicSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupMyFavoritePlacesPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupMyFavoritePlacesPresenter() {
        self.sut = MyFavoritePlacesPresenter()
        
        self.displayerSpy = MyFavoritePlacesDisplayLogicSpy()
        self.sut.displayer = self.displayerSpy
    }
    
    // MARK: - Tests
    
    func testPresentWillFetchItemsShouldAskTheDisplayerToDisplayWillFetchItems() {
        self.sut.presentWillFetchItems()
        XCTAssertTrue(self.displayerSpy.displayWillFetchItemsCalled)
    }
    
    func testPresentDidFetchItemsShouldAskTheDisplayerToDisplayDidFetchItems() {
        self.sut.presentDidFetchItems()
        XCTAssertTrue(self.displayerSpy.displayDidFetchItemsCalled)
    }
    
    func testPresentItemsShouldAskTheDisplayerToDisplayItems() {
        self.sut.presentItems(response: MyFavoritePlacesModels.ItemsPresentation.Response(items: []))
        XCTAssertTrue(self.displayerSpy.displayItemsCalled)
    }
    
    func testPresentItemsShouldFormatItemsForDisplay() {
        let item = Place(id: "id1", location: Location(id: "id2", latitude: 10, longitude: 10))
        let items = [item]
        self.sut.presentItems(response: MyFavoritePlacesModels.ItemsPresentation.Response(items: items))
        
        XCTAssertEqual(self.displayerSpy.displayItemsViewModel.displayedItems.count, items.count)
        for displayedItem in self.displayerSpy.displayItemsViewModel.displayedItems {
            XCTAssertEqual(displayedItem.id, item.id)
        }
    }
    
    func testPresentNewItemsShouldAskTheDisplayerToDisplayNewItems() {
        self.sut.presentNewItems(response: MyFavoritePlacesModels.ItemsPresentation.Response(items: []))
        XCTAssertTrue(self.displayerSpy.displayNewItemsCalled)
    }
    
    func testPresentNewItemsShouldFormatItemsForDisplay() {
        let item = Place(id: "id1", location: Location(id: "id2", latitude: 10, longitude: 10))
        let items = [item]
        self.sut.presentNewItems(response: MyFavoritePlacesModels.ItemsPresentation.Response(items: items))
        
        XCTAssertEqual(self.displayerSpy.displayNewItemsViewModel.displayedItems.count, items.count)
        for displayedItem in self.displayerSpy.displayNewItemsViewModel.displayedItems {
            XCTAssertEqual(displayedItem.id, item.id)
        }
    }
    
    func testPresentSearchedItemsShouldAskTheDisplayerToDisplayItems() {
        self.sut.presentSearchedItems(response: MyFavoritePlacesModels.ItemsSearching.Response(text: "text", items: []))
        XCTAssertTrue(self.displayerSpy.displayItemsCalled)
    }
    
    func testPresentResetItemsShouldAskTheDisplayerToResetItems() {
        self.sut.presentResetItems()
        XCTAssertTrue(self.displayerSpy.displayResetItemsCalled)
    }
    
    func testPresentNoMoreItemsShouldAskTheDisplayerToDisplayNoMoreItems() {
        self.sut.presentNoMoreItems()
        XCTAssertTrue(self.displayerSpy.displayNoMoreItemsCalled)
    }
    
    func testPresentRemoveNoMoreItemsShouldAskTheDisplayerToDisplayRemoveNoMoreItems() {
        self.sut.presentRemoveNoMoreItems()
        XCTAssertTrue(self.displayerSpy.displayRemoveNoMoreItemsCalled)
    }
    
    func testPresentEmptyStateShouldAskTheDisplayerToDisplayEmptyState() {
        self.sut.presentEmptyState()
        XCTAssertTrue(self.displayerSpy.displayEmptyStateCalled)
    }
    
    func testPresentRemoveEmptyStateShouldAskTheDisplayerToDisplayRemoveEmptyState() {
        self.sut.presentRemoveEmptyState()
        XCTAssertTrue(self.displayerSpy.displayRemoveEmptyStateCalled)
    }
    
    func testPresentErrorStateShouldAskTheDisplayerToDisplayErrorState() {
        self.sut.presentErrorState()
        XCTAssertTrue(self.displayerSpy.displayErrorStateCalled)
    }
    
    func testPresentRemoveErrorStateShouldAskTheDisplayerToDisplayRemoveErrorState() {
        self.sut.presentRemoveErrorState()
        XCTAssertTrue(self.displayerSpy.displayRemoveErrorStateCalled)
    }
    
    func testPresentWillFetchImageShouldAskTheDisplayerToDisplayWillFetchImage() {
        self.sut.presentWillFetchImage(response: MyFavoritePlacesModels.ImageFetching.Response(item: MyFavoritePlacesModels.DisplayedItem(id: "id")))
        XCTAssertTrue(self.displayerSpy.displayWillFetchImageCalled)
    }
    
    func testPresentDidFetchImageShouldAskTheDisplayerToDisplayDidFetchImage() {
        self.sut.presentDidFetchImage(response: MyFavoritePlacesModels.ImageFetching.Response(item: MyFavoritePlacesModels.DisplayedItem(id: "id")))
        XCTAssertTrue(self.displayerSpy.displayDidFetchImageCalled)
    }
    
    func testPresentImageShouldAskTheDisplayerToDisplayImage() {
        self.sut.presentImage(response: MyFavoritePlacesModels.ImagePresentation.Response(item: MyFavoritePlacesModels.DisplayedItem(id: "id"), image: nil))
        XCTAssertTrue(self.displayerSpy.displayImageCalled)
    }
    
    func testPresentPlaceholderImageShouldAskTheDisplayerToDisplayImage() {
        self.sut.presentPlaceholderImage(response: MyFavoritePlacesModels.ImagePresentation.Response(item: MyFavoritePlacesModels.DisplayedItem(id: "id"), image: nil))
        XCTAssertTrue(self.displayerSpy.displayImageCalled)
    }
    
    func testPresentEnableSearchBarShouldAskTheDisplayerToDisplayEnableSearchBar() {
        self.sut.presentEnableSearchBar()
        XCTAssertTrue(self.displayerSpy.displayEnableSearchBarCalled)
    }
    
    func testPresentDisableSearchBarShouldAskTheDisplayerToDisplayDisableSearchBar() {
        self.sut.presentDisableSearchBar()
        XCTAssertTrue(self.displayerSpy.displayDisableSearchBarCalled)
    }
    
    func testPresentNavigateToPlaceDetailsShouldAskTheDisplayerToDisplayNavigateToPlaceDetails() {
        self.sut.presentNavigateToPlaceDetails(response: MyFavoritePlacesModels.ItemNavigation.Response(place: Place(id: "placeId", location: Location(id: "locationId", latitude: 47, longitude: 27))))
        XCTAssertTrue(self.displayerSpy.displayNavigateToPlaceDetailsCalled)
    }
    
    func testPresentDeleteItemShouldAskTheDisplayerToDisplayDeleteItem() {
        self.sut.presentDeleteItem(response: MyFavoritePlacesModels.ItemDelete.Response(id: "id"))
        XCTAssertTrue(self.displayerSpy.displayDeleteItemCalled)
    }
}
