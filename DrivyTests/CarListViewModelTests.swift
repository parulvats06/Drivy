//
//  CarListViewModelTests.swift
//  DrivyTests
//
//  Created by parul vats on 28/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import XCTest
@testable import Drivy

class CarListViewModelTests: XCTestCase {

    var sut: CarListViewModel!
    var mockAPIService: MockApiService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockApiService()
        sut = CarListViewModel(apiService: mockAPIService)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }

    func testFetchAvailableCars() {
        // Given
        mockAPIService.completeAvailableCars = [Car]()
        
        // When
        sut.fetchCars()
        // Assert
        XCTAssert(mockAPIService.isFetchAvailableCarsCalled)
    }
    
    func testFetchNearbyRestaurantsError() {
        
        // Given a failed fetch with a certain failure
        let error = APIError.noNetwork
        
        // When
        sut.fetchCars()
        
        mockAPIService.fetchCompleteAvailableCarsFail(error: error)
        // Sut should display predefined error message
        XCTAssertEqual( sut.alertMessage, error.rawValue )
        
    }
    
    func testLoadingWhileFetching() {
        //Given
        var loadingStatus = false
        let expect = XCTestExpectation(description: "Loading status updated")
        sut.updateLoadingStatus = { [weak sut] in
            loadingStatus = sut!.isLoading
            expect.fulfill()
        }
        
        //when fetching
        sut.fetchCars()
        
        // Assert
        XCTAssertTrue(loadingStatus)
        
        // When finished fetching
        mockAPIService.fetchAvailableCarsSuccess()
        XCTAssertFalse(loadingStatus )
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testCreateModel() {
        // Given
        let cars = StubGenerator().stubCars()
        mockAPIService.completeAvailableCars = cars
        let expect = XCTestExpectation(description: "reload closure triggered")
        sut.reloadTableClosure = { () in
            expect.fulfill()
        }
        
        // When
        sut.fetchCars()
        mockAPIService.fetchAvailableCarsSuccess()
        
        // Number of cell view model is equal to the number of photos
        XCTAssertEqual( sut.carList.count, cars.count )
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
        
    }
}

class MockApiService: APIServiceProtocol {
    var isFetchAvailableCarsCalled = false
    var completeAvailableCars: [Car] = [Car]()
    var completeAvailableCarsClosure: (([Car]?, Error?) -> ())!
    
    func fetchAvailableCars(completion: @escaping ([Car]?, Error?) -> Void) {
        isFetchAvailableCarsCalled = true
        completeAvailableCarsClosure = completion
    }
    
    func fetchAvailableCarsSuccess() {
        completeAvailableCarsClosure(completeAvailableCars, nil)
    }
    
    func fetchCompleteAvailableCarsFail(error: Error?) {
        completeAvailableCarsClosure(completeAvailableCars, error )
    }
}

class StubGenerator {
    func stubCars() -> [Car] {
        let path = Bundle.main.path(forResource: "cars", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let cars = try! decoder.decode([Car].self, from: data)
        return cars
    }
}
