//
//  CarListViewModel.swift
//  Drivy
//
//  Created by parul vats on 28/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import Foundation

class CarListViewModel {
    private let apiService: APIServiceProtocol
    
    private var cars: [Car] = [Car]() {
        didSet {
            self.reloadTableClosure?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var carList: [Car] {
        return cars
    }
    
    var reloadTableClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchCars() {
        self.isLoading = true
        apiService.fetchAvailableCars { [weak self] (cars, error) in
            self?.isLoading = false
            if let error = error {
                self?.alertMessage = error.localizedDescription
            } else {
                guard let cars = cars else {
                    return
                }
                self?.cars = cars
            }
        }
    }
}
