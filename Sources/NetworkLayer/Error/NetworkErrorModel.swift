//
//  NetworkErrorModel.swift
//
//
//  Created by Burak Gomec on 16.12.2023.
//

import Foundation

open class NetworkErrorModel: Error {
    public var errorType: NetworkErrorEnum?
    
    public init(errorType: NetworkErrorEnum) {
        self.errorType = errorType
    }
}

public extension NetworkErrorModel {
    enum NetworkErrorEnum {
        case encode(_ NSError: NSError)
        case decode(_ NSError: NSError)
        case invalidURL
        case unknown(_ error: Error?)
        case unexpectedStatusCode
        case noResponse
        case badRequest
        case unauthorized
    }
}
