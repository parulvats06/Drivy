//
//  CarDetailViewControllerTests.swift
//  DrivyTests
//
//  Created by parul vats on 29/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import XCTest
@testable import Drivy

class CarDetailViewControllerTests: XCTestCase {

    var window: UIWindow!
    var sut: CarDetailViewController!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
       
        sut = CarDetailViewController(car: getDummyCar())
        // Given
        loadView(sut.view)
        
        // When
        sut.viewDidLoad()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    func loadView(_ view: UIView) {
        window.addSubview(view)
        RunLoop.current.run(until: Date())
    }
    
    func testFetchCarListUI() {
        // When finished fetching
        let cell0 = sut.tableView(sut.carDetailsTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CarTableViewCell
        XCTAssertEqual(cell0?.brandNameLabel.text, "Audi")
        let cell1 = sut.tableView(sut.carDetailsTableView, cellForRowAt: IndexPath(row: 0, section: 1)) as? CarOwnerTableViewCell
        XCTAssertEqual(cell1?.ownerNameLabel.text, "Parul")
    }
    
    func testHasATableView() {
        XCTAssertNotNil(sut.carDetailsTableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(sut.carDetailsTableView.delegate)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(sut.carDetailsTableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.numberOfSections(in:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
    }

    func getDummyCar() -> Car {
        let carRating = Rating(average: 22.7, count: 6)
        let ownerRating = Rating(average: 32, count: 10)
        let owner = Owner(name: "Parul", pictureUrl: "", rating: ownerRating)
        let car = Car(brand: "Audi", model: "Q7", pictureUrl: "", pricePerDay: 23.0, rating: carRating, owner: owner)
        return car
    }

}
