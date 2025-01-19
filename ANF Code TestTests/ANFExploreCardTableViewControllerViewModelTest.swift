//
//  ANFExploreCardTableViewControllerViewModelTest.swift
//  ANF Code TestTests
//
//  Created by Pierre ILYAMUKURU on 1/18/25.
//

import XCTest
@testable import ANF_Code_Test

class ANFExploreCardTableViewControllerViewModelTest: XCTestCase {
    var viewModel: ANFExploreCardTableViewControllerViewModel!
    var mockService: MockANFExploreCardService!
    
    override func setUp() {
        super.setUp()
        mockService = MockANFExploreCardService()
        viewModel = ANFExploreCardTableViewControllerViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testGetExploreCard_Success() {
        let expectedExploreCard = [
            ANFExploreCard(title: "TOPS STARTING AT $12", backgroundImage: "image.jpg", content: [], promoMessage: "Promo", topDescription: "A&F Essentials", bottomDescription: "Details")
        ]
        mockService.result = .success(expectedExploreCard)
        
        let expectation = self.expectation(description: "Data fetched successfully")
        viewModel.getExploreCard { error in
            XCTAssertNil(error, "Fetched successfully")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetExploreCard_Failure() {
        mockService.result = .failure(.serviceError)
        let expectation = self.expectation(description: "Error occurred")
        viewModel.getExploreCard { error in
            XCTAssertNotNil(error, "Error occurred")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}

class MockANFExploreCardService: ANFExploreCardServiceProtocol {
    var result: Result<[ANFExploreCard], ANFExploreCardError>?
    
    func getANFExploreCard(completion: @escaping (Result<[ANFExploreCard], ANFExploreCardError>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
