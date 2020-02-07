//
//  TheHoneymoonPlannerTests.swift
//  TheHoneymoonPlannerTests
//
//  Created by Jerry haaser on 2/7/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import XCTest
@testable import TheHoneymoonPlanner

class TheHoneymoonPlannerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNumberOfRows() {
        let restaurantTableViewController = SettingsViewController()
        let wishlistController = WishlistController()
        let wishlistResults = wishlistController.loadWishlistFromPersistentStore()
        let wishlistItems = wishlistResults.count
        let sectionInfo = restaurantTableViewController.wishlistFetchedResultsController.sections
        //let sectionInfo = restaurantTableViewController.fetchedResultsController.sections
        let numberOfRows = sectionInfo?.compactMap { $0.numberOfObjects }
        XCTAssertEqual(numberOfRows?.count, wishlistItems)
    }

}
