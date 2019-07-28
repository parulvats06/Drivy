//
//  APIConfiguration.swift
//  Drivy
//
//  Created by parul vats on 28/07/2019.
//  Copyright © 2019 SmartSum. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

enum Endpoint: APIConfiguration {
    
    case cars
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .cars:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .cars:
            return "cars.json"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .cars:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let base = URL(string: Constants.Defaults.baseUrl)!
        let baseAppend = base.appendingPathComponent(path).absoluteString.removingPercentEncoding
        
        let url = URL(string: baseAppend!)
        var urlRequest = URLRequest(url: url!)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        // set header fields
        urlRequest.setValue(Constants.ContentType.json.rawValue,
                            forHTTPHeaderField: Constants.HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue,
                            forHTTPHeaderField: Constants.HTTPHeaderField.acceptType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}

