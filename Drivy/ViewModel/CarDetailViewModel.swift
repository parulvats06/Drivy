//
//  CarDetailViewModel.swift
//  Drivy
//
//  Created by parul vats on 29/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import Foundation

class CarDetailViewModel {
    
    private var carItems: [CarDetailViewModeltem] = [CarDetailViewModeltem]() {
        didSet {
            self.reloadTableClosure?()
        }
    }
    
    var carItemsList: [CarDetailViewModeltem] {
        return carItems
    }
    
    var reloadTableClosure: (()->())?
    
    func loadCarItems(carModel: Car) {
        var items: [CarDetailViewModeltem] = [CarDetailViewModeltem]()
        // order in which needs to be shown
        let carBasicInfoItem = CarViewModelBasicInfoItem(brandName: carModel.brand, carImageUrl: carModel.pictureUrl, rating: carModel.rating, price: carModel.pricePerDay)
        items.append(carBasicInfoItem)
        let carOwnerItem = CarViewModelOwnerItem(owner: carModel.owner)
        items.append(carOwnerItem)
        carItems = items
    }
    
}
