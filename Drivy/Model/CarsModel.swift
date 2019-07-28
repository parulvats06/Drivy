//
//  CarsModel.swift
//  Drivy
//
//  Created by parul vats on 28/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import Foundation

struct Car: Codable {
    let brand: String
    let model: String
    let pictureUrl: String
    let pricePerDay: Double
    let rating: Rating
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case brand, model, rating, owner
        case pictureUrl = "picture_url"
        case pricePerDay = "price_per_day"
    }
}

struct Rating: Codable {
    let average: Double
    let count: Int
}

struct Owner: Codable {
    let name: String
    let pictureUrl: String
    let rating: Rating
    
    enum CodingKeys: String, CodingKey {
        case name, rating
        case pictureUrl = "picture_url"
    }
}



