//
//  ExploreViewControllerTests.swift
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

class ExploreViewControllerTests: XCTestCase {
    var sut: ExploreViewController!
    var interactorSpy: ExploreBusinessLogicSpy!
    var routerSpy: ExploreRoutingLogicSpy!
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.window = UIWindow()
        self.setupExploreViewController()
    }
    
    override func tearDown() {
        self.window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupExploreViewController() {
        self.sut = ExploreViewController()
        
        self.interactorSpy = ExploreBusinessLogicSpy()
        self.sut.interactor = self.interactorSpy
        
        self.routerSpy = ExploreRoutingLogicSpy()
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
        XCTAssertNil(ExploreViewController(coder: NSCoder()))
    }
    
    func testShouldSetupDataSourceWhenTheViewDidLoad() {
        self.loadView()
        XCTAssertEqual(self.sut.sections.count, 2)
    }
    
    // MARK: - Subviews tests
    
    func testAddSubviewsWhenViewDidLoad() {
        self.loadView()
        XCTAssertNotNil(self.sut.tableView)
    }
    
    // MARK: - Table view tests
    
    func testIfViewControllerHasSetTableViewDataSource() {
        self.loadView()
        XCTAssertNotNil(self.sut.tableView.dataSource)
    }
    
    func testIfViewControllerHasSetTableViewDelegate() {
        self.loadView()
        XCTAssertNotNil(self.sut.tableView.delegate)
    }
    
    func testIfViewControllerConformsToTableViewDataSource() {
        XCTAssertTrue(self.sut.conforms(to: UITableViewDataSource.self))
    }
    
    func testIfViewControllerImplementsTableViewDataSourceMethods() {
        XCTAssertTrue(self.sut.responds(to: #selector(UITableViewDataSource.numberOfSections(in:))))
        XCTAssertTrue(self.sut.responds(to: #selector(UITableViewDataSource.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(self.sut.responds(to: #selector(UITableViewDataSource.tableView(_:cellForRowAt:))))
    }
    
    func testIfViewControllerImplementsTableViewDelegateMethods() {
        XCTAssertTrue(self.sut.responds(to: #selector(UITableViewDelegate.scrollViewDidScroll(_:))))
        XCTAssertTrue(self.sut.responds(to: #selector(UITableViewDelegate.tableView(_:viewForHeaderInSection:))))
    }
    
    func testNumberOfRowsInItemsSectionShouldEqualItemsCount() {
        self.loadView()
        let section = ExploreModels.SectionIndex.items.rawValue
        self.sut.sections[section].items = [ExploreModels.DisplayedItem(id: "id")]
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
        let section = ExploreModels.SectionIndex.items.rawValue
        self.sut.sections[section].items = [ExploreModels.DisplayedItem(id: "id")]
        let cell = self.sut.tableView(self.sut.tableView, cellForRowAt: IndexPath(row: 0, section: section))
        XCTAssertTrue(cell is ExploreTableViewCell)
    }
    
    func testShouldConfigureItemsTableViewCell() {
        self.loadView()
        
        let section = ExploreModels.SectionIndex.items.rawValue
        let item = ExploreModels.DisplayedItem(id: "id")
        item.title = "Title".attributed(attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        item.isLoadingImage = true
        item.image = UIImage()
        item.imageContentMode = .center
        item.imageDominantColor = UIColor.white
        let items = [item]
        self.sut.sections[section].items = items
        
        let tableView = self.sut.tableView
        items.enumerated().forEach { (index, item) in
            let cell = self.sut.tableView(tableView!, cellForRowAt: IndexPath(row: index, section: section)) as! ExploreTableViewCell
            XCTAssertNotNil(item.cellInterface)
            XCTAssertEqual(cell.titleLabel?.attributedText, item.title)
            XCTAssertEqual(cell.activityIndicatorView?.isHidden, !item.isLoadingImage)
            XCTAssertEqual(cell.backgroundImageView?.image, item.image)
            XCTAssertEqual(cell.backgroundImageView?.contentMode, item.imageContentMode)
            XCTAssertEqual(cell.backgroundImageView?.backgroundColor, item.imageDominantColor)
            XCTAssertNotNil(cell.delegate)
            XCTAssertTrue(self.interactorSpy.shouldFetchImageCalled)
        }
    }
    
    func testTableViewViewForHeaderInSectionShouldReturnTableViewLoadingHeaderFooterViewWhenTheFooterSectionIsLoading() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = true
        let view = self.sut.tableView(self.sut.tableView, viewForHeaderInSection: section)
        XCTAssertNotNil(view)
        XCTAssertTrue(view is TableViewLoadingHeaderFooterView)
    }
    
    func testTableViewViewForHeaderInSectionShouldReturnTableViewLoadingHeaderFooterViewWhenTheFooterSectionHasNoMoreItems() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = false
        self.sut.sections[section].noMoreItems = true
        let view = self.sut.tableView(self.sut.tableView, viewForHeaderInSection: section)
        XCTAssertNotNil(view)
        XCTAssertTrue(view is TableViewTitleHeaderFooterView)
    }
    
    func testTableViewViewForHeaderInSectionShouldReturnTableViewErrorHeaderFooterViewWhenTheFooterSectionHasError() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = true
        self.sut.sections[section].noMoreItems = false
        let view = self.sut.tableView(self.sut.tableView, viewForHeaderInSection: section)
        XCTAssertNotNil(view)
        XCTAssertTrue(view is TableViewErrorHeaderFooterView)
    }
    
    func testTableViewViewForHeaderInSectionShouldReturnNilWhenTheFooterSectionIsNotLoadingAndHasNoErrorAndHasMoreItems() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = false
        self.sut.sections[section].noMoreItems = false
        let view = self.sut.tableView(self.sut.tableView, viewForHeaderInSection: section)
        XCTAssertNil(view)
    }
    
    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionIsLoading() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = true
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForHeaderInSection: section)
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
    
    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionHasNoMoreItems() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = false
        self.sut.sections[section].noMoreItems = true
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForHeaderInSection: section)
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
    
    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionHasError() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
        self.sut.sections[section].isLoading = false
        self.sut.sections[section].hasError = true
        self.sut.sections[section].noMoreItems = false
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForHeaderInSection: section)
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
    
    func testTableViewEstimatedHeightForHeaderInSectionShouldReturnAutomaticDimensionWhenSectionIsNotLoadingAndHasNoErrorAndHasMoreItems() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
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
        let section = ExploreModels.SectionIndex.items.rawValue
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForFooterInSection: section)
        XCTAssertEqual(height, ExploreStyle.shared.tableViewModel.itemsSectionFooterHeight)
    }
    
    func testTableViewEstimatedHeightForFooterInSectionShouldReturnValueForFooterSection() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForFooterInSection: section)
        XCTAssertEqual(height, ExploreStyle.shared.tableViewModel.footerSectionFooterHeight)
    }
    
    func testTableViewEstimatedHeightForFooterInSectionShouldReturnValueForInvalidSection() {
        self.loadView()
        let height = self.sut.tableView(self.sut.tableView, estimatedHeightForFooterInSection: 2)
        XCTAssertEqual(height, CGFloat.leastNonzeroMagnitude)
    }
    
    // MARK: - Business logic tests
    
    func testShouldFetchItemsWhenTheViewDidLoad() {
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
    
    // MARK: - Display logic tests
    
    func testDisplayWillFetchItemsShouldUpdateFooterSectionIsLoading() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
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
        let section = ExploreModels.SectionIndex.footer.rawValue
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
        let section = ExploreModels.SectionIndex.items.rawValue
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.sections[section].items = [ExploreModels.DisplayedItem(id: "id1")]
        let count = self.sut.sections[section].items.count
        let displayedItems = [ExploreModels.DisplayedItem(id: "id2")]
        self.sut.displayItems(viewModel: ExploreModels.ItemsPresentation.ViewModel(displayedItems: displayedItems))
        self.waitForMainQueue()
        XCTAssertEqual(self.sut.sections[section].items.count, count + displayedItems.count)
    }
    
    func testDisplayItemsShouldAskTheTableViewToInsertRowsInBatchUpdates() {
        self.loadView()
        self.setupSections()
        let section = ExploreModels.SectionIndex.items.rawValue
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.sections[section].items = [ExploreModels.DisplayedItem(id: "id1")]
        let displayedItems = [ExploreModels.DisplayedItem(id: "id2")]
        self.sut.displayItems(viewModel: ExploreModels.ItemsPresentation.ViewModel(displayedItems: displayedItems))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.performBatchUpdatesCalled)
        XCTAssertTrue(tableViewSpy.insertRowsCalled)
    }
    
    func testDisplayNoMoreItemsShouldUpdateFooterSectionNoMoreItems() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
        self.sut.sections[section].noMoreItems = false
        self.sut.displayNoMoreItems(viewModel: ExploreModels.NoMoreItemsPresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.sections[section].noMoreItems)
    }
    
    func testDisplayNoMoreItemsShouldUpdateFooterSectionNoMoreItemsText() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
        self.sut.sections[section].noMoreItemsText = nil
        let text = NSAttributedString(string: "No more items", attributes: nil)
        self.sut.displayNoMoreItems(viewModel: ExploreModels.NoMoreItemsPresentation.ViewModel(text: text))
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.sections[section].noMoreItemsText)
        XCTAssertEqual(self.sut.sections[section].noMoreItemsText, text)
    }
    
    func testDisplayNoMoreItemsShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayNoMoreItems(viewModel: ExploreModels.NoMoreItemsPresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayRemoveNoMoreItemsShouldUpdateFooterSectionNoMoreItems() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
        self.sut.sections[section].noMoreItems = true
        self.sut.displayRemoveNoMoreItems()
        self.waitForMainQueue()
        XCTAssertFalse(self.sut.sections[section].noMoreItems)
    }
    
    func testDisplayRemoveNoMoreItemsShouldUpdateFooterSectionNoMoreItemsText() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
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
        self.sut.displayEmptyState(viewModel: ExploreModels.EmptyStatePresentation.ViewModel(image: nil, text: nil))
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
        let section = ExploreModels.SectionIndex.footer.rawValue
        self.sut.sections[section].hasError = false
        self.sut.displayErrorState(viewModel: ExploreModels.ErrorStatePresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(self.sut.sections[section].hasError)
    }
    
    func testDisplayErrorStateShouldUpdateFooterSectionErrorText() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
        self.sut.sections[section].errorText = nil
        let text = NSAttributedString(string: "Error", attributes: nil)
        self.sut.displayErrorState(viewModel: ExploreModels.ErrorStatePresentation.ViewModel(text: text))
        self.waitForMainQueue()
        XCTAssertNotNil(self.sut.sections[section].errorText)
        XCTAssertEqual(self.sut.sections[section].errorText, text)
    }
    
    func testDisplayErrorStateShouldAskTheTableViewToReloadSections() {
        self.setupSections()
        let tableViewSpy = self.tableViewSpy()
        self.sut.tableView = tableViewSpy
        self.sut.displayErrorState(viewModel: ExploreModels.ErrorStatePresentation.ViewModel(text: nil))
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.reloadSectionsCalled)
    }
    
    func testDisplayRemoveErrorStateShouldUpdateFooterSectionHasError() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
        self.sut.sections[section].hasError = true
        self.sut.displayRemoveErrorState()
        self.waitForMainQueue()
        XCTAssertFalse(self.sut.sections[section].hasError)
    }
    
    func testDisplayRemoveErrorStateShouldUpdateFooterSectionErrorText() {
        self.loadView()
        let section = ExploreModels.SectionIndex.footer.rawValue
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
        let spy = ExploreTableViewCellInterfaceSpy()
        let item = ExploreModels.DisplayedItem(id: "id")
        item.cellInterface = spy
        item.isLoadingImage = false
        self.sut.displayWillFetchImage(viewModel: ExploreModels.ImageFetching.ViewModel(item: item))
        self.waitForMainQueue()
        XCTAssertTrue(item.isLoadingImage)
        XCTAssertTrue(spy.setIsLoadingImageCalled)
    }
    
    func testDisplayDidFetchImage() {
        let spy = ExploreTableViewCellInterfaceSpy()
        let item = ExploreModels.DisplayedItem(id: "id")
        item.cellInterface = spy
        item.isLoadingImage = true
        self.sut.displayDidFetchImage(viewModel: ExploreModels.ImageFetching.ViewModel(item: item))
        self.waitForMainQueue()
        XCTAssertFalse(item.isLoadingImage)
        XCTAssertTrue(spy.setIsLoadingImageCalled)
    }
    
    func testDisplayImage() {
        let spy = ExploreTableViewCellInterfaceSpy()
        let item = ExploreModels.DisplayedItem(id: "id")
        item.cellInterface = spy
        item.image = nil
        item.imageContentMode = .center
        let image = UIImage()
        let contentMode = UIView.ContentMode.scaleAspectFill
        self.sut.displayImage(viewModel: ExploreModels.ImagePresentation.ViewModel(item: item, image: image, contentMode: contentMode))
        self.waitForMainQueue()
        XCTAssertEqual(item.image, image)
        XCTAssertEqual(item.imageContentMode, contentMode)
        XCTAssertTrue(spy.setImageCalled)
    }
    
    private func setupSections() {
        self.sut.sections = [ExploreModels.Section(), ExploreModels.Section()]
    }
    
    private func tableViewSpy() -> UITableViewSpy {
        let spy = UITableViewSpy()
        spy.dataSource = self.sut
        spy.register(ExploreTableViewCell.self, forCellReuseIdentifier: ExploreTableViewCell.defaultReuseIdentifier)
        return spy
    }
}
