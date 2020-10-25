//
//  PlaceCommentsViewControllerTests.swift
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

class PlaceCommentsViewControllerTests: XCTestCase {
    var sut: PlaceCommentsViewController!
    var interactorSpy: PlaceCommentsBusinessLogicSpy!
    var routerSpy: PlaceCommentsRoutingLogicSpy!
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.window = UIWindow()
        self.setupPlaceCommentsViewController()
    }
    
    override func tearDown() {
        self.window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPlaceCommentsViewController() {
        self.sut = PlaceCommentsViewController(placeId: "placeId")
        
        self.interactorSpy = PlaceCommentsBusinessLogicSpy()
        self.sut.interactor = self.interactorSpy
        
        self.routerSpy = PlaceCommentsRoutingLogicSpy()
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
    
    // MARK: - Tests
    
    func testInitializerWithCoder() {
        XCTAssertNil(PlaceCommentsViewController(coder: NSCoder()))
    }
    
    func testShouldSetupDataSourceWhenTheViewDidLoad() {
        self.loadView()
        XCTAssertEqual(self.sut.sections.count, 2)
    }
    
    // MARK: - Table view tests
    
    func testNumberOfRowsInItemsSectionShouldEqualItemsCount() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.items.rawValue
        self.sut.sections[section].items = [PlaceCommentsModels.DisplayedItem(id: "id")]
        let numberOfRows = self.sut.tableView(self.sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, self.sut.sections[section].items.count)
    }
    
    func testNumberOfSectionsInTableViewShouldEqualSectionsCount() {
        self.loadView()
        let tableView = self.sut.tableView
        let numberOfSections = self.sut.numberOfSections(in: tableView!)
        XCTAssertEqual(numberOfSections, self.sut.sections.count)
    }
    
    func testCellForRowShouldReturnCorrectCellForItems() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.items.rawValue
        self.sut.sections[section].items = [PlaceCommentsModels.DisplayedItem(id: "id")]
        let cell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 0, section: section))
        XCTAssertTrue(cell is PlaceCommentsTableViewCell)
    }
    
    func testShouldConfigureItemsTableViewCell() {
        self.loadView()
        
        let section = PlaceCommentsModels.SectionIndex.items.rawValue
        let item = PlaceCommentsModels.DisplayedItem(id: "id")
        item.name = "Name".attributed(attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        item.text = "Text".attributed(attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        item.time = "Time".attributed(attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
        item.isLoadingImage = true
        item.image = UIImage()
        item.imageContentMode = .center
        item.imageDominantColor = UIColor.white
        let items = [item]
        self.sut.sections[section].items = items
        
        let tableView = self.sut.tableView
        items.enumerated().forEach { (index, item) in
            let cell = self.sut.tableView(tableView!, cellForRowAt: IndexPath(row: index, section: section)) as! PlaceCommentsTableViewCell
            XCTAssertNotNil(item.cellInterface)
            XCTAssertEqual(cell.nameLabel?.attributedText, item.name)
            XCTAssertEqual(cell.commentLabel?.attributedText, item.text)
            XCTAssertEqual(cell.timeLabel?.attributedText, item.time)
            XCTAssertEqual(cell.avatarImageView?.activityIndicatorView?.isHidden, !item.isLoadingImage)
            XCTAssertEqual(cell.avatarImageView?.image, item.image)
            XCTAssertEqual(cell.avatarImageView?.contentMode, item.imageContentMode)
            XCTAssertEqual(cell.avatarImageView?.backgroundColor, item.imageDominantColor)
            XCTAssertTrue(self.interactorSpy.shouldFetchImageCalled)
        }
    }
    
    func testTableViewViewForHeaderInSectionShouldReturnTableViewLoadingHeaderFooterViewWhenTheFooterSectionIsLoading() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = true
        let view = self.sut.tableView(self.sut.tableView, viewForHeaderInSection: section)
        XCTAssertNotNil(view)
        XCTAssertTrue(view is TableViewLoadingHeaderFooterView)
    }
    
    func testTableViewViewForHeaderInSectionShouldReturnTableViewLoadingHeaderFooterViewWhenTheFooterSectionHasNoMoreItems() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = false
        self.sut.sections[section].noMoreItems = true
        let view = self.sut.tableView(self.sut.tableView, viewForHeaderInSection: section)
        XCTAssertNotNil(view)
        XCTAssertTrue(view is TableViewTitleHeaderFooterView)
    }
    
    func testTableViewViewForHeaderInSectionShouldReturnTableViewErrorHeaderFooterViewWhenTheFooterSectionHasError() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = true
        self.sut.sections[section].noMoreItems = false
        let view = self.sut.tableView(self.sut.tableView, viewForHeaderInSection: section)
        XCTAssertNotNil(view)
        XCTAssertTrue(view is TableViewErrorHeaderFooterView)
    }
    
    func testTableViewViewForHeaderInSectionShouldReturnNilWhenTheFooterSectionIsNotLoadingAndHasNoErrorAndHasMoreItems() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = false
        self.sut.sections[section].noMoreItems = false
        let view = self.sut.tableView(self.sut.tableView, viewForHeaderInSection: section)
        XCTAssertNil(view)
    }
    
    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionIsLoading() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = true
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForHeaderInSection: section)
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
    
    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionHasNoMoreItems() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = false
        self.sut.sections[section].noMoreItems = true
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForHeaderInSection: section)
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
    
    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionHasError() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = true
        self.sut.sections[section].noMoreItems = false
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForHeaderInSection: section)
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
    
    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionIsNotLoadingAndHasNoErrorAndHasMoreItems() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = false
        self.sut.sections[section].noMoreItems = false
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForHeaderInSection: section)
        XCTAssertEqual(height, 0)
    }
    
    func testTableViewViewForFooterInSectionShouldReturnView() {
        self.loadView()
        for (index, _) in self.sut.sections.enumerated() {
            XCTAssertNotNil(self.sut.tableView(self.sut.tableView, viewForFooterInSection: index))
        }
    }
    
    func testTableViewEstimatedHeightForFooterInSectionShouldReturnValueForItemsSection() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.items.rawValue
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForFooterInSection: section)
        XCTAssertEqual(height, PlaceCommentsStyle.shared.tableViewModel.itemsSectionFooterHeight)
    }
    
    func testTableViewEstimatedHeightForFooterInSectionShouldReturnValueForFooterSection() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForFooterInSection: section)
        XCTAssertEqual(height, PlaceCommentsStyle.shared.tableViewModel.footerSectionFooterHeight)
    }
    
    func testTableViewEstimatedHeightForFooterInSectionShouldReturnValueForInvalidSection() {
        self.loadView()
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForFooterInSection: 2)
        XCTAssertEqual(height, CGFloat.leastNonzeroMagnitude)
    }
    
    // MARK: - Business logic tests
    
    func testViewDidLoadShouldAskTheInteractorToSetPlace() {
        self.loadView()
        XCTAssertTrue(self.interactorSpy.shouldSetPlaceCalled)
    }
    
    func testViewDidLoadShouldAskTheInteractorToFetchItems() {
        self.loadView()
        XCTAssertTrue(self.interactorSpy.shouldFetchItemsCalled)
    }
    
    func testShouldFetchItemsWhenScrollViewDidScroll() {
        let threshold: CGFloat = 50
        let contentSizeHeight: CGFloat = 400
        let frameSizeHeight: CGFloat = 100
        let scrollViewSpy = UIScrollViewSpy()
        scrollViewSpy.shouldDecelerate = true
        scrollViewSpy.contentSize.height = contentSizeHeight
        scrollViewSpy.frame.size.height = frameSizeHeight
        scrollViewSpy.contentOffset.y = contentSizeHeight - frameSizeHeight - threshold
        self.sut.scrollViewDidScroll(scrollViewSpy)
        XCTAssertTrue(self.interactorSpy.shouldFetchItemsCalled)
    }
    
    func testShouldFetchItemsWhenSelectingErrorTitleButtonFromSectionFooterView() {
        self.sut.tableViewErrorHeaderFooterView(view: nil, didSelectTitle: nil)
        XCTAssertTrue(self.interactorSpy.shouldFetchItemsCalled)
    }
    
    func testTraitCollectionDidChangeShouldAskTheInteractorToFetchItems() {
        let traitCollection = UITraitCollection(preferredContentSizeCategory: UIContentSizeCategory.unspecified)
        self.sut.traitCollectionDidChange(traitCollection)
        XCTAssertTrue(self.interactorSpy.shouldFetchItemsCalled)
    }
    
    // MARK: - Display logic tests
    
    func testDisplayWillFetchItemsShouldUpdateFooterSectionIsLoading() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.displayWillFetchItems()
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.sections[section].isLoading)
    }
    
    func testDisplayWillFetchItemsShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayWillFetchItems()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayDidFetchItemsShouldUpdateFooterSectionIsLoading() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = true
        self.sut.displayDidFetchItems()
        self.waitForMainQueue()
        XCTAssertFalse(self.sut.sections[section].isLoading)
    }
    
    func testDisplayDidFetchItemsShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayDidFetchItems()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayItemsShouldUpdateDisplayedItems() {
        self.setupSections()
        let section = PlaceCommentsModels.SectionIndex.items.rawValue
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.sections[section].items = []
        let displayedItems = [PlaceCommentsModels.DisplayedItem(id: "id1"), PlaceCommentsModels.DisplayedItem(id: "id2")]
        self.sut.displayItems(viewModel: PlaceCommentsModels.ItemsPresentation.ViewModel(displayedItems: displayedItems))
        self.waitForMainQueue()
        XCTAssertEqual(self.sut.sections[section].items.count, displayedItems.count)
    }
    
    func testDisplayItemsShouldAskTheTableViewToReloadSections() {
        self.loadView()
        self.setupSections()
        let section = PlaceCommentsModels.SectionIndex.items.rawValue
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.sections[section].items = []
        self.sut.displayItems(viewModel: PlaceCommentsModels.ItemsPresentation.ViewModel(displayedItems: []))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayNewItemsShouldUpdateDisplayedItems() {
        self.setupSections()
        let section = PlaceCommentsModels.SectionIndex.items.rawValue
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.sections[section].items = [PlaceCommentsModels.DisplayedItem(id: "id1")]
        let count = self.sut.sections[section].items.count
        let displayedItems = [PlaceCommentsModels.DisplayedItem(id: "id2")]
        self.sut.displayNewItems(viewModel: PlaceCommentsModels.ItemsPresentation.ViewModel(displayedItems: displayedItems))
        self.waitForMainQueue()
        XCTAssertEqual(self.sut.sections[section].items.count, count + displayedItems.count)
    }
    
    func testDisplayNewItemsShouldAskTheTableViewToInsertRowsInBatchUpdates() {
        self.setupSections()
        let section = PlaceCommentsModels.SectionIndex.items.rawValue
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.sections[section].items = [PlaceCommentsModels.DisplayedItem(id: "id1")]
        let displayedItems = [PlaceCommentsModels.DisplayedItem(id: "id2")]
        self.sut.displayNewItems(viewModel: PlaceCommentsModels.ItemsPresentation.ViewModel(displayedItems: displayedItems))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.performBatchUpdatesCalled)
        XCTAssertTrue(tableViewSpy.insertRowsCalled)
    }
    
    func testDisplayNoMoreItemsShouldUpdateFooterSectionNoMoreItems() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].noMoreItems = false
        self.sut.displayNoMoreItems(viewModel: PlaceCommentsModels.NoMoreItemsPresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.sections[section].noMoreItems)
    }
    
    func testDisplayNoMoreItemsShouldUpdateFooterSectionNoMoreItemsText() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].noMoreItemsText = nil
        let text = NSAttributedString(string: "No more items", attributes: nil)
        self.sut.displayNoMoreItems(viewModel: PlaceCommentsModels.NoMoreItemsPresentation.ViewModel(text: text))
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.sections[section].noMoreItemsText)
        XCTAssertEqual(self.sut.sections[section].noMoreItemsText, text)
    }
    
    func testDisplayNoMoreItemsShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayNoMoreItems(viewModel: PlaceCommentsModels.NoMoreItemsPresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayRemoveNoMoreItemsShouldUpdateFooterSectionNoMoreItems() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].noMoreItems = true
        self.sut.displayRemoveNoMoreItems()
        self.waitForMainQueue()
        XCTAssertFalse(self.sut.sections[section].noMoreItems)
    }
    
    func testDisplayRemoveNoMoreItemsShouldUpdateFooterSectionNoMoreItemsText() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].noMoreItemsText = NSAttributedString(string: "No more items", attributes: nil)
        self.sut.displayRemoveNoMoreItems()
        self.waitForMainQueue()
        XCTAssertNil(self.sut.sections[section].noMoreItemsText)
    }
    
    func testDisplayRemoveNoMoreItemsShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayRemoveNoMoreItems()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayEmptyStateShouldUpdateTableViewBackgroundView() {
        self.loadView()
        self.sut.displayEmptyState(viewModel: PlaceCommentsModels.EmptyStatePresentation.ViewModel(image: nil, text: nil))
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.tableView.backgroundView)
        XCTAssertTrue(self.sut.tableView.backgroundView is EmptyStateView)
    }
    
    func testDisplayRemoveEmptyStateShouldUpdateTableViewBackgroundView() {
        self.loadView()
        self.sut.tableView?.backgroundView = UIView()
        self.sut.displayRemoveEmptyState()
        self.waitForMainQueue()
        XCTAssertNil(self.sut.tableView.backgroundView)
    }
    
    func testDisplayErrorStateShouldUpdateFooterSectionHasError() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].hasError = false
        self.sut.displayErrorState(viewModel: PlaceCommentsModels.ErrorStatePresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.sections[section].hasError)
    }
    
    func testDisplayErrorStateShouldUpdateFooterSectionErrorText() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].errorText = nil
        let text = NSAttributedString(string: "Error", attributes: nil)
        self.sut.displayErrorState(viewModel: PlaceCommentsModels.ErrorStatePresentation.ViewModel(text: text))
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.sections[section].errorText)
        XCTAssertEqual(self.sut.sections[section].errorText, text)
    }
    
    func testDisplayErrorStateShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayErrorState(viewModel: PlaceCommentsModels.ErrorStatePresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayRemoveErrorStateShouldUpdateFooterSectionHasError() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].hasError = true
        self.sut.displayRemoveErrorState()
        self.waitForMainQueue()
        XCTAssertFalse(self.sut.sections[section].hasError)
    }
    
    func testDisplayRemoveErrorStateShouldUpdateFooterSectionErrorText() {
        self.loadView()
        let section = PlaceCommentsModels.SectionIndex.footer.rawValue
        self.sut.sections[section].errorText = NSAttributedString(string: "Error", attributes: nil)
        self.sut.displayRemoveErrorState()
        self.waitForMainQueue()
        XCTAssertNil(self.sut.sections[section].errorText)
    }
    
    func testDisplayRemoveErrorStateShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayRemoveErrorState()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayWillFetchImage() {
        let spy = PlaceCommentsTableViewCellInterfaceSpy()
        let item = PlaceCommentsModels.DisplayedItem(id: "id")
        item.cellInterface = spy
        item.isLoadingImage = false
        self.sut.displayWillFetchImage(viewModel: PlaceCommentsModels.ImageFetching.ViewModel(item: item))
        self.waitForMainQueue()
        XCTAssertTrue(item.isLoadingImage)
        XCTAssertTrue(spy.setIsLoadingImageCalled)
    }
    
    func testDisplayDidFetchImage() {
        let spy = PlaceCommentsTableViewCellInterfaceSpy()
        let item = PlaceCommentsModels.DisplayedItem(id: "id")
        item.cellInterface = spy
        item.isLoadingImage = true
        self.sut.displayDidFetchImage(viewModel: PlaceCommentsModels.ImageFetching.ViewModel(item: item))
        self.waitForMainQueue()
        XCTAssertFalse(item.isLoadingImage)
        XCTAssertTrue(spy.setIsLoadingImageCalled)
    }
    
    func testDisplayImage() {
        let spy = PlaceCommentsTableViewCellInterfaceSpy()
        let item = PlaceCommentsModels.DisplayedItem(id: "id")
        item.cellInterface = spy
        item.image = nil
        item.imageContentMode = .center
        let image = UIImage()
        let contentMode = UIView.ContentMode.scaleAspectFill
        self.sut.displayImage(viewModel: PlaceCommentsModels.ImagePresentation.ViewModel(item: item, image: image, contentMode: contentMode))
        self.waitForMainQueue()
        XCTAssertEqual(item.image, image)
        XCTAssertEqual(item.imageContentMode, contentMode)
        XCTAssertTrue(spy.setImageCalled)
    }
    
    private func setupSections() {
        self.sut.sections = [PlaceCommentsModels.Section(), PlaceCommentsModels.Section()]
    }
    
    private func tableViewSpy() -> UITableViewSpy {
        let spy = UITableViewSpy()
        spy.dataSource = self.sut
        spy.delegate = self.sut
        spy.register(PlaceCommentsTableViewCell.self, forCellReuseIdentifier: PlaceCommentsTableViewCell.defaultReuseIdentifier)
        return spy
    }
}