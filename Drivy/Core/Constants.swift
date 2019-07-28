//
//  Constants.swift
//  Drivy
//
//  Created by parul vats on 28/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import Foundation

struct Constants {
    
    struct CellIdentifiers {
        static let carCellIdentifier = "CarCellIdentifier"
    }
    
    struct NibIdentifiers {
        static let carTableViewCell = "CarTableViewCell"
    }
    
    struct Defaults {
        static let baseUrl = "https://raw.githubusercontent.com/drivy/jobs/master/android/api/"
        static let country = "nl"
        static let currencyCode = "EUR"
    }
    
    enum HTTPHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
}

