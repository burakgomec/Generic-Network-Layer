//
//  BaseRequestProtocol.swift
//
//
//  Created by Burak Gomec on 16.12.2023.
//

import Foundation

public protocol BaseRequestProtocol {
    associatedtype Response: Codable
    associatedtype Request = Codable

    var headers: [String: String] { get }
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPConstants.Methods { get }
    var body: Request? { get }
    var timeoutInterval: TimeInterval? { get }
    var cachePolicy: URLRequest.CachePolicy? { get }
    var contentTypes: [HTTPConstants.EncodableContentTypes] { get }
    var responseMockFileName: String? { get }
}

public extension BaseRequestProtocol {
    var asURLRequest: URLRequest? {
        guard let url = URL(string: baseURL + path) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        for headerElement in headers {
            request.addValue(headerElement.value, forHTTPHeaderField: headerElement.key)
        }
        
        if let timeoutInterval {
            request.timeoutInterval = timeoutInterval
        }
        
        if let cachePolicy {
            request.cachePolicy = cachePolicy
        }
        
        return request
    }
    
    var baseURL: String {
        ""
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var body: Codable? {
        nil
    }
    
    var timeoutInterval: TimeInterval? {
        nil
    }
    
    var cachePolicy: URLRequest.CachePolicy? {
        nil
    }
    
    var contentTypes: [HTTPConstants.EncodableContentTypes] {
        [.json]
    }
    
    var responseMockFileName: String? {
        nil
    }
}
