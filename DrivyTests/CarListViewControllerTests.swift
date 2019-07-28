//
//  CarListViewControllerTests.swift
//  DrivyTests
//
//  Created by parul vats on 28/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import XCTest
@testable import Drivy

class CarListViewControllerTests: XCTestCase {
    
    var window: UIWindow!
    var mockAPIService: MockApiService!
    var sut: CarListViewController!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        mockAPIService = MockApiService()
        sut = CarListViewController()
        sut.carListViewModel = CarListViewModel(apiService: mockAPIService)
        loadView(sut.view)
        sut.viewDidLoad()
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    func loadView(_ view: UIView) {
        window.addSubview(view)
        RunLoop.current.run(until: Date())
    }

    func testFetchCarListUI() {
        // Given
       mockAPIService.completeAvailableCars = StubGenerator().stubCars()
        loadView(sut.view)
        
        // When
        sut.viewDidLoad()
        
        // When finished fetching
        mockAPIService.fetchAvailableCarsSuccess()
        sut.carsTableView.reloadData()
        let cell0 = sut.tableView(sut.carsTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CarTableViewCell
        XCTAssertEqual(cell0?.brandNameLabel.text, "Citroen")
        let cell1 = sut.tableView(sut.carsTableView, cellForRowAt: IndexPath(row: 0, section: 1)) as? CarTableViewCell
        XCTAssertEqual(cell1?.starView.ratingCountLabel.text, "250")

        let cell2 = sut.tableView(sut.carsTableView, cellForRowAt: IndexPath(row: 0, section: 2)) as? CarTableViewCell
        XCTAssertEqual(cell2?.brandNameLabel.text, "Seat")
    }
    
    func testHasATableView() {
        XCTAssertNotNil(sut.carsTableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(sut.carsTableView.delegate)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(sut.carsTableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.numberOfSections(in:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
    }
}
