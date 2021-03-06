//
//  PlaceCommentsPresenterTests.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 12/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling
import XCTest

class PlaceCommentsPresenterTests: XCTestCase {
    var sut: PlaceCommentsPresenter!
    var displayerSpy: PlaceCommentsDisplayLogicSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupPlaceCommentsPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPlaceCommentsPresenter() {
        self.sut = PlaceCommentsPresenter()
        
        self.displayerSpy = PlaceCommentsDisplayLogicSpy()
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
        self.sut.presentItems(response: PlaceCommentsModels.ItemsPresentation.Response(items: []))
        XCTAssertTrue(self.displayerSpy.displayItemsCalled)
    }
    
    func testPresentItemsShouldFormatItemsForDisplay() {
        let item = Comment(id: "id")
        let items = [item]
        self.sut.presentItems(response: PlaceCommentsModels.ItemsPresentation.Response(items: items))
        
        XCTAssertEqual(self.displayerSpy.displayItemsViewModel.displayedItems.count, items.count)
        for displayedItem in self.displayerSpy.displayItemsViewModel.displayedItems {
            XCTAssertEqual(displayedItem.id, item.id)
        }
    }
    
    func testPresentNewItemsShouldAskTheDisplayerToDisplayNewItems() {
        self.sut.presentNewItems(response: PlaceCommentsModels.ItemsPresentation.Response(items: []))
        XCTAssertTrue(self.displayerSpy.displayNewItemsCalled)
    }
    
    func testPresentNewItemsShouldFormatItemsForDisplay() {
        let item = Comment(id: "id")
        let items = [item]
        self.sut.presentNewItems(response: PlaceCommentsModels.ItemsPresentation.Response(items: items))
        
        XCTAssertEqual(self.displayerSpy.displayNewItemsViewModel.displayedItems.count, items.count)
        for displayedItem in self.displayerSpy.displayNewItemsViewModel.displayedItems {
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
        self.sut.presentWillFetchImage(response: PlaceCommentsModels.ImageFetching.Response(item: PlaceCommentsModels.DisplayedItem(id: "id")))
        XCTAssertTrue(self.displayerSpy.displayWillFetchImageCalled)
    }
    
    func testPresentDidFetchImageShouldAskTheDisplayerToDisplayDidFetchImage() {
        self.sut.presentDidFetchImage(response: PlaceCommentsModels.ImageFetching.Response(item: PlaceCommentsModels.DisplayedItem(id: "id")))
        XCTAssertTrue(self.displayerSpy.displayDidFetchImageCalled)
    }
    
    func testPresentImageShouldAskTheDisplayerToDisplayImage() {
        self.sut.presentImage(response: PlaceCommentsModels.ImagePresentation.Response(item: PlaceCommentsModels.DisplayedItem(id: "id"), image: nil))
        XCTAssertTrue(self.displayerSpy.displayImageCalled)
    }
    
    func testPresentPlaceholderImageShouldAskTheDisplayerToDisplayImage() {
        self.sut.presentPlaceholderImage(response: PlaceCommentsModels.ImagePresentation.Response(item: PlaceCommentsModels.DisplayedItem(id: "id"), image: nil))
        XCTAssertTrue(self.displayerSpy.displayImageCalled)
    }
}
