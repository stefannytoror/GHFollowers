//
//  MockServiceManager.swift
//  GHFollowersTests
//
//  Created by Stefanny Toro Ramirez on 25/09/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import Foundation
@testable import GHFollowers

class MockServiceManager: ServiceProtocol {
    var CalledMethods: [Methods] = []
    var result: Followers = []
    var isSuccessfull = false

    enum Methods {
        case request
        case successRequest
        case failureRequest
    }

    func reset() {
        CalledMethods = []
    }

    func request<T: Codable>(type: ServiceRequestBuilder, completion: @escaping (Result<T, Error>) -> Void) {
        reset()
        CalledMethods.append(.request)

        if isSuccessfull {
            completion(.success(result as! T))
            CalledMethods.append(.successRequest)
        } else {
            completion(.failure(MockError.testing))
            CalledMethods.append(.failureRequest)
        }
    }

    static func requestImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        //TODO
    }

}
