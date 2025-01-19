//
//  ANF_Code_TestTests.swift
//  ANF Code TestTests
//

import XCTest
@testable import ANF_Code_Test

class ANFExploreCardTableViewControllerTests: XCTestCase {
    
    var test: ANFExploreCardTableViewController!
    let mockData =
    [ANFExploreCard(
        title: "TOPS STARTING AT $12",
        backgroundImage: "anf-20160527-app-m-shirts.jpg",
        content: [
            ANFExploreCard.Content(target: "https://www.abercrombie.com/shop/us/mens-new-arrivals", title: "Shop Men")
        ],
        promoMessage: "USE CODE: 12345",
        topDescription: "A&F ESSENTIALS",
        bottomDescription: "*In stores & online. <a href=\\\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html\\\">Exclusions apply. See Details</a>"
    )]
    
    override func setUp() {
        super.setUp()
        test = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as? ANFExploreCardTableViewController
    }
    
    func testTableViewExists() {
        XCTAssertNotNil(test.tableView, "The table view should exist.")
    }
    
    func testViewControllerDisplayData() {
        test.viewModel.exploreCard = mockData
        test.tableView.reloadData()
        waitForTableViewToLoad()
        let numberOfRows = test.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, test.viewModel.exploreCard.count, "Table view should have \(test.viewModel.exploreCard.count) cells")
    }
    
    func test_numberOfSections_ShouldBeOne() {
        let numberOfSections = test.numberOfSections(in: test.tableView)
        XCTAssert(numberOfSections == 1, "Table view should have 1 section")
    }
    
    func test_numberOfRows_ShouldBeTen() {
        let numberOfRows = test.tableView(test.tableView, numberOfRowsInSection: 0)
        XCTAssert(numberOfRows == test.viewModel.exploreCard.count, "Table view should have \(test.viewModel.exploreCard.count)")
    }
    
    func test_cellForRowAtIndexPath_ImageViewImage_shouldNotBeNil() {
        let cell = getCellForRow(at: IndexPath(row: 0, section: 0))
        guard let imageView = cell.backgroundImageView.image else {
            XCTFail("Image view image should not be nil")
            return
        }
        XCTAssertNotNil(imageView, "Image view image should not be nil")
    }
    
    func test_topDescriptionLabel_shouldNotBeBlank() {
        let cell = getCellForRow(at: IndexPath(row: 0, section: 0))
        guard let topDescriptionText = cell.topDescriptionLabel.text else {
            XCTFail("Top description label text should not be nil")
            return
        }
        
        XCTAssertFalse(topDescriptionText.isEmpty, "Top description label text should not be blank")
    }
    
    func test_titleLabel_shouldNotBeBlank() {
        let cell = getCellForRow(at: IndexPath(row: 0, section: 0))
        guard let titleLabelText = cell.titleLabel.text else {
            XCTFail("Title label text should not be nil")
            return
        }
        
        XCTAssertFalse(titleLabelText.isEmpty, "Title label text should not be blank")
    }
    
    private func waitForTableViewToLoad() {
        let expectation = self.expectation(description: "Wait for table view to reload")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    private func configureCell(_ cell: ANFExploreCardTableViewCell) {
        cell.configure(
            topDescription: "TOPS STARTING AT $12",
            title: "A&F ESSENTIALS",
            promoMessage: "USE CODE: 12345",
            bottomDescription: "*In stores & online. <a href=\\\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html\\\">Exclusions apply. See Details</a>",
            image: "anf-20160527-app-m-shirts.jpg",
            shopMenButtonTitle: "Shop Men",
            shopWomenButtonTitle: "Shop Women"
        )
    }
    
    private func getCellForRow(at indexPath: IndexPath) -> ANFExploreCardTableViewCell {
        test.viewModel.exploreCard = mockData
        test.tableView.reloadData()
        waitForTableViewToLoad()
        
        guard let cell = test.tableView.cellForRow(at: indexPath) as? ANFExploreCardTableViewCell else {
            XCTFail("Cell at index path \(indexPath) should not be nil")
            fatalError("Cell should not be nil")
        }
        
        configureCell(cell)
        cell.layoutIfNeeded()
        
        return cell
    }
}
