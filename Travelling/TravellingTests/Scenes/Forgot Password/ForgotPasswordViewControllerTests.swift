//
//  ForgotPasswordViewControllerTests.swift
//  Travelling
//
//  Created by Dimitri Strauneanu on 05/10/2020.
//  Copyright (c) 2020 Travelling. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Travelling
import XCTest

class ForgotPasswordViewControllerTests: XCTestCase {
    var sut: ForgotPasswordViewController!
    var interactorSpy: ForgotPasswordBusinessLogicSpy!
    var routerSpy: ForgotPasswordRoutingLogicSpy!
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.window = UIWindow()
        self.setupForgotPasswordViewController()
    }
    
    override func tearDown() {
        self.window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupForgotPasswordViewController() {
        self.sut = ForgotPasswordViewController()
        
        self.interactorSpy = ForgotPasswordBusinessLogicSpy()
        self.sut.interactor = self.interactorSpy
        
        self.routerSpy = ForgotPasswordRoutingLogicSpy()
        self.sut.router = self.routerSpy
    }
    
    func loadView() {
        self.window.addSubview(self.sut.view)
        RunLoop.current.run(until: Date())
    }
    
    func waitForMainQueue() {
        let waitExpectation = expectation(description: "Waiting for main queue.")
        DispatchQueue.main.async {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    // MARK: - Business logic tests
    
    func testShouldSetupItemsWhenTheViewDidLoad() {
        self.loadView()
        XCTAssertTrue(self.interactorSpy.shouldSetupItemsCalled)
    }
    
    func testShouldUpdateItemWhenTextFieldEditingChanged() {
        self.sut.forgotPasswordTextFieldCell(cell: nil, textFieldEditingChanged: nil, text: "email", itemType: ForgotPasswordModels.ItemType.email)
        XCTAssertTrue(self.interactorSpy.shouldUpdateItemCalled)
    }
    
    func testShouldValidateItemWhenTextFieldEditingEnded() {
        self.sut.forgotPasswordTextFieldCell(cell: nil, textFieldDidEndEditing: nil, itemType: ForgotPasswordModels.ItemType.email)
        XCTAssertTrue(self.interactorSpy.shouldValidateItemCalled)
    }
    
    func testShouldSelectItemWhenSendResetLinkButtonIsTouchedUpInside() {
        self.sut.forgotPasswordButtonCell(cell: nil, didSelect: nil, itemType: ForgotPasswordModels.ItemType.resetLink)
        XCTAssertTrue(self.interactorSpy.shouldSelectItemCalled)
    }
    
    // MARK: - Table view tests
    
    func testNumberOfRowsInAnySectionShouldEqualItemCount() {
        self.sut.displayedItems = [ForgotPasswordModels.Item(type: .email, model: nil)]
        let numberOfRows = self.sut.tableView(self.sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, self.sut.displayedItems.count)
    }
    
    func testNumberOfSectionsInTableViewShouldAlwaysBeOne() {
        let tableView = self.sut.tableView
        let numberOfSections = self.sut.numberOfSections(in: tableView!)
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func testCellForRowShouldReturnCorrectCellForItemType() {
        self.sut.displayedItems = [
            ForgotPasswordModels.Item(type: .email, model: nil),
            ForgotPasswordModels.Item(type: .resetLink, model: nil)
        ]
        
        let tableView = self.sut.tableView
        
        let emailCell = self.sut.tableView(tableView!, cellForRowAt: IndexPath(row: 0, section: 0))
        let resetLinkCell = self.sut.tableView(tableView!, cellForRowAt: IndexPath(row: 1, section: 0))
        
        XCTAssertTrue(emailCell is ForgotPasswordTextFieldCell)
        XCTAssertTrue(resetLinkCell is ForgotPasswordButtonCell)
    }
    
    func testShouldConfigureTextFieldCellToDisplayItems() {
        let displayedItems = [self.emailItem()]
        let tableView = self.sut.tableView
        
        self.sut.displayedItems = displayedItems
        
        displayedItems.enumerated().forEach { (index, item) in
            let cell = self.sut.tableView(tableView!, cellForRowAt: IndexPath(row: index, section: 0)) as! ForgotPasswordTextFieldCell
            
            guard let model = item.model as? ForgotPasswordModels.DisplayedTextItem else {
                return XCTAssertTrue(false, "The model must be displayed text item!")
            }
            
            XCTAssertEqual(cell.itemType, item.type)
            XCTAssertEqual(cell.titleTextFieldView.titleLabel?.attributedText?.string, model.title)
            XCTAssertEqual(cell.titleTextFieldView.textField?.attributedText?.string, model.text)
            XCTAssertEqual(cell.titleTextFieldView.textField?.attributedPlaceholder?.string, model.placeholder)
            XCTAssertEqual(cell.titleTextFieldView.errorLabel?.attributedText?.string, model.errorText)
            XCTAssertEqual(cell.titleTextFieldView.errorLabel?.isHidden, !model.displayError)
            XCTAssertEqual(cell.titleTextFieldView.textField?.keyboardType, model.keyboardType)
            XCTAssertEqual(cell.titleTextFieldView.textField.autocapitalizationType, model.autocapitalizationType)
            XCTAssertEqual(cell.titleTextFieldView.textField.autocorrectionType, model.autocorrectionType)
            XCTAssertEqual(cell.titleTextFieldView.textField?.isSecureTextEntry, model.isSecureText)
            XCTAssertEqual(cell.titleTextFieldView.textField?.returnKeyType, model.returnKeyType)
            XCTAssertNotNil(cell.delegate)
            XCTAssertNotNil(cell.titleTextFieldView.delegate)
        }
    }
    
    private func emailItem() -> ForgotPasswordModels.Item {
        let model = ForgotPasswordModels.DisplayedTextItem()
        model.title = "Email"
        model.placeholder = "Email"
        model.keyboardType = .emailAddress
        model.autocapitalizationType = .none
        model.autocorrectionType = .no
        model.errorText = "Wrong email."
        model.displayError = true
        model.returnKeyType = .continue
        return ForgotPasswordModels.Item(type: ForgotPasswordModels.ItemType.email, model: model)
    }
    
    func testShouldConfigureButtonCellToDisplayItems() {
        let displayedItems = [self.resetLinkItem()]
        let tableView = self.sut.tableView
        
        self.sut.displayedItems = displayedItems
        
        displayedItems.enumerated().forEach { (index, item) in
            let cell = self.sut.tableView(tableView!, cellForRowAt: IndexPath(row: index, section: 0)) as! ForgotPasswordButtonCell
            
            guard let model = item.model as? ForgotPasswordModels.DisplayedButtonItem else {
                return XCTAssertTrue(false, "The model must be displayed button item!")
            }
            
            XCTAssertEqual(cell.itemType, item.type)
            XCTAssertEqual(cell.button?.currentAttributedTitle, model.title)
            XCTAssertEqual(cell.button?.isEnabled, model.isEnabled)
            XCTAssertNotNil(cell.delegate)
        }
    }
    
    private func resetLinkItem() -> ForgotPasswordModels.Item {
        let model = ForgotPasswordModels.DisplayedButtonItem()
        model.title = "Send Reset Link".attributed(attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        model.isEnabled = false
        return ForgotPasswordModels.Item(type: ForgotPasswordModels.ItemType.resetLink, model: model)
    }
    
    // MARK: - Display logic tests
    
    func testDisplaySetupItems() {
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        
        let displayedItems: [ForgotPasswordModels.Item] = [ForgotPasswordModels.Item(type: .email, model: nil)]
        let viewModel = ForgotPasswordModels.SetupItems.ViewModel(displayedItems: displayedItems)
        self.sut.displaySetupItems(viewModel: viewModel)
        
        self.waitForMainQueue()
        
        XCTAssertEqual(displayedItems.count, self.sut.displayedItems.count)
        XCTAssertTrue(displayedItems.elementsEqual(self.sut.displayedItems, by: { $0 == $1 }))
        
        XCTAssertTrue(tableViewSpy.reloadDataCalled)
    }
    
    func testDisplayUpdateItem() {
        let model = ForgotPasswordModels.DisplayedTextItem()
        model.text = "old.email"
        self.sut.displayedItems = [ForgotPasswordModels.Item(type: ForgotPasswordModels.ItemType.email, model: model)]
        
        let email = "new.email"
        let viewModel = ForgotPasswordModels.UpdateItem.ViewModel(text: email, type: ForgotPasswordModels.ItemType.email)
        self.sut.displayUpdateItem(viewModel: viewModel)
        self.waitForMainQueue()
        
        guard let textModel = self.sut.displayedItemModel(type: ForgotPasswordModels.ItemType.email) as? ForgotPasswordModels.DisplayedTextItem else {
            return XCTAssertTrue(false, "The model must be displayed text item!")
        }
        XCTAssertEqual(textModel.text, email)
    }
    
    func testDisplayValidationErrorWhenThereIsNoErrorPresent() {
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        
        let model = ForgotPasswordModels.DisplayedTextItem()
        model.displayError = false
        self.sut.displayedItems = [ForgotPasswordModels.Item(type: ForgotPasswordModels.ItemType.email, model: model)]
        
        let displayError = true
        let viewModel = ForgotPasswordModels.ValidateItem.ViewModel(type: ForgotPasswordModels.ItemType.email, displayError: displayError)
        self.sut.displayValidationError(viewModel: viewModel)
        self.waitForMainQueue()
        
        guard let textModel = self.sut.displayedItemModel(type: ForgotPasswordModels.ItemType.email) as? ForgotPasswordModels.DisplayedTextItem else {
            return XCTAssertTrue(false, "The model must be displayed text item!")
        }
        XCTAssertEqual(textModel.displayError, displayError)
        XCTAssertTrue(tableViewSpy.reloadRowsCalled)
    }
    
    func testDisplayValidationErrorWhenThereIsErrorPresent() {
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        
        let model = ForgotPasswordModels.DisplayedTextItem()
        model.displayError = true
        self.sut.displayedItems = [ForgotPasswordModels.Item(type: ForgotPasswordModels.ItemType.email, model: model)]
        
        let displayError = false
        let viewModel = ForgotPasswordModels.ValidateItem.ViewModel(type: ForgotPasswordModels.ItemType.email, displayError: displayError)
        self.sut.displayValidationError(viewModel: viewModel)
        self.waitForMainQueue()
        
        guard let textModel = self.sut.displayedItemModel(type: ForgotPasswordModels.ItemType.email) as? ForgotPasswordModels.DisplayedTextItem else {
            return XCTAssertTrue(false, "The model must be displayed text item!")
        }
        XCTAssertEqual(textModel.displayError, displayError)
        XCTAssertTrue(tableViewSpy.reloadRowsCalled)
    }
    
    func testDisplayEnableItem() {
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        
        let model = ForgotPasswordModels.DisplayedButtonItem()
        model.isEnabled = false
        self.sut.displayedItems = [ForgotPasswordModels.Item(type: ForgotPasswordModels.ItemType.resetLink, model: model)]
        
        self.sut.displayEnableItem(viewModel: ForgotPasswordModels.EnableItem.ViewModel(type: ForgotPasswordModels.ItemType.resetLink))
        self.waitForMainQueue()
        
        guard let buttonModel = self.sut.displayedItemModel(type: ForgotPasswordModels.ItemType.resetLink) as? ForgotPasswordModels.DisplayedButtonItem else {
            return XCTAssertTrue(false, "The model must be displayed button item!")
        }
        XCTAssertEqual(buttonModel.isEnabled, true)
        XCTAssertTrue(tableViewSpy.reloadRowsCalled)
    }
    
    func testDisplayDisableItem() {
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        
        let model = ForgotPasswordModels.DisplayedButtonItem()
        model.isEnabled = true
        self.sut.displayedItems = [ForgotPasswordModels.Item(type: ForgotPasswordModels.ItemType.resetLink, model: model)]
        
        self.sut.displayDisableItem(viewModel: ForgotPasswordModels.EnableItem.ViewModel(type: ForgotPasswordModels.ItemType.resetLink))
        self.waitForMainQueue()
        
        guard let buttonModel = self.sut.displayedItemModel(type: ForgotPasswordModels.ItemType.resetLink) as? ForgotPasswordModels.DisplayedButtonItem else {
            return XCTAssertTrue(false, "The model must be displayed button item!")
        }
        XCTAssertEqual(buttonModel.isEnabled, false)
        XCTAssertTrue(tableViewSpy.reloadRowsCalled)
    }
    
    func testDisplayLoadingItem() {
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        
        let model = ForgotPasswordModels.DisplayedButtonItem()
        model.isLoading = false
        self.sut.displayedItems = [ForgotPasswordModels.Item(type: .resetLink, model: model)]
        
        self.sut.displayLoadingItem(viewModel: ForgotPasswordModels.LoadingItem.ViewModel(type: ForgotPasswordModels.ItemType.resetLink))
        self.waitForMainQueue()
        
        guard let buttonModel = self.sut.displayedItemModel(type: ForgotPasswordModels.ItemType.resetLink) as? ForgotPasswordModels.DisplayedButtonItem else {
            return XCTAssertTrue(false, "The model must be displayed button item!")
        }
        XCTAssertEqual(buttonModel.isLoading, true)
        XCTAssertTrue(tableViewSpy.reloadRowsCalled)
    }
    
    func testDisplayNotLoadingItem() {
        let tableViewSpy = UITableViewSpy()
        self.sut.tableView = tableViewSpy
        
        let model = ForgotPasswordModels.DisplayedButtonItem()
        model.isLoading = true
        self.sut.displayedItems = [ForgotPasswordModels.Item(type: .resetLink, model: model)]
        
        self.sut.displayNotLoadingItem(viewModel: ForgotPasswordModels.LoadingItem.ViewModel(type: ForgotPasswordModels.ItemType.resetLink))
        self.waitForMainQueue()
        
        guard let buttonModel = self.sut.displayedItemModel(type: ForgotPasswordModels.ItemType.resetLink) as? ForgotPasswordModels.DisplayedButtonItem else {
            return XCTAssertTrue(false, "The model must be displayed button item!")
        }
        XCTAssertEqual(buttonModel.isLoading, false)
        XCTAssertTrue(tableViewSpy.reloadRowsCalled)
    }
    
    func testDisplayEnableUserInteraction() {
        let tableViewSpy = UITableViewSpy()
        tableViewSpy.isUserInteractionEnabled = false
        self.sut.tableView = tableViewSpy
        self.sut.displayEnableUserInteraction()
        self.waitForMainQueue()
        XCTAssertTrue(tableViewSpy.isUserInteractionEnabled)
    }
    
    func testDisplayDisableUserInteraction() {
        let tableViewSpy = UITableViewSpy()
        tableViewSpy.isUserInteractionEnabled = true
        self.sut.tableView = tableViewSpy
        self.sut.displayDisableUserInteraction()
        self.waitForMainQueue()
        XCTAssertFalse(tableViewSpy.isUserInteractionEnabled)
    }
    
    func testDisplayConfirmationAlert() {
        let viewModel = ForgotPasswordModels.Confirmation.ViewModel(message: "Message", okTitle: "OK")
        self.sut.displayConfirmationAlert(viewModel: viewModel)
        self.waitForMainQueue()
        XCTAssertTrue(self.routerSpy.navigateToAlertCalled)
    }
    
    func testDisplayConfirmationEmailAlert() {
        let viewModel = ForgotPasswordModels.ConfirmationEmail.ViewModel(message: "Message", okTitle: "OK", goToMailTitle: "Mail")
        self.sut.displayConfirmationEmailAlert(viewModel: viewModel)
        self.waitForMainQueue()
        XCTAssertTrue(self.routerSpy.navigateToAlertCalled)
    }
    
    func testDisplayErrorAlert() {
        let viewModel = ForgotPasswordModels.ForgotPasswordError.ViewModel(message: "Error", okTitle: "OK")
        self.sut.displayErrorAlert(viewModel: viewModel)
        self.waitForMainQueue()
        XCTAssertTrue(self.routerSpy.navigateToAlertCalled)
    }
    
    func testDisplayOpenMailApplication() {
        self.sut.displayOpenMailApplication(viewModel: ForgotPasswordModels.OpenApplication.ViewModel(url: URL(string: "message://")!))
        self.waitForMainQueue()
        XCTAssertTrue(self.routerSpy.navigateToApplicationCalled)
    }
}

func ==(lhs: ForgotPasswordModels.Item, rhs: ForgotPasswordModels.Item) -> Bool {
    return lhs.type == rhs.type
}
