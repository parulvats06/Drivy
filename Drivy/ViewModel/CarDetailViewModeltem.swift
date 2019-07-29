//
//  CarDetailViewModeltem.swift
//  Drivy
//
//  Created by parul vats on 29/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import Foundation

enum CarDetailViewModeltemType {
    case carBasicInfo
    case carOwner
}

protocol CarDetailViewModeltem {
    var type: CarDetailViewModeltemType { get }
    var rowCount: Int { get }
}

// MARK: - default implementation
extension CarDetailViewModeltem {
    var rowCount: Int {
        return 1
    }
}

class CarViewModelBasicInfoItem: CarDetailViewModeltem {
    var type: CarDetailViewModeltemType {
        return .carBasicInfo
    }
    
    var rating: Rating
    var carImageUrl: String
    var brandName: String
    var pricePerDay: Double
    
    init(brandName: String, carImageUrl: String, rating: Rating, price: Double) {
        self.brandName = brandName
        self.carImageUrl = carImageUrl
        self.rating = rating
        self.pricePerDay = price
    }
}

class CarViewModelOwnerItem: CarDetailViewModeltem {
    var type: CarDetailViewModeltemType {
        return .carOwner
    }
    
    var rating: Rating
    var ownerImageUrl: String
    var name: String
    
    init(owner: Owner) {
        self.name = owner.name
        self.ownerImageUrl = owner.pictureUrl
        self.rating = owner.rating
    }
}

