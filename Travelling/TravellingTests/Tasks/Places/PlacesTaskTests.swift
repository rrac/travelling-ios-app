//
//  PlacesTaskTests.swift
//  TravellingTests
//
//  Created by Dimitri Strauneanu on 13/09/2020.
//

@testable import Travelling
import XCTest
import UIKit

class PlacesTaskTests: XCTestCase {
    var sut: PlacesTask!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        self.setupSubjectUnderTest()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupSubjectUnderTest() {
        self.sut = PlacesTask(environment: .memory)
    }
    
    // MARK: - Tests
    
    func testFetchPlacesForProduction() {
        self.shouldTestFetchPlacesForEnvironment(environment: .production, operationClass: GetPlacesOperation.self)
    }
    
    func testFetchPlacesForDevelopment() {
        self.shouldTestFetchPlacesForEnvironment(environment: .development, operationClass: GetPlacesOperation.self)
    }
    
    func testFetchPlacesForMemory() {
        self.shouldTestFetchPlacesForEnvironment(environment: .memory, operationClass: GetPlacesLocalOperation.self)
    }
    
    private func shouldTestFetchPlacesForEnvironment(environment: TaskEnvironment, operationClass: AnyClass) {
        self.sut.environment = environment
        let operationQueueSpy = OperationQueueSpy()
        self.sut.fetchPlacesOperationQueue = operationQueueSpy
        self.sut.fetchPlaces(model: PlacesTaskModels.FetchPlaces.Request(page: 0, limit: 0), completionHandler: { _ in })
        XCTAssertTrue(operationQueueSpy.addOperationCalled)
        XCTAssertTrue(operationQueueSpy.addedOperation.isKind(of: operationClass))
    }
    
    func testFetchPlaceForProduction() {
        self.shouldTestFetchPlaceForEnvironment(environment: .production, operationClass: GetPlaceOperation.self)
    }
    
    func testFetchPlaceForDevelopment() {
        self.shouldTestFetchPlaceForEnvironment(environment: .development, operationClass: GetPlaceOperation.self)
    }
    
    func testFetchPlaceForMemory() {
        self.shouldTestFetchPlaceForEnvironment(environment: .memory, operationClass: GetPlaceLocalOperation.self)
    }
    
    private func shouldTestFetchPlaceForEnvironment(environment: TaskEnvironment, operationClass: AnyClass) {
        self.sut.environment = environment
        let operationQueueSpy = OperationQueueSpy()
        self.sut.fetchPlaceOperationQueue = operationQueueSpy
        self.sut.fetchPlace(model: PlacesTaskModels.FetchPlace.Request(placeId: "placeId"), completionHandler: { _ in })
        XCTAssertTrue(operationQueueSpy.addOperationCalled)
        XCTAssertTrue(operationQueueSpy.addedOperation.isKind(of: operationClass))
    }
    
    func testFetchPlaceCommentsForProduction() {
        self.shouldTestFetchPlaceCommentsForEnvironment(environment: .production, operationClass: GetPlaceCommentsOperation.self)
    }
    
    func testFetchPlaceCommentsForDevelopment() {
        self.shouldTestFetchPlaceCommentsForEnvironment(environment: .development, operationClass: GetPlaceCommentsOperation.self)
    }
    
    func testFetchPlaceCommentsForMemory() {
        self.shouldTestFetchPlaceCommentsForEnvironment(environment: .memory, operationClass: GetPlaceCommentsLocalOperation.self)
    }
    
    private func shouldTestFetchPlaceCommentsForEnvironment(environment: TaskEnvironment, operationClass: AnyClass) {
        self.sut.environment = environment
        let operationQueueSpy = OperationQueueSpy()
        self.sut.fetchPlaceCommentsOperationQueue = operationQueueSpy
        self.sut.fetchPlaceComments(model: PlacesTaskModels.FetchPlaceComments.Request(placeId: "placeId", page: 0, limit: 10), completionHandler: { _ in })
        XCTAssertTrue(operationQueueSpy.addOperationCalled)
        XCTAssertTrue(operationQueueSpy.addedOperation.isKind(of: operationClass))
    }
}
