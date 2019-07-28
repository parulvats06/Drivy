//
//  APIService.swift
//  Drivy
//
//  Created by parul vats on 28/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noNetwork:
            return NSLocalizedString("No Network", comment: "No Network")
        case .serverOverload:
            return NSLocalizedString("Server is overloaded", comment: "Server is overloaded")
        }
    }
}

protocol APIServiceProtocol {
    func fetchAvailableCars(completion: @escaping ([Car]?, Error?) -> Void)
}

class APIService: APIServiceProtocol {
    func fetchAvailableCars(completion: @escaping ([Car]?, Error?) -> Void) {
        let url = Endpoint.cars
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseData(completionHandler: { (response) in
                switch response.result {
                case .success:
                    do {
                        let results = try JSONDecoder().decode([Car].self, from: response.data!)
                        completion(results, nil)
                    } catch let err {
                        print(err)
                    }
                case let .failure(error):
                    completion(nil, error)
                }
            })
    }
}







