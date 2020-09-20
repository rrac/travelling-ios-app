//
//  ExplorePresenterTests.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 13/09/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling
import XCTest

class ExplorePresenterTests: XCTestCase {
    var sut: ExplorePresenter!
    var displayerSpy: ExploreDisplayLogicSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupExplorePresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupExplorePresenter() {
        self.sut = ExplorePresenter()
        
        self.displayerSpy = ExploreDisplayLogicSpy()
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
        self.sut.presentItems(response: ExploreModels.ItemsPresentation.Response(items: []))
        XCTAssertTrue(self.displayerSpy.displayItemsCalled)
    }
    
    func testPresentItemsShouldFormatItemsForDisplay() {
        let item = Place(id: "id1", location: Location(id: "id2", latitude: 10, longitude: 10))
        let items = [item]
        self.sut.presentItems(response: ExploreModels.ItemsPresentation.Response(items: items))
        
        XCTAssertEqual(self.displayerSpy.displayItemsViewModel.displayedItems.count, items.count)
        for displayedItem in self.displayerSpy.displayItemsViewModel.displayedItems {
            XCTAssertEqual(displayedItem.id, item.id)
        }
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
        self.sut.presentWillFetchImage(response: ExploreModels.ImageFetching.Response(item: ExploreModels.DisplayedItem(id: "id")))
        XCTAssertTrue(self.displayerSpy.displayWillFetchImageCalled)
    }
    
    func testPresentDidFetchImageShouldAskTheDisplayerToDisplayDidFetchImage() {
        self.sut.presentDidFetchImage(response: ExploreModels.ImageFetching.Response(item: ExploreModels.DisplayedItem(id: "id")))
        XCTAssertTrue(self.displayerSpy.displayDidFetchImageCalled)
    }
    
    func testPresentImageShouldAskTheDisplayerToDisplayImage() {
        self.sut.presentImage(response: ExploreModels.ImagePresentation.Response(item: ExploreModels.DisplayedItem(id: "id"), image: nil))
        XCTAssertTrue(self.displayerSpy.displayImageCalled)
    }
    
    func testPresentPlaceholderImageShouldAskTheDisplayerToDisplayImage() {
        self.sut.presentPlaceholderImage(response: ExploreModels.ImagePresentation.Response(item: ExploreModels.DisplayedItem(id: "id"), image: nil))
        XCTAssertTrue(self.displayerSpy.displayImageCalled)
    }
}
