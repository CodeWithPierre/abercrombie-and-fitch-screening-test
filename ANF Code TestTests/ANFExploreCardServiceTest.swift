//
//  ANFExploreCardServiceTest.swift
//  ANF Code TestTests
//
//  Created by Pierre ILYAMUKURU on 1/18/25.
//

import XCTest
@testable import ANF_Code_Test

class ANFExploreCardServiceTest: XCTestCase {
    var mockSession: MockURLSession!
    var service: ANFExploreCardService!
    
    override func setUp() {
        super.setUp()
        self.mockSession = MockURLSession()
        self.service = ANFExploreCardService(session: mockSession)
    }
    
    override func tearDown() {
        service = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testGetANFExploreCard_InvalidURL() {
        let expectation = self.expectation(description: "Invalid URL error")
        let invalidURLService = ANFExploreCardService(urlString: "invalid URL string provided",
                                                      session: mockSession)
        invalidURLService.getANFExploreCard { result in
            switch result {
            case .success:
                XCTFail("Expected failure due to invalid URL.")
            case .failure(let error):
                XCTAssertEqual(error, ANFExploreCardError.serviceError)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetANFExploreCard_Success() {
        let expectation = self.expectation(description: "Successful")
        let expectedExploreCard = [
            ANFExploreCard(title: "TOPS STARTING AT $12", backgroundImage: "image.jpg", content: [], promoMessage: "Promo", topDescription: "A&F Essentials", bottomDescription: "Details")
        ]
        mockSession.mockData = try? JSONEncoder().encode(expectedExploreCard)
        mockSession.mockError = nil
        
        service.getANFExploreCard { result in
            switch result {
            case .success(let cards):
                XCTAssertEqual(cards.count, 10)
                XCTAssertEqual(cards.first?.title, "TOPS STARTING AT $12")
            case .failure(let error):
                XCTFail("Expected success but got error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var mockError: Error?
    var mockResponse: URLResponse?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        DispatchQueue.main.async {
            completionHandler(self.mockData, self.mockResponse, self.mockError)
        }
        return MockURLSessionDataTask()
    }
}

class MockURLSessionDataTask: URLSessionDataTask, @unchecked Sendable {
    override func resume() {
    }
}
