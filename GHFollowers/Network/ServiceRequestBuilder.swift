//
//  ServiceRequestConstants.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 27/07/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import Foundation

struct ServiceRequestConstants {
    static let baseURL = "https://api.github.com"
    static let acceptHeaderKey = "Accept"
    static let acceptHeaderValue = "application/vnd.github.v3+json"

    enum Path: String {
        case users = "/users/"
        case followers = "/followers"
    }
}


enum ServiceRequestBuilder {
    case getFollowersFor(user: String)
    case getUser(name: String)

    var commonHeaders: [String: String] {
        return [ServiceRequestConstants.acceptHeaderKey: ServiceRequestConstants.acceptHeaderValue]
    }

    var path: String {
        switch self {
        case .getFollowersFor(let user):
            return ServiceRequestConstants.baseURL + ServiceRequestConstants.Path.users.rawValue + user + ServiceRequestConstants.Path.followers.rawValue
        case .getUser(let user):
            return ServiceRequestConstants.baseURL + ServiceRequestConstants.Path.users.rawValue + user
        }
    }

    var method: String {
        // Default Method
        return "GET"
    }
}
