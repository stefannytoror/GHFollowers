//
//  ServiceProvider.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 27/07/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import Foundation
import os.log

protocol ServiceProtocol {
    func request<T: Codable>(type: ServiceRequestBuilder, completion: @escaping (Result<T,Error>) -> Void)
    static func requestImage(url: String, completion: @escaping (Result<Data,Error>)-> Void)
}

typealias ServiceResponse = (response: HTTPURLResponse?, data: Data?, error: Error?)

struct ServiceManager: ServiceProtocol {
    func request<T: Codable>(type: ServiceRequestBuilder, completion: @escaping (Result<T,Error>) -> Void) {
        guard let urlRequest = buildURL(route: type) else {
            completion(.failure(ServiceRequestError.failBuildingURL))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error  in
            let serviceResponse = ServiceResponse(response as? HTTPURLResponse, data, error)
            self.manageResponse(response: serviceResponse) { (result: Result<T, Error>) in
                completion(result)
            }
        }
        dataTask.resume()
    }

    private func buildURL(route: ServiceRequestBuilder) -> URLRequest? {
        guard let url = URL(string: route.path) else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = route.commonHeaders
        urlRequest.httpMethod = route.method
        return urlRequest
    }

    private func manageResponse<T: Codable>(response: ServiceResponse, completion: @escaping (Result<T,Error>)-> Void) {
        guard let httpResponse = response.response , let jsonData = response.data else {
            completion(.failure(ServiceRequestError.noResponse(error: response.error)))
            return
        }

        switch httpResponse.statusCode {
        case 200:
            //TODO: create custom os_log
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: jsonData)
                os_log("Success statusCode: 200")
                completion(.success(responseObject))

            } catch let e {
                os_log("Failure %@", "\(e)")
                completion(.failure(ServiceRequestError.failDecodingResponse(error: e)))
            }
        case 404:
            completion(.failure(ServiceRequestError.noValidResponse(error: response.error)))
        default:
            completion(.failure(ServiceRequestError.unknown))
        }
    }

    //MARK: - Request Images
    static func requestImage(url: String, completion: @escaping (Result<Data,Error>)-> Void) {
        guard let imageUrl = URL(string: url) else {
            completion(.failure(ServiceRequestError.failBuildingURL))
            return
        }

        // Use URLSession instead of Data(contentsOf:) for not block main thread
        let dataTask = URLSession.shared.dataTask(with: imageUrl) { data, response, error  in
            guard let data = data else {
                completion(.failure(ServiceRequestError.noResponse(error: error)))
                return
            }
            completion(.success(data))

        }
        dataTask.resume()
    }
}
