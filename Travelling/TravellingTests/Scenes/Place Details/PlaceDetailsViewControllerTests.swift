//
//  PlaceDetailsViewControllerTests.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 08/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling
import XCTest

class PlaceDetailsViewControllerTests: XCTestCase {
    var sut: PlaceDetailsViewController!
    var interactorSpy: PlaceDetailsBusinessLogicSpy!
    var routerSpy: PlaceDetailsRoutingLogicSpy!
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.window = UIWindow()
        self.setupPlaceDetailsViewController()
    }
    
    override func tearDown() {
        self.window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPlaceDetailsViewController() {
        self.sut = PlaceDetailsViewController(place: Place(id: "placeId", location: Location(id: "locationId", latitude: 20, longitude: 20)))
        
        self.interactorSpy = PlaceDetailsBusinessLogicSpy()
        self.sut.interactor = self.interactorSpy
        
        self.routerSpy = PlaceDetailsRoutingLogicSpy()
        self.sut.router = self.routerSpy
    }
    
    func loadView() {
        self.window.addSubview(self.sut.view)
        RunLoop.current.run(until: Date())
    }
    
    private func waitForMainQueue() {
        let waitExpectation = expectation(description: "Waiting for main queue.")
        DispatchQueue.main.async {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    // MARK: - Table view tests
    
    func testNumberOfRowsInItemsSectionShouldEqualItemsCount() {
        self.loadView()
        self.sut.items = [PlaceDetailsModels.DisplayedItem(type: .photo, model: nil)]
        let numberOfRows = self.sut.tableView(self.sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, self.sut.items.count)
    }
    
    func testCellForRowShouldReturnCorrectCellForItems() {
        self.loadView()
        self.sut.items = [PlaceDetailsModels.DisplayedItem(type: .photo, model: PlaceDetailsModels.PhotoModel()), PlaceDetailsModels.DisplayedItem(type: .description, model: PlaceDetailsModels.DescriptionModel()), PlaceDetailsModels.DisplayedItem(type: .comments, model: PlaceDetailsModels.CommentsModel())]
        
        let photoCell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let descriptionCell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        let commentsCell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 2, section: 0))
        
        XCTAssertTrue(photoCell is PlaceDetailsPhotoTableViewCell)
        XCTAssertTrue(descriptionCell is PlaceDetailsDescriptionTableViewCell)
        XCTAssertTrue(commentsCell is PlaceDetailsCommentsTableViewCell)
    }
    
    func testShouldConfigurePhotoTableViewCell() {
        self.loadView()
        
        let model = PlaceDetailsModels.PhotoModel()
        model.isLoadingImage = true
        model.image = UIImage()
        model.imageContentMode = .center
        model.imageDominantColor = UIColor.white
        
        let items = [PlaceDetailsModels.DisplayedItem(type: .photo, model: model)]
        self.sut.items = items
        items.enumerated().forEach { (index, item) in
            let cell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: index, section: 0)) as! PlaceDetailsPhotoTableViewCell
            guard let model = item.model as? PlaceDetailsModels.PhotoModel else {
                return XCTAssertTrue(false, "Wrong model for item!")
            }
            XCTAssertNotNil(model.cellInterface)
            XCTAssertNotNil(cell.delegate)
            XCTAssertEqual(cell.photoImageView?.activityIndicatorView?.isHidden, !model.isLoadingImage)
            XCTAssertEqual(cell.photoImageView?.image, model.image)
            XCTAssertEqual(cell.photoImageView?.contentMode, model.imageContentMode)
            XCTAssertEqual(cell.photoImageView?.backgroundColor, model.imageDominantColor)
            XCTAssertTrue(self.interactorSpy.shouldFetchImageCalled)
        }
    }
    
    func testShouldConfigureDescriptionTableViewCell() {
        self.loadView()
        
        let model = PlaceDetailsModels.DescriptionModel(title: "Title".attributed(attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]), text: "Text".attributed(attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue]))
        let items = [PlaceDetailsModels.DisplayedItem(type: .description, model: model)]
        self.sut.items = items
        items.enumerated().forEach { (index, item) in
            let cell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: index, section: 0)) as! PlaceDetailsDescriptionTableViewCell
            guard let model = item.model as? PlaceDetailsModels.DescriptionModel else {
                return XCTAssertTrue(false, "Wrong model for item!")
            }
            XCTAssertEqual(cell.titleLabel?.attributedText, model.title)
            XCTAssertEqual(cell.subtitleLabel?.attributedText, model.text)
        }
    }
    
    func testShouldConfigureCommentsTableViewCell() {
        self.loadView()
        
        let model = PlaceDetailsModels.CommentsModel(comments: "10 comments".attributed(attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]), time: "Time".attributed(attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue]))
        let items = [PlaceDetailsModels.DisplayedItem(type: .comments, model: model)]
        self.sut.items = items
        items.enumerated().forEach { (index, item) in
            let cell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: index, section: 0)) as! PlaceDetailsCommentsTableViewCell
            guard let model = item.model as? PlaceDetailsModels.CommentsModel else {
                return XCTAssertTrue(false, "Wrong model for item!")
            }
            XCTAssertNotNil(cell.delegate)
            XCTAssertEqual(cell.commentsButton?.currentAttributedTitle, model.comments)
            XCTAssertEqual(cell.timeButton?.currentAttributedTitle, model.time)
        }
    }
    
    // MARK: - Business logic tests
    
    func testViewDidLoadShouldAskTheInteractorToSetupPlace() {
        self.loadView()
        XCTAssertTrue(self.interactorSpy.shouldSetupPlaceCalled)
    }
    
    func testErrorStateViewTouchUpInsideButtonShouldAskTheInteractorToRefreshPlace() {
        self.sut.errorStateView(view: nil, touchUpInsideButton: nil)
        XCTAssertTrue(self.interactorSpy.shouldRefreshPlaceCalled)
    }
    
    func testValueChangedRefreshControlShouldAskTheInteractorToRefreshPlace() {
        self.sut.valueChangedRefreshControl(refreshControl: UIRefreshControl())
        XCTAssertTrue(self.interactorSpy.shouldRefreshPlaceCalled)
    }
    
    func testValueChangedRefreshControlShouldAskTheRefreshControlToEndRefreshing() {
        let refreshControlSpy = UIRefreshControlSpy()
        self.sut.valueChangedRefreshControl(refreshControl: refreshControlSpy)
        XCTAssertTrue(refreshControlSpy.endRefreshingCalled)
    }
    
    func testPlaceDetailsPhotoTableViewCell() {
        self.sut.placeDetailsPhotoTableViewCell(cell: nil, touchUpInsidePhoto: nil)
        XCTAssertTrue(self.interactorSpy.shouldSelectPhotoCalled)
    }
    
    func testTouchUpInsideShareButtonShouldAskTheInteractorToSharePlace() {
        self.sut.touchUpInsideShareButton()
        XCTAssertTrue(self.interactorSpy.shouldSharePlaceCalled)
    }
    
    func testPlaceDetailsCommentsTableViewCellDidSelectCommentsShouldAskTheInteractorToNavigateToPlaceComments() {
        self.sut.placeDetailsCommentsTableViewCell(nil, didSelectComments: nil)
        XCTAssertTrue(self.interactorSpy.shouldNavigateToPlaceCommentsCalled)
    }
    
    // MARK: - Display logic tests
    
    func testDisplayWillFetchPlace() {
        self.loadView()
        self.sut.tableView?.tableFooterView = nil
        self.sut.displayWillFetchPlace()
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.tableView?.tableFooterView)
        XCTAssertTrue(self.sut.tableView?.tableFooterView is UIActivityIndicatorView)
    }
    
    func testDisplayDidFetchPlace() {
        self.loadView()
        self.sut.tableView?.tableFooterView = UIActivityIndicatorView(style: .medium)
        self.sut.displayDidFetchPlace()
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.tableView?.tableFooterView)
        XCTAssertFalse(self.sut.tableView?.tableFooterView is UIActivityIndicatorView)
    }
    
    func testDisplayPlaceShouldUpdateDisplayedItems() {
        self.sut.items = []
        let items: [PlaceDetailsModels.DisplayedItem] = [PlaceDetailsModels.DisplayedItem(type: .photo, model: nil)]
        self.sut.displayPlace(viewModel: PlaceDetailsModels.PlacePresentation.ViewModel(items: items))
        self.waitForMainQueue()
        XCTAssertEqual(self.sut.items, items)
    }
    
    func testDisplayPlaceShouldAskTheTableViewToReloadData() {
        self.loadView()
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayPlace(viewModel: PlaceDetailsModels.PlacePresentation.ViewModel(items: []))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadDataCalled)
    }
    
    func testDisplayResetPlaceShouldResetDisplayedItems() {
        self.sut.items = [PlaceDetailsModels.DisplayedItem(type: .photo, model: nil)]
        self.sut.displayResetPlace()
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.items.isEmpty)
    }
    
    func testDisplayResetPlaceShouldAskTheTableViewToReloadData() {
        self.loadView()
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayResetPlace()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadDataCalled)
    }
    
    func testDisplayWillFetchImage() {
        let spy = PlaceDetailsPhotoTableViewCellInterfaceSpy()
        let model = PlaceDetailsModels.PhotoModel()
        model.cellInterface = spy
        model.isLoadingImage = false
        self.sut.displayWillFetchImage(viewModel: PlaceDetailsModels.ImageFetching.ViewModel(model: model))
        self.waitForMainQueue()
        XCTAssertTrue(model.isLoadingImage)
        XCTAssertTrue(spy.setIsLoadingImageCalled)
    }
    
    func testDisplayDidFetchImage() {
        let spy = PlaceDetailsPhotoTableViewCellInterfaceSpy()
        let model = PlaceDetailsModels.PhotoModel()
        model.cellInterface = spy
        model.isLoadingImage = true
        self.sut.displayDidFetchImage(viewModel: PlaceDetailsModels.ImageFetching.ViewModel(model: model))
        self.waitForMainQueue()
        XCTAssertFalse(model.isLoadingImage)
        XCTAssertTrue(spy.setIsLoadingImageCalled)
    }
    
    func testDisplayImage() {
        let spy = PlaceDetailsPhotoTableViewCellInterfaceSpy()
        let model = PlaceDetailsModels.PhotoModel()
        model.cellInterface = spy
        model.image = nil
        model.imageContentMode = .center
        let image = UIImage()
        let contentMode = UIView.ContentMode.scaleAspectFill
        self.sut.displayImage(viewModel: PlaceDetailsModels.ImagePresentation.ViewModel(model: model, image: image, contentMode: contentMode))
        self.waitForMainQueue()
        XCTAssertEqual(model.image, image)
        XCTAssertEqual(model.imageContentMode, contentMode)
        XCTAssertTrue(spy.setImageCalled)
    }
    
    func testDisplayErrorStateShouldSetTableViewBackgroundView() {
        self.loadView()
        self.sut.tableView?.backgroundView = nil
        self.sut.displayErrorState(viewModel: PlaceDetailsModels.ErrorStatePresentation.ViewModel(image: nil, text: "Text".attributed()))
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.tableView?.backgroundView)
        XCTAssertTrue(self.sut.tableView?.backgroundView is ErrorStateView)
    }
    
    func testDisplayRemoveErrorStateShouldRemoveTableViewBackgroundView() {
        self.loadView()
        self.sut.tableView?.backgroundView = ErrorStateView(frame: .zero)
        self.sut.displayRemoveErrorState()
        self.waitForMainQueue()
        XCTAssertNil(self.sut.tableView?.backgroundView)
    }
    
    func testDisplayErrorAlertShouldAskTheRouterToNavigateToAlert() {
        self.sut.displayErrorAlert(viewModel: PlaceDetailsModels.ErrorAlertPresentation.ViewModel(title: "Title", message: "Message", cancelTitle: "Cancel"))
        self.waitForMainQueue()
        XCTAssertTrue(self.routerSpy.navigateToAlertCalled)
    }
    
    func testDisplayNavigateToFullscreenImageShouldAskTheRouterToNavigateToFullscreenImage() {
        self.sut.displayNavigateToFullscreenImage(viewModel: PlaceDetailsModels.FullscreenImageNavigation.ViewModel(imageName: "imageName"))
        self.waitForMainQueue()
        XCTAssertTrue(self.routerSpy.navigateToFullscreenImageCalled)
    }
    
    func testDisplayNavigateToPlaceCommentsShouldAskTheRouterToNavigateToPlaceComments() {
        self.sut.displayNavigateToPlaceComments(viewModel: PlaceDetailsModels.PlaceCommentsNavigation.ViewModel(placeId: "placeId"))
        self.waitForMainQueue()
        XCTAssertTrue(self.routerSpy.navigateToPlaceCommentsCalled)
    }
    
    func testDisplayPlaceTitleShouldUpdateNavigationItemTitle() {
        self.sut.navigationItem.title = nil
        let title = "Title"
        self.sut.displayPlaceTitle(viewModel: PlaceDetailsModels.TitlePresentation.ViewModel(title: title))
        self.waitForMainQueue()
        XCTAssertEqual(self.sut.navigationItem.title, title)
    }
    
    func testDisplaySharePlaceShouldAskTheRouterToPresentViewController() {
        self.sut.displaySharePlace(viewModel: PlaceDetailsModels.PlaceSharing.ViewModel(text: "Text", excludedActivityTypes: []))
        self.waitForMainQueue()
        XCTAssertTrue(self.routerSpy.presentViewControllerCalled)
    }
}
