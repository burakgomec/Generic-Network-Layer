//
//  NetworkLayer.swift
//
//
//  Created by Burak Gomec on 16.12.2023.
//

import UIKit

public final class NetworkLayer {
    public static let shared = NetworkLayer()

    public func send<T: BaseRequestProtocol>(_ request: T, result: @escaping (Result<T.Response, NetworkErrorModel>) -> Void){
        guard var urlRequest = request.asURLRequest else { return result(.failure(NetworkErrorModel(errorType: .invalidURL))) }
        
        if let params = request.body as? Encodable {
            do {
                urlRequest.httpBody = try JSONEncoder().encode(params)
            }
            catch let error as NSError {
                result(.failure(.init(errorType: .encode(error))))
            }
            
            request.contentTypes.forEach {
                urlRequest.setValue($0.rawValue, forHTTPHeaderField: "Content-Type")
            }
        }

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                return result(.failure(.init(errorType: .unknown(error))))
            }
    
            guard let data, let response = response as? HTTPURLResponse else {
                return result(.failure(.init(errorType: .noResponse)))
            }

            switch response.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(T.Response.self, from: data)
                    result(.success(decodedResponse))
                } catch let error as NSError {
                    result(.failure(.init(errorType: .decode(error))))
                }
            case 400:
                return result(.failure(.init(errorType: .badRequest)))
            case 401:
                return result(.failure(.init(errorType: .unauthorized)))
            default:
                return result(.failure(.init(errorType: .unexpectedStatusCode)))
            }
        }
        .resume()
    }
    
    private init () { }
}
